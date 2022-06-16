// ignore_for_file: use_key_in_widget_constructors, override_on_non_overriding_member, unrelated_type_equality_checks, avoid_print, annotate_overrides, prefer_const_constructors, duplicate_ignore, unused_local_variable, unused_import

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:email_auth/email_auth.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:allroundapp/signupfunc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpDemoState createState() => _SignUpDemoState();
}

class _SignUpDemoState extends State<SignUp> {
  late String countryValue;
  late String stateValue;
  late String cityValue;
  @override
  // Future<void> requestCameraPermission() async {
  //
  //   final serviceStatus = await Permission.camera.isGranted ;
  //
  //   bool isCameraOn = serviceStatus == ServiceStatus.enabled;
  //
  //   final status = await Permission.camera.request();
  //
  //   if (status == PermissionStatus.granted) {
  //     print('Permission Granted');
  //     requestLocationPermission();
  //   } else if (status == PermissionStatus.denied) {
  //     print('Permission denied');
  //   } else if (status == PermissionStatus.permanentlyDenied) {
  //     print('Permission Permanently Denied');
  //     await openAppSettings();
  //   }
  // }
  //
  // Future<void> requestLocationPermission() async {
  //
  //   final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;
  //
  //   bool isLocation = serviceStatusLocation == ServiceStatus.enabled;
  //
  //   final status = await Permission.locationWhenInUse.request();
  //
  //   if (status == PermissionStatus.granted) {
  //     print('Permission Granted');
  //   } else if (status == PermissionStatus.denied) {
  //     print('Permission denied');
  //   } else if (status == PermissionStatus.permanentlyDenied) {
  //     print('Permission Permanently Denied');
  //     await openAppSettings();
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign up Page"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/signup.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 200,
                  height: 50,
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter a valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Alias name',
                    hintText: 'Enter an Alias name for your ID'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone no',
                    hintText: 'Enter a 10 digit mobile no'),
              ),
            ),
            SelectState(
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged:(value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged:(value) {
                setState(() {
                  cityValue = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Choose a secure password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use, duplicate_ignore
              child: FlatButton(
                onPressed: () {
                  newmain();
                },
                // onPressed: () {
                //   requestLocationPermission;
                //   requestCameraPermission;
                // Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => HomePage()));
                // },
                // ignore: prefer_const_constructors
                child: Text(
                  'Signup',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text('Already a user? Back to login page'),
          ],
        ),
      ),
    );
  }
}