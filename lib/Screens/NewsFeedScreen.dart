import 'package:farmx/CommonWidgets/CategoryButton.dart';
import 'package:farmx/CommonWidgets/ThemeTemplate.dart';
import 'package:farmx/Constants/NewsItems.dart';
import 'package:farmx/newsfeed/components/customListTile.dart';
import 'package:farmx/newsfeed/model/article_model.dart';
import 'package:farmx/newsfeed/services/api_service.dart';
import 'package:flutter/material.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewsFeedScreen> {
  ApiService client = ApiService();

  int currentIndex = 0;
  String topic = "agriculture";
  String get _api =>
      "https://newsapi.org/v2/everything?q=$topic&from=2021-06-28&to=2021-06-28&sortBy=popularity&apiKey=c9707391546b4a81ad51e88d2f302b25";

  @override
  Widget build(BuildContext context) {
    return ThemeTemplate(
      title: "News Feed",
      childPosition: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                constraints: BoxConstraints.tightFor(
                  width: 70,
                  height: 85,
                ),
                child: SizedBox(
                  height: 70.0,
                  child: Icon(
                    Icons.apps,
                  ),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: SizedBox(
                  height: 70.0,
                  child: new ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: newsItemIcons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NewsItemsContainer(
                        index: index,
                        getCurrentIndex: () => currentIndex,
                        setCurrentIndex: () {
                          setState(() {
                            currentIndex = index;
                            switch (index) {
                              case 0:
                                topic = "agriculture";
                                break;
                              case 1:
                                topic = "market";
                                break;
                              case 2:
                                topic = "technology";
                                break;
                              default:
                                topic = "farmers";
                                break;
                            }
                          });
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
            height: 10,
          ),
          FutureBuilder(
            future: client.getArticle(_api),
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

class NewsItemsContainer extends StatelessWidget {
  final int index;
  final VoidCallback setCurrentIndex;
  final Function() getCurrentIndex;

  NewsItemsContainer({
    required this.index,
    required this.getCurrentIndex,
    required this.setCurrentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return CategoryButton(
      image: AssetImage(newsItemIcons[index].imgPath),
      color: newsItemIcons[index].color,
      onPressed: () => setCurrentIndex(),
      isSelected: getCurrentIndex() == index,
    );
  }
}
