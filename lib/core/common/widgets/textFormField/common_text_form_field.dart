import 'package:derbymatch/core/theme/pallete.dart';
import 'package:flutter/material.dart';

import '../../../values/values.dart';

class CommonTextFormField extends StatelessWidget {
  final String placeholder;
  final String? value;
  final String keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode textFocus;
  final int? maxLines;

  const CommonTextFormField(
      {Key? key,
      required this.placeholder,
      required this.keyboardType,
      required this.controller,
      required this.obscureText,
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
        TextFormField(
          maxLength: 40,
          cursorColor: Pallete.greyColor.withOpacity(0.5),
          controller: controller,
          focusNode: textFocus,
          style: AppTextStyles.infoTextStyle,
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
              horizontal: AppSpaceSize.smallSize,
              vertical: AppSpaceSize.mediumSize,
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
                    child: Icon(Icons.cancel_presentation_outlined,
                        size: 18, color: Pallete.greyColor.withOpacity(0.5)),
                  ),
            hintText: placeholder,
            hintStyle: AppTextStyles.infoTextStyle,
            filled: false,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.greyColor.withOpacity(0.8)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.greyColor.withOpacity(0.8)),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.greyColor.withOpacity(0.8)),
            ),
          ),
        ),
      ],
    );
  }
}
