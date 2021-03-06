import 'package:farmx/CommonWidgets/ThemeTemplate.dart';
import 'package:farmx/Screens/Posts/Widgets/PostContainer.dart';
import 'package:farmx/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/PostModel.dart';
import 'Widgets/PostFeedContainer.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    User? user = auth.currentUser;
    return ThemeTemplate(
      title: "Posts",
      childPosition: MediaQuery.of(context).size.height * 0.06,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          PostContainer(
            user: user!,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                final Post post = posts[index];
                return PostFeedContainer(post: post);
              },
              itemCount: posts.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 8.0,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.create),
      ),
    );
  }
}
