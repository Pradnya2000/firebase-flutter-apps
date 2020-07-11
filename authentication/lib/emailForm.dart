import 'package:authentication/platform_alert_dialog.dart';
import 'package:authentication/services/auth.dart';
import 'package:authentication/services/auth_provider.dart';
import 'package:authentication/stringValidator.dart';
import 'package:flutter/material.dart';

enum emailFormType { SignIn, Register }

class EmailForm extends StatefulWidget with EmailandPasswordValidator {
 // EmailForm({@required this.auth});
 // final AuthBase auth;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  TextEditingController _emailControlller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  emailFormType _formType = emailFormType.SignIn;
  final enableSubmit = false;
  bool _submitted = false;
  String get _email => _emailControlller.text;
  String get _password => _passwordController.text;

  void submit() async {
    setState(() {
      _submitted = true;
    });
    try {
      final auth=AuthProvider.of(context);
      if (_formType == emailFormType.SignIn) {
        await auth.signInWithEmail(_email, _password);
      } else {
        await auth.createUserWithEmail(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      PlatformAlertDialog(
                    title: 'Sign In Failed',
                    content: e.toString(),
                    defaultActionText: 'OK')
                .show(context);
          
          }
  }

  void toggleType() {
    setState(() {
      _submitted = false;
      _formType = _formType == emailFormType.SignIn
          ? emailFormType.Register
          : emailFormType.SignIn;
    });
  }

  void _changeFocus() {
    print(_emailControlller.text);
    FocusScope.of(context).requestFocus(_passwordFocus);
  }

  List<Widget> _buildChildren() {
    String primaryText =
        _formType == emailFormType.SignIn ? 'Sign In' : 'Create an Account';
    String secondaryText = _formType == emailFormType.SignIn
        ? 'Need an account? Register'
        : 'Have an account? SignIn';
    bool enableSubmit = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password);
    bool emailValid = widget.emailValidator.isValid(_email);
    bool passwordValid = widget.passwordValidator.isValid(_password);
    return [
      TextField(
        onChanged: (value) {
          setState(() {});
        },
        focusNode: _emailFocus,
        controller: _emailControlller,
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'test@test.com',
            errorText:
                _submitted && !emailValid ? widget.invalidEmailError : null),
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        textInputAction: TextInputAction.next,
        onEditingComplete: _changeFocus,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        onChanged: (value) {
          setState(() {});
        },
        focusNode: _passwordFocus,
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          errorText:
              _submitted && !passwordValid ? widget.invalidPasswordError : null,
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
      ),
      SizedBox(
        height: 8.0,
      ),
      RaisedButton(
        onPressed: enableSubmit ? submit : null,
        child: Text(primaryText),
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(onPressed: toggleType, child: Text(secondaryText))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren()),
      ),
    );
  }
}
