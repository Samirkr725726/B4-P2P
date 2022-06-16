// ignore_for_file: prefer_const_constructors, duplicate_ignore, override_on_non_overriding_member, unrelated_type_equality_checks, avoid_print, annotate_overrides, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_new, import_of_legacy_library_into_null_safe, unused_element

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:email_auth/email_auth.dart';


void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageDemoState createState() => _HomePageDemoState();
}

class _HomePageDemoState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Round App'),
      ),
      body: Center(
        // ignore: deprecated_member_use, avoid_unnecessary_containers
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/signup.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              // Image.asset('assets/Images/k511Km7-ichigo-wallpaper-hd.jpg'),
              // ignore: deprecated_member_use
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Center(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 200,
                    height: 170,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(20)),
                // ignore: deprecated_member_use, duplicate_ignore
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => LoginDemo()));
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(20)),
                // ignore: deprecated_member_use, duplicate_ignore
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => SignupDemo()));
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    'Signup',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  @override

  Future<void> requestCameraPermission() async {

    final serviceStatus = await Permission.camera.isGranted ;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
      requestLocationPermission();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Future<void> requestLocationPermission() async {

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;

    bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/login.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 200,
                  height: 150,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Keystore',
                    hintText: 'Enter a valid keystore'),
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
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ForgotDemo()));
              },
              child: Text(
                'Forgot Keystore? Update',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use, duplicate_ignore
              child: FlatButton(
                onPressed: requestCameraPermission,
                // onPressed: () {
                //   Navigator.pop(context);
                //   Navigator.pop(context);
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (_) => HomePage()));
                // },
                // ignore: prefer_const_constructors
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class SignupDemo extends StatefulWidget {
  @override
  _SignupDemoState createState() => _SignupDemoState();
}

class _SignupDemoState extends State<SignupDemo> {
  @override
  Future<void> requestCameraPermission() async {

    final serviceStatus = await Permission.camera.isGranted ;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
      requestLocationPermission();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Future<void> requestLocationPermission() async {

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;

    bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

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
                    labelText: 'Username',
                    hintText: 'Enter an unoccupied username'),
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
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: (){
                // TODO FORGOT PASSWORD SCREEN GOES HERE
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginDemo()));
              },
              child: Text(
                'Back to login page',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use, duplicate_ignore
              child: FlatButton(
                onPressed: requestCameraPermission,
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
              height: 130,
            ),
            Text('Already a user? Back to login page')
          ],
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class ForgotDemo extends StatefulWidget {
  @override
  _ForgotDemoState createState() => _ForgotDemoState();
}

class _ForgotDemoState extends State<ForgotDemo> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void sendOTP() async {
    EmailAuth.sessionName = "Test Session";
    // ignore: await_only_futures
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("OTP Sent");
    }
    else {
      print("We are unable to send the OTP");
    }
  }

  void verifyOTP() {
    var res = EmailAuth.validate(receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("OTP Verified");
    }
    else {
      print("Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Update Keystore"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/login.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 200,
                  height: 0,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:50.0,bottom: 0),
              // padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email id',
                    suffixIcon: TextButton(
                      child: Text("Send OTP"),
                      onPressed: () => sendOTP(),
                    )
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('or'),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your Username'),
              ),
            ),
            // ignore: deprecated_member_use
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use, duplicate_ignore
              child: FlatButton(
                onPressed: () => sendOTP(),
                // ignore: prefer_const_constructors
                child: Text(
                  'Send OTP',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 40.0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _otpController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'OTP',
                    hintText: 'Enter received OTP'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use, duplicate_ignore
              child: FlatButton(
                onPressed: () => verifyOTP(),
                // ignore: prefer_const_constructors
                child: Text(
                  'Verify OTP',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


