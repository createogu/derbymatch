import 'package:derbymatch/core/common/shapes/settings_strip.dart';
import 'package:flutter/material.dart';

class AppSettingsIcon extends StatelessWidget {
  final VoidCallback? callback;

  AppSettingsIcon({
    Key? key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        child: Column(children: [
          SettingsStrip(),
          SizedBox(height: 2),
          RotatedBox(quarterTurns: 2, child: SettingsStrip())
        ]),
      ),
    );
  }
}
