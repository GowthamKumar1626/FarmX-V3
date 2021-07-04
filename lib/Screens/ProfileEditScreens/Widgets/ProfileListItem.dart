import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileListItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.08,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit * 2),
        color: Colors.indigo.shade700,
      ),
      child: Row(
        children: <Widget>[
          LineIcon(
            this.icon,
            color: Colors.white,
            size: kSpacingUnit * 2.5,
          ),
          SizedBox(width: kSpacingUnit * 1.5),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: kLightSecondaryColor,
            ),
          ),
          Spacer(),
          LineIcon(
            LineIcons.angleRight,
            size: kSpacingUnit * 3,
            color: kAccentColor,
          ),
        ],
      ),
    );
  }
}
