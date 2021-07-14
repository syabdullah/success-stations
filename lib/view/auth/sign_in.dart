import 'package:flutter/material.dart';
import 'package:success_stations/utils/facebook_signIn.dart';
import 'package:success_stations/utils/google_signIn.dart';

class SignIn extends StatefulWidget {
  _SignPageState createState() => _SignPageState();
}
class _SignPageState extends State<SignIn> {

  @override
  void initState() {
    super.initState();
    GoogleSignInC().singIn();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children: [
          Center(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                     GoogleSignInC().handleSignIn();
                  },
                  child: Container(
                    color: Colors.blue,
                    height: 50,
                    width: 100,
                    child: Text("Google",style: TextStyle(color: Colors.white),)
                  )
                ),
                TextButton(
                  onPressed: () {
                   FaceBookSignIn().login();
                  },
                  child: Container(
                    color: Colors.blue,
                    height: 50,
                    width: 100,
                    child: Text("FaceBook",style: TextStyle(color: Colors.white),)
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
 