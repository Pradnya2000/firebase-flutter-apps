import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatoformWidget extends StatelessWidget {
  Widget buildMaterialWidget(BuildContext context);
  Widget buildCupertinoWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
   if(Platform.isAndroid)
    return buildMaterialWidget(context);
  return buildCupertinoWidget(context);
  }
}