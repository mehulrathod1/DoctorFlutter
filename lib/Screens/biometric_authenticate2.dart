import 'dart:io';

import 'package:doctor/API/local_auth_api.dart';
import 'package:doctor/Utils/colorsandstyles.dart';
import 'package:doctor/controller/NavigationController.dart';
import 'package:doctor/Screens/general_screen.dart';
import 'package:doctor/widgets/common_app_bar_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DoctorScreens/doctor_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class BiometricAuthenticate2 extends StatefulWidget {
  const BiometricAuthenticate2({Key? key}) : super(key: key);

  @override
  _BiometricAuthenticate2State createState() => _BiometricAuthenticate2State();
}

class _BiometricAuthenticate2State extends State<BiometricAuthenticate2> {
  @override
  void initState() {
    // FirebaseNotificationHandling().setupFirebase(context);
    // setupFirebase(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonAppBarTitle(),
        centerTitle: false,

        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final isAuthenticated = await LocalAuthApi.authenticate(context);
            if (isAuthenticated) {
              // prefs.setString('isbiometric', 'yes');
              Push(context, GeneralScreen());
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Try Again')));
            }
          },
          child: (Platform.isAndroid)
              ? Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              'assets/pngs/Icon ionic-md-finger-print.png',
                              height: 90),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Press This FingerPrint to Start Scanning',
                            style: GoogleFonts.montserrat(
                                color: apptealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/pngs/Icon material-face.png',
                              height: 90),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Press This Face to Start Scanning FaceID',
                            style: GoogleFonts.montserrat(
                                color: apptealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}
