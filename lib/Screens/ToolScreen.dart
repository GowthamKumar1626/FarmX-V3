import 'dart:ui';

import 'package:farmx/CommonWidgets/CategoryButton.dart';
import 'package:farmx/CommonWidgets/ThemeTemplate.dart';
import 'package:farmx/Screens/CurrentWeather.dart';
import 'package:farmx/Screens/UserProfileScreen.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Services/database.dart';
import 'package:farmx/Widgets/CoFarming/CoFarmingWidget.dart';
import 'package:farmx/Widgets/CropSuggestion/CropSuggestionWidget.dart';
import 'package:farmx/Widgets/FertilizerSuggestion/FertilizerSuggestionWidget.dart';
import 'package:farmx/Widgets/GeneralCropInfo/GeneralCropInfoWidget.dart';
import 'package:farmx/Widgets/PestDetection/PestDetectionWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Constants.dart';
import '../Constants/Tools.dart';

class ToolScreen extends StatefulWidget {
  @override
  _ToolScreenState createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  String title = "Pest Detection";
  int currentIndex = 0; //Walk through features
  Widget toolWidget = PestDetectionWidget();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return ThemeTemplate(
      title: "Home",
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Provider<Database>(
                  create: (_) => FireStoreDatabase(uid: auth.currentUser!.uid),
                  builder: (context, child) => UserProfileScreen(),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.008,
            ),
            child: Image(
              image: AssetImage("assets/icons/settings.png"),
              width: 30,
              height: 30,
              color: Colors.white,
            ),
          ),
        ),
      ],
      childPosition: MediaQuery.of(context).size.height * 0.08,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CurrentWeatherPage(),
          Text(
            '$title',
            style: kGreetingsStyle,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 70.0,
                  child: new ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: toolIcons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ToolContainer(
                        index: index,
                        getCurrentIndex: () => currentIndex,
                        setCurrentIndex: () {
                          setState(
                            () {
                              currentIndex = index;
                              title = toolIcons[index].name;
                              switch (title) {
                                case "Pest Detection":
                                  toolWidget = PestDetectionWidget();
                                  break;
                                case "Fertilizer":
                                  toolWidget = FertilizerSuggestionWidget();
                                  break;
                                case "Crop Suggestion":
                                  toolWidget = CropSuggestionWidget();
                                  break;
                                case "General Crop-Info":
                                  toolWidget = GeneralCropInfoWidget();
                                  break;
                                case "Co-Farming":
                                  toolWidget = CoFarmingWidget();
                                  break;

                                default:
                                  toolWidget = Container(
                                    child: Text(
                                      "Tool will be implemented Soon!",
                                      style: kDefaultStyle,
                                    ),
                                  );
                              }
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: toolWidget,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ToolContainer extends StatelessWidget {
  final int index;
  final VoidCallback setCurrentIndex;
  final Function() getCurrentIndex;

  ToolContainer({
    required this.index,
    required this.getCurrentIndex,
    required this.setCurrentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return CategoryButton(
      image: AssetImage(toolIcons[index].imgPath),
      color: toolIcons[index].color,
      onPressed: () => setCurrentIndex(),
      isSelected: getCurrentIndex() == index,
    );
  }
}
