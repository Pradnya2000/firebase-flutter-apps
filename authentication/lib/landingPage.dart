import 'package:authentication/homePage.dart';
import 'package:authentication/main.dart';
import 'package:authentication/services/auth.dart';
import 'package:authentication/signInPage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
 // final AuthBase auth;
 // LandingPage({@required this.auth});
  

  @override
  Widget build(BuildContext context) {
   // final auth=AuthProvider.of(context);
    final auth=Provider.of<AuthBase>(context,listen: false);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.active) {
          User user = snapshot.data;
          if (user == null){
            return SignInPage.create(context);
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
