import 'package:flutter/material.dart';

import 'Constants.dart';

List<NewsItemIcons> newsItemIcons = [
  NewsItemIcons(
    name: "Agriculture",
    imgPath: "assets/icons/agri.png",
    color: kGreen,
  ),
  NewsItemIcons(
    name: "Market",
    imgPath: "assets/icons/market.png",
    color: kYellow,
  ),
  NewsItemIcons(
    name: "New methods",
    imgPath: "assets/icons/agri-tech.png",
    color: kOrange,
  ),
];

class NewsItemIcons {
  String name;
  String imgPath;
  Color color;
  Icons? icon;

  NewsItemIcons({
    required this.name,
    required this.imgPath,
    required this.color,
    this.icon,
  });
}
