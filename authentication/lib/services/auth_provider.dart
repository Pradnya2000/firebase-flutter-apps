import 'package:authentication/services/auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends InheritedWidget
{
  final AuthBase auth;
  final Widget child;
  AuthProvider({@required this.auth,@required this.child});
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
  //final auth=AuthProvider.of(context)
  static AuthBase of(BuildContext context)
  {
    AuthProvider authProvider=context.dependOnInheritedWidgetOfExactType();
    return authProvider.auth;
  }
  
}