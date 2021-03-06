import 'dart:io';

import 'package:authentication/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends PlatoformWidget {
  final String title;
  final String content;
  final String defaultActionText;
  final String cancelActionText;

  PlatformAlertDialog(
      {@required this.title,
      @required this.content,
      @required this.defaultActionText,
      this.cancelActionText});
  Future<bool> show(BuildContext context) async {

    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
    return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: _buildActions(context));
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions=<Widget>[];
    if(cancelActionText!=null)
      actions.add(PlatformAlertDialogAction(
        child: Text(cancelActionText),
        onPressed: () {
          print('flase tapped');
          Navigator.of(context).pop(false);
        },
      ));
    actions.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressed: () {
          print('true tapped');
          Navigator.of(context).pop(true);
        },
      ));
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatoformWidget {
  final Widget child;
  final VoidCallback onPressed;
  PlatformAlertDialogAction({this.child, this.onPressed});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext contexntext) {
    // TODO: implement buildMaterialWidget
    return FlatButton(onPressed: onPressed, child: child);
  }
}
