import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class FormRoundedInputField extends StatelessWidget {
  FormRoundedInputField({
    this.key,
    this.controller,
    this.onFieldSubmitted,
    this.style,
    this.maxLines,
    this.textInputAction,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.autofocus = false,
    this.readOnly = false,
    this.initialValue,
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    this.validator,
    this.fillColor,
    this.onTap,
    this.onSaved,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.inputFormatters,
    this.borderColor = kPrimaryColor,
  });

  final Key key;
  final TextEditingController controller;
  final Function onFieldSubmitted;
  final TextStyle style;
  final int maxLines;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final String initialValue;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final FormFieldValidator<String> validator;
  final Color fillColor;
  final Color borderColor;
  final Function onSaved;
  final Function onChanged;
  final Function onTap;
  final TextInputType keyboardType;
  final Icon icon;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final bool autofocus;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      autofocus: autofocus,
      textInputAction: textInputAction,
      key: key,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        icon: icon,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: kErrorColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        ),
      ),
      onFieldSubmitted: onFieldSubmitted,
      style: style,
      maxLines: maxLines,
      obscureText: obscureText,
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
    );
  }
}
