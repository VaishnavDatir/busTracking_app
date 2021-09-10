import 'package:BusTracking_App/theme/dimensions.dart';
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
  final Function onTap;
  final int maxLength;
  final int maxLines;
  final bool disabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final bool addContentPadding;
  const CustomTextInputField(
      {Key key,
      this.hint,
      @required this.controller,
      @required this.hintText,
      this.obscureText = false,
      this.iconButton,
      this.prefixIcon,
      this.suffixIcon,
      this.onSubmit,
      this.onTap,
      this.onChanged,
      this.maxLength,
      this.maxLines,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.disabled = false,
      this.focusNode,
      this.addContentPadding = false})
      : super(key: key);

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
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: addContentPadding
            ? EdgeInsets.symmetric(
                vertical: kSmallSpace, horizontal: kSmallSpace * 3)
            : null,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        border: OutlineInputBorder(),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kTextGrey)),
        focusedBorder: disabled
            ? OutlineInputBorder(borderSide: BorderSide(color: kTextGrey))
            : OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
      ),
    );
  }
}
