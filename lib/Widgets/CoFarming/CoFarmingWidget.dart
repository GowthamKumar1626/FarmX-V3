import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Services/Models/UserModel.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Services/database.dart';
import 'package:farmx/Widgets/CoFarming/LocationDetails.dart';
import 'package:farmx/Widgets/CoFarming/notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'LocationDetails.dart';

class CoFarmingWidget extends StatefulWidget {
  const CoFarmingWidget({Key? key}) : super(key: key);

  @override
  _CoFarmingWidgetState createState() => _CoFarmingWidgetState();
}

class _CoFarmingWidgetState extends State<CoFarmingWidget> {
  final _key = GlobalKey<FormState>();

  bool isAvailable = false;
  bool isAnonymous = false;

  dynamic farmersAvailable = [];
  DateTime selectedDate = DateTime.now();

  final DateFormat? dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);
    bool isAnonymous = auth.currentUser!.isAnonymous;

    return StreamBuilder<UserModel>(
      stream: database.userDataStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data;
          print(userData!.isFarmer);

          return Column(
            children: [
              Form(
                key: _key,
                child: isAnonymous == true
                    ? isAnonymousForm()
                    : userData.isFarmer == true
                        ? coFarmingAvailabilityForm(userData, database)
                        : userCoFarmingForm(context, userData),
              ),
            ],
          );
        }
        return Column(
          children: [
            Form(
              key: _key,
              child: Text("Anonymous"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserNameText(BuildContext context, UserModel currentUser) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<UserModel>>(
      stream: database.getAllCoFarmingFarmers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data;
          final data = userData!
              .map(
                (user) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => LocationDetails(
                          farmer: user,
                          currentUser: currentUser,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: LocationItem(
                      icon: Icons.location_pin,
                      text: "${user.name}-${user.locationName}",
                      locationText: "View Details",
                    ),
                  ),
                ),
              )
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: data,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No Farmers data",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Column coFarmingAvailabilityForm(UserModel userData, Database database) {
    DateTime selectedDate = DateTime.now();
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    return userData.coFarmingAvailable == "Not Selected"
        ? Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "Are you available for Co-Farming?",
                      style: kDefaultStyle,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: Text('Yes'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                (states) => kBlack,
                              ),
                            ),
                            onPressed: () async {
                              showDateTimeDialog(context,
                                  initialDate: selectedDate,
                                  onSelectedDate: (selectedDate) {
                                setState(() {
                                  this.selectedDate = selectedDate;
                                });
                              });
                              setState(() {
                                isAvailable = true;
                                print(
                                    "Co-Farming availability status: $selectedDate");
                                UserModel model = UserModel(
                                  name: userData.name,
                                  phoneNumber: userData.phoneNumber,
                                  isFarmer: userData.isFarmer,
                                  locationName: userData.locationName,
                                  locationDetails: userData.locationDetails,
                                  coFarmingAvailable: isAvailable.toString(),
                                  selectedDate: selectedDate.toString(),
                                );
                                database.setGeneralUserData(model);
                              });
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text(
                            'No',
                            style: TextStyle(color: kBlack),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kLightSecondaryColor,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isAvailable = false;
                              UserModel model = UserModel(
                                name: userData.name,
                                phoneNumber: userData.phoneNumber,
                                isFarmer: userData.isFarmer,
                                locationName: userData.locationName,
                                locationDetails: userData.locationDetails,
                                coFarmingAvailable: isAvailable.toString(),
                                selectedDate: "none",
                              );
                              database.setGeneralUserData(model);
                              print(
                                  "Co-Farming availability status: $isAvailable");
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        : userData.coFarmingAvailable == "true"
            ? Column(
                children: <Widget>[
                  Text("You have Scheduled at - ${userData.selectedDate}"),
                ],
              )
            : Column(
                children: <Widget>[
                  Text("Not eligible"),
                ],
              );
  }

  Column userCoFarmingForm(BuildContext context, UserModel userData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            "Farmers available for Co-Farming:",
            style: kDefaultStyle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _buildUserNameText(context, userData),
      ],
    );
  }

  Column isAnonymousForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Container(
            // padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: new Column(
              children: <Widget>[
                new Text(
                  "Anonymous users are not available to access this feature.\n\nPlease create an account to use this feature",
                  textAlign: TextAlign.left,
                  style: kLabelStyleDefault,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LocationItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String locationText;

  const LocationItem({
    required this.icon,
    required this.text,
    required this.locationText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.09,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit * 2),
        color: kDarkSecondaryColor,
      ),
      child: Row(
        children: <Widget>[
          LineIcon(
            this.icon,
            color: Colors.white,
            size: kSpacingUnit * 2.5,
          ),
          SizedBox(width: kSpacingUnit * 1.5),
          Column(
            children: <Widget>[
              Text(
                this.text,
                style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: kLightSecondaryColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                this.locationText,
                style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w100,
                  fontSize: 15,
                  color: kLightSecondaryColor,
                ),
              ),
            ],
          ),
          Spacer(),
          LineIcon(
            LineIcons.angleRight,
            size: kSpacingUnit * 2.5,
            color: kAccentColor,
          ),
        ],
      ),
    );
  }
}
