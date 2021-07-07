import 'package:flutter/material.dart';

class ThemeTemplate extends StatelessWidget {
  ThemeTemplate({
    Key? key,
    required this.title,
    required this.child,
    this.leading,
    this.actions,
    this.userIcon,
    this.childPosition,
    this.floatingActionButton,
    this.pageHeight,
  }) : super(key: key);

  final Widget child;
  final String title;
  final Widget? userIcon;
  final IconButton? leading;
  final List<Widget>? actions;
  final double? childPosition;
  final Widget? floatingActionButton;
  final double? pageHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Text(
          title,
        ),
        leading: leading,
        centerTitle: true,
        actions: actions,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height:
                      pageHeight ?? MediaQuery.of(context).size.height - 100.0,
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  color: Colors.transparent,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height * 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                userIcon ?? Container(),
                Positioned(
                  top: childPosition ??
                      MediaQuery.of(context).size.height * 0.12,
                  left: 25,
                  right: 25,
                  child: Container(
                    child: child,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
