import 'package:authentication/platform_alert_dialog.dart';
import 'package:authentication/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
 // HomePage({@required this.auth});

 // final auth;
  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
            title: 'Logout',
            content: 'Are you sure that you want to Logout?',
            cancelActionText: 'Cancel',
            defaultActionText: 'Logout')
        .show(context);
    print(didRequestSignOut);
    if (didRequestSignOut == true) _signOut(context);
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth=Provider.of<AuthBase>(context,listen: false);
      print('signing out');
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
