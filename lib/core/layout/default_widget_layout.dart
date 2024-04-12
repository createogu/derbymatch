import 'package:flutter/material.dart';

class DefaultWidgetLayout extends StatelessWidget {
  final Widget viewWidget;
  final Widget? formWidget;
  final String? formWidgetName;

  const DefaultWidgetLayout(
      {required this.viewWidget,
      this.formWidget,
      this.formWidgetName,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (formWidget != null) {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            formWidgetName.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: formWidget,
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      },
      child: Container(
        child: viewWidget,
      ),
    );
  }
}
