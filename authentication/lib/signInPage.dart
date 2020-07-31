import 'package:authentication/Platform_exception_alert_dialog.dart';
import 'package:authentication/emailPage.dart';
import 'package:authentication/services/auth.dart';
import 'package:authentication/sign_in_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final SignInBloc bloc;

  const SignInPage({Key key, this.bloc}) : super(key: key);

  static Widget create(BuildContext context) {
    final auth=Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      dispose: (context,bloc)=>bloc.dispose(),
      create: (_) => SignInBloc(auth: auth),
      child: Consumer<SignInBloc>(builder: (context,bloc,_) =>SignInPage(bloc:bloc)),
    );
  }

  @override
  //final AuthBase auth;
  //SignInPage({@required this.auth});

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(title: 'Sign In failed', exception: exception)
        .show(context);
  }

  Future<void> signInAnnonymously(BuildContext context) async {
    //final bloc=Provider.of<SignInBloc>(context,listen:false);
    try {
      await bloc.signInAnonymously();
     
    } on PlatformException catch (e) {
      print(e);
      _showSignInError(context, e);
    } 
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    //final bloc=Provider.of<SignInBloc>(context,listen:false);
    try {
      await bloc.signInWithGoogle();
      
    } on PlatformException catch (e) {
      print(e);
      if (e.code != 'ERROR_MISSING_GOOGLE_ACCESS_TOKEN')
        _showSignInError(context, e);
    } 
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => EmailPage(), //auth: auth,),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //final bloc=Provider.of<SignInBloc>(context,listen:false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          return _buildBody(context, snapshot.data);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool isLoading) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildHere(isLoading),
        CustomButton(
          title: 'google',
          colour: Colors.red,
          ontap: () => isLoading ? null : _signInWithGoogle(context),
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
            ontap: () => isLoading ? null : _signInWithEmail(context)),
        CustomButton(
          title: 'Anonyamous',
          colour: Colors.white,
          ontap: () => isLoading ? null : signInAnnonymously(context),
        )
      ],
    );
  }

  Widget _buildHere(isLoading) {
    if (isLoading) return Center(child: CircularProgressIndicator());
    return Text(
      'Sign In',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
