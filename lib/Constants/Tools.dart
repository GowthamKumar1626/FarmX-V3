import 'package:flutter/material.dart';

import 'Constants.dart';

List<ToolIcons> toolIcons = [
  ToolIcons(
    name: "Pest Detection",
    imgPath: "assets/icons/pest-detection.png",
    color: kGreen,
  ),
  ToolIcons(
    name: "Fertilizer",
    imgPath: "assets/icons/fertilizer-1.png",
    color: kYellow,
  ),
  ToolIcons(
    name: "Crop Suggestion",
    imgPath: "assets/icons/crop-suggestion.png",
    color: kOrange,
  ),
  ToolIcons(
    name: "General Crop-Info",
    imgPath: "assets/icons/crop-info.png",
    color: kGrey,
  ),
  ToolIcons(
    name: "Co-Farming",
    imgPath: "assets/icons/co-farmer.png",
    color: kBlue,
  ),
  ToolIcons(
    name: "Farming Tools",
    imgPath: "assets/icons/tractor.png",
    color: kGrey,
  ),
  ToolIcons(
    name: "Donation",
    imgPath: "assets/icons/donation.png",
    color: kPink,
  ),
];

class ToolIcons {
  String name;
  String imgPath;
  Color color;

  ToolIcons({
    required this.name,
    required this.imgPath,
    required this.color,
  });
}
