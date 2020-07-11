import 'package:authentication/services/auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends InheritedWidget
{
  final AuthBase auth;

  AuthProvider({@required this.auth});
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
  
}