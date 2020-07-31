import 'package:authentication/services/auth.dart';

import 'package:authentication/signInPage.dart';
import 'package:flutter/material.dart';
import 'package:authentication/landingPage.dart';
import 'package:provider/provider.dart';

  
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context)=>Auth(),
      child: MaterialApp(
      title: 'Authentication',
      home:LandingPage(
       // auth: Auth(),
      )
    ),
  );
  }
}