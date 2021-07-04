import 'package:farmx/CommonWidgets/ThemeTemplate.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ThemeTemplate(
      title: "Posts",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.create),
      ),
    );
  }
}
