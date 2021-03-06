import 'package:farmx/CommonWidgets/ThemeTemplate.dart';
import 'package:farmx/Screens/ProfileEditScreens/CropInfoScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/GeneralInfoScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/HelpAndSupport.dart';
import 'package:farmx/Screens/ProfileEditScreens/PrivacySettingsScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/PurchaseHistory.dart';
import 'package:farmx/Screens/ProfileEditScreens/Widgets/ProfileListItem.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return ThemeTemplate(
      title: "Account Details",
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        color: Colors.white,
      ),
      userIcon: _buildUserIcon(context),
      childPosition: MediaQuery.of(context).size.height * 0.2,
      pageHeight: MediaQuery.of(context).size.height * 0.936,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildSettingsList(context, auth),
      ),
    );
  }

  Positioned _buildUserIcon(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.1,
      child: Stack(
        children: <Widget>[
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.indigo,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 10),
                  spreadRadius: 2,
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/icons/profile-user.png"),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildUserNameText(BuildContext context) {
  //   final database = Provider.of<Database>(context, listen: false);
  //   return StreamBuilder<UserModel>(
  //     stream: database.userDataStream(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         final userData = snapshot.data;
  //         return Text(
  //           userData!.name,
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontFamily: 'Roboto',
  //             fontSize: 22.0,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         );
  //       }
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(
  //             "HeyUser",
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontFamily: 'Roboto',
  //               fontSize: 22.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  List<Widget> _buildSettingsList(BuildContext context, AuthBase auth) {
    return [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => Provider<Database>(
                create: (_) => FireStoreDatabase(uid: auth.currentUser!.uid),
                builder: (context, child) => GeneralInfoScreen(),
              ),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.infoCircle,
          text: "General Info",
        ),
      ),
      cropInfoBuilder(context),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => PrivacySettingsScreen(),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.userShield,
          text: "Privacy",
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => PurchaseHistory(),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.history,
          text: "Purchase History",
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => HelpAndSupport(),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.questionCircle,
          text: "Help & Support",
        ),
      ),
    ];
  }

  GestureDetector cropInfoBuilder(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (context) => CropInfoScreen(),
          ),
        );
      },
      child: ProfileListItem(
        icon: LineIcons.tools,
        text: "Crop Info",
      ),
    );
  }
}

// BuildCropInfoCard
// class CropsCultivatedContainer extends StatelessWidget {
//   final int index;
//
//   CropsCultivatedContainer({
//     required this.index,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: 70,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(crops[index].imgPath),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildUserNameText(BuildContext context) {
//   final database = Provider.of<Database>(context, listen: false);
//   return StreamBuilder<List<UserModel>>(
//     stream: database.getAllUsersDataStream(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         final userData = snapshot.data;
//         final data = userData!
//             .map((user) => Text(
//           user.name,
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: 'Roboto',
//             fontSize: 22.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ))
//             .toList();
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: data,
//         );
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "HeyUser",
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'Roboto',
//               fontSize: 22.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
