import 'package:farmx/CommonWidgets/AlertDialogue.dart';
import 'package:farmx/CommonWidgets/ThemeTemplate.dart';
import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (error) {
      print(error.message);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: "Logout",
      content: "Are you sure you want to logout?",
      cancelActionText: "Cancel",
      defaultActionText: "Logout",
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeTemplate(
      title: "Home",
      child: Column(
        children: [
          Center(
            child: TextButton.icon(
              onPressed: () => _confirmSignOut(context),
              icon: LineIcon(
                LineIcons.alternateSignOut,
                color: kBlack,
              ),
              label: Text(
                "Logout",
                style: kLoginHeading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
