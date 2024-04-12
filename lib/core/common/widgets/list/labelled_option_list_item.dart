import 'package:derbymatch/core/theme/pallete.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LabelledOptionListItem extends StatelessWidget {
  final String label;
  final String? link;
  final Color? color;
  final String? boxColor;
  final VoidCallback? callback;
  final IconData icon;

  LabelledOptionListItem(
      {Key? key,
      this.color,
      this.link,
      this.callback,
      this.boxColor,
      required this.label,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MergeSemantics(
            child: InkWell(
          onTap: callback,
          child: Card(
            elevation: 5,
            color: Pallete.whiteColor,
            surfaceTintColor: Pallete.whiteColor,
            child: ListTile(
              leading: Icon(icon),
              title: Text(label, style: AppTextStyles.bodyTextStyle),
            ),
          ),
        )),
      ],
    );
  }
}
