import 'package:authentication/emailPage.dart';
import 'package:authentication/services/auth.dart';

import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  final AuthBase auth;
  SignInPage({@required this.auth});
  
  Future<void> signInAnnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }
  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e);
    }
  }
  void _signInWithEmail(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailPage(auth: auth,),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Authentication'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              title: 'google',
              colour: Colors.red,
              ontap: _signInWithGoogle,
            ),
            CustomButton(
              title: 'Facebook',
              colour: Colors.blue,
              ontap: () {
                print('auth through Facebook');
              },
            ),
            CustomButton(
              title: 'Email',
              colour: Colors.red,
              ontap: () =>_signInWithEmail(context)
            ),
            CustomButton(
              title: 'Anonyamous',
              colour: Colors.white,
              ontap: signInAnnonymously,
            )
          ],
        ),
      
    );
  }
}

class CustomButton extends StatelessWidget {
  String title;
  Color colour;
  Function ontap;
  CustomButton({this.title, this.colour, this.ontap});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: ontap,
      child: Text(title),
      color: colour,
    );
  }
}
