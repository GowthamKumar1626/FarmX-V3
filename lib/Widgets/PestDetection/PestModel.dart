import 'dart:io';

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Widgets/PestDetection/PestDiseaseDetails.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class PestModel extends StatefulWidget {
  PestModel({
    required this.modelPath,
    required this.labelPath,
    required this.numResults,
  });
  final String modelPath;
  final String labelPath;
  final int numResults;
  @override
  _PestModelState createState() => _PestModelState();
}

class _PestModelState extends State<PestModel> {
  var _image;

  final imagePicker = ImagePicker();

  var _output;
  String? disease;
  String? confidence;
  bool _loading = true;

  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    // load TFLite Model
    loadModel().then((value) {});
  }

// Function to perform TFLite Inference
  Future classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 127.5, // defaults to 117.0
        imageStd: 127.5, // defaults to 1.0
        numResults: 4, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    setState(() {
      // set our global variable equal to local variable
      _output = output;
      _loading = false;
      print(_output);
      confidence = _output != null
          ? (_output![0]['confidence'] * 100.0).toString().substring(0, 3) + "%"
          : " ";

      disease = _output![0]['label'];
    });
    print("prediction: $_output");
  }

  // Function to Load Model
  Future loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/apple_model/apple_model.tflite",
      labels: "assets/models/apple_model/labels.txt",
      // model: 'assets/models/model.tflite',
      // labels: 'assets/models/labels.txt',
    );
  }

  @override
  void dispose() {
    super.dispose();
    // helps avoid memory leaks
    Tflite.close();
  }

  Future pickImage() async {
    final image = await picker.getImage(source: ImageSource.camera);

    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  // Function to pick image - using gallery
  Future pickGalleryImage() async {
    // load image from source - camera/gallery
    var image = await picker.getImage(source: ImageSource.gallery);

    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });

    // classify image
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "About",
                  style: kTopHeadingStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: new Column(
                  children: <Widget>[
                    new Text(
                      "Pest Detection is a powerful tool designed using AI. It detects around 38 different pests.",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "How to use",
                  style: kTopHeadingStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.8,
                child: new Column(
                  children: <Widget>[
                    new Text(
                      "1. Click on the camera button shown below.  ",
                      textAlign: TextAlign.left,
                    ),
                    new Text("2. Capture the part of plant effected by pest.",
                        textAlign: TextAlign.left),
                    new Text(
                        "3. Run the test.                                                 ",
                        textAlign: TextAlign.left),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Center(
              // ignore: unnecessary_null_comparison
              child: _image == null
                  ? Text(
                      "No image Selected",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Image.file(
                          _image,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 450,
                          scale: 0.8,
                        ),
                        Text("Confidence: $confidence"),
                        Text("Disease: $disease"),
                      ],
                    ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: Icon(Icons.add_a_photo),
                label: Text("Capture Image"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => kGreen,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: pickGalleryImage,
                icon: Icon(Icons.album),
                label: Text("Choose from Gallery"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => kGreen,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PestDetails extends StatelessWidget {
  final String disease;
  PestDetails({required this.disease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Details of the disease'),
      ),
      body: new Container(
        child: new Text(diseaseDetails[disease]),
      ),
    );
  }
}
