import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ProfileAvatar.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ProfileAvatar(
                  imageUrl:
                      "https://img.republicworld.com/republic-prod/stories/promolarge/xhdpi/e5uz3hohacjxhdga_1595409485.jpeg"),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText:
                        "Hello ${user.displayName == "" ? "user," : user.displayName} What's on your mind?",
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 10.0,
            thickness: 0.5,
          ),
          _buildPostIcons(height, width),
        ],
      ),
    );
  }

  Widget _buildPostIcons(double height, double width) {
    return Container(
      height: height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.mic,
              color: Colors.blue,
            ),
            label: Text("Audio"),
          ),
          VerticalDivider(
            width: width * 0.0155,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.videocam,
              color: Colors.red,
            ),
            label: Text("Live"),
          ),
          VerticalDivider(
            width: width * 0.0155,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.photo_library,
              color: Colors.amber,
            ),
            label: Text("Photo"),
          ),
          VerticalDivider(
            width: width * 0.0155,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.video_collection,
              color: Colors.green,
            ),
            label: Text("Video"),
          ),
        ],
      ),
    );
  }
}
