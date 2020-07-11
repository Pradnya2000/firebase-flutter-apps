import 'package:authentication/services/auth.dart';
import 'package:authentication/services/auth_provider.dart';
import 'package:authentication/signInPage.dart';
import 'package:flutter/material.dart';
import 'package:authentication/landingPage.dart';

  
void main() {
  runApp(AuthProvider(
      auth: Auth(),
      child: MaterialApp(
      title: 'Authentication',
      home:LandingPage(
       // auth: Auth(),
      )
    ),
  ));
}
