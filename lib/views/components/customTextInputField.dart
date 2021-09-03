import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/themes.dart';

class CustomTextInputField extends StatelessWidget {
  final String hint;
  final String hintText;
  final TextEditingController controller;
  final IconButton iconButton;
  final bool obscureText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextCapitalization textCapitalization;
  final Function onSubmit;
  final Function onChanged;
  final int maxLength;
  final int maxLines;
  final bool disabled;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  const CustomTextInputField({
    Key key,
    this.hint,
    @required this.controller,
    @required this.hintText,
    this.obscureText = false,
    this.iconButton,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmit,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.disabled = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onSubmitted: onSubmit,
      onChanged: onChanged,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      readOnly: disabled,
      cursorColor: kPrimaryColor,
      style: appTheme.textTheme.bodyText1,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
          /* contentPadding: EdgeInsets.symmetric(
              vertical: kLargeSpace, horizontal: kSmallSpace * 3), */
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: OutlineInputBorder(),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: kTextGrey)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor))),
    );
  }
}
