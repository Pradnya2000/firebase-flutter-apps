import 'package:authentication/homePage.dart';
import 'package:authentication/main.dart';
import 'package:authentication/services/auth.dart';
import 'package:authentication/services/auth_provider.dart';
import 'package:authentication/signInPage.dart';

import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
 // final AuthBase auth;
 // LandingPage({@required this.auth});
  

  @override
  Widget build(BuildContext context) {
    final auth=AuthProvider.of(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.active) {
          User user = snapshot.data;
          if (user == null){
            return SignInPage(
             // auth:auth,
              
            );
          }
          return HomePage(
            //  auth: auth,
              );  
        }
        else
        {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }
      },
    );
  }
}
