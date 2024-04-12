import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class Logo extends StatelessWidget {
  final double scale;
  final Alignment? align;

  const Logo({
    required this.scale,
    this.align,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50 * scale,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Image.asset(
              Constants.logoPath,
              height: 50 * scale,
              width: 50 * scale,
            ),
          ),
          // Text(
          //   Constants.serviceNameKor,
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: (40 * scale),
          //     fontWeight: FontWeight.w400,
          //     fontFamily: 'samlip',
          //     color: Pallete.blackColor,
          //   ),
          // )
        ],
      ),
    );
  }
}
