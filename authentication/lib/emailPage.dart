import 'package:authentication/emailForm.dart';
import 'package:authentication/services/auth.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  //final AuthBase auth;
  //EmailPage({@required this.auth});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child:EmailForm(),//auth: auth,),
        ),
      ),
    backgroundColor: Colors.grey,
    );
  }
}