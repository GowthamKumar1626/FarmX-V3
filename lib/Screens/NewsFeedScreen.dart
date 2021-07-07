import 'package:farmx/CommonWidgets/ThemeTemplate.dart';
import 'package:farmx/newsfeed/components/customListTile.dart';
import 'package:farmx/newsfeed/model/article_model.dart';
import 'package:farmx/newsfeed/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewsFeedScreen> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return ThemeTemplate(
      title: "News Feed",
      childPosition: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: client.getArticle(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                List<Article> articles = snapshot.data!;
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) =>
                        customListTile(articles[index], context),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
                // child: new Text("Loading"),
              );
            },
          ),
        ],
      ),
    );
  }
}
