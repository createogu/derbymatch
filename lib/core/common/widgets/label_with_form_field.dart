import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

class LabelWithFormField extends StatelessWidget {
  final String label;
  final String placeholder;
  final String? value;
  final String keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode textFocus;
  final int? maxLines;

  const LabelWithFormField(
      {Key? key,
      required this.placeholder,
      required this.keyboardType,
      required this.controller,
      required this.obscureText,
      required this.label,
      required this.textFocus,
      this.maxLines,
      this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacesBox.verticalSpaceMedium,
        Text(
          label.toUpperCase(),
          textAlign: TextAlign.left,
          style: AppTextStyles.titleTextStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        TextFormField(
          controller: controller,
          focusNode: textFocus,
          style: AppTextStyles.headlineTextStyle,
          maxLines: maxLines,
          onTap: () {},
          keyboardType: keyboardType == "text"
              ? TextInputType.text
              : TextInputType.number,
          //initialValue: initialValue,
          obscureText:
              placeholder == 'Password' || placeholder == 'Choose a password'
                  ? true
                  : false,

          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            suffixIcon: placeholder == "Password"
                ? InkWell(
                    onTap: () {},
                    child: Icon(
                      obscureText
                          ? Icons.remove_red_eye_outlined
                          : Icons.dnd_forwardslash,
                      //size: 15.0,
                      color: Pallete.primaryColor,
                    ))
                : InkWell(
                    onTap: () {
                      controller.text = "";
                    },
                    child: Icon(Icons.delete_outline,
                        size: 24, color: Pallete.primaryColor),
                  ),
            hintText: placeholder,
            hintStyle: AppTextStyles.infoTextStyle,
            filled: false,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.seconderyColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.seconderyColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.seconderyColor),
            ),
          ),
        ),
      ],
    );
  }
}
