import 'package:authentication/emailFormStateful.dart';
import 'package:authentication/email_sign_in_form_bloc_based.dart';
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
          child:EmailFormBlocBased.create(context),//auth: auth,),
        ),
      ),
    backgroundColor: Colors.grey,
    );
  }
}