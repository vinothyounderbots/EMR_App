import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_dimensions.dart';

class CustomCupertinoDropdownField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String obscureTextString;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isShowSuffixIcon;
  final VoidCallback? onTap;
  final bool obscureText;
  final bool readOnly;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;

  const CustomCupertinoDropdownField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.isShowSuffixIcon = true,
    this.onTap,
    this.obscureText = false,
    this.readOnly = true,
    this.onChanged,
    this.validator,
    this.obscureTextString = '•',
    this.maxLength,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      onTap: onTap,
      onChanged: onChanged,
      obscuringCharacter: obscureTextString,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: isShowSuffixIcon
            ? suffixIcon ?? const Icon(Icons.keyboard_arrow_down_outlined)
            : null,
        prefixIconConstraints:
            const BoxConstraints(maxWidth: 200, maxHeight: 20),
        suffixIconConstraints:
            const BoxConstraints(maxWidth: 200, maxHeight: 20),
        contentPadding: const EdgeInsets.only(left: 0, top: 0),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
      ),
      validator: validator,
      style: const TextStyle(
        fontFamily: "Jost",
        fontSize: AppFontSize.s15,
        color: AppColors.black,
        decoration: TextDecoration.none,
      ),
    );
  }
}
