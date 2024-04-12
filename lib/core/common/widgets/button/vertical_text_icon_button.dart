import 'package:flutter/material.dart';

class VerticalTextIconButton extends StatelessWidget {
  const VerticalTextIconButton({
    required this.icon,
    required this.label,
    this.onTap,
    super.key,
  });

  final Icon icon;
  final Text label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min, // 아이콘과 텍스트를 가운데 정렬
        children: <Widget>[
          icon, // 아이콘
          label, // 텍스트
        ],
      ),
    );
  }
}
