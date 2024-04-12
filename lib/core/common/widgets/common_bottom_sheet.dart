import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonBottomSheet extends ConsumerStatefulWidget {

  final widget;

  const CommonBottomSheet({required this.widget, super.key});

  @override
  ConsumerState<CommonBottomSheet> createState() => _CommonBottomSheetState();
}

class _CommonBottomSheetState extends ConsumerState<CommonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return widget;
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.8,
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
