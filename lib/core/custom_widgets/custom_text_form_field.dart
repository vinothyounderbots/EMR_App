import 'package:emr_application/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final FontWeight? labelWeight;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final Color? textColor;
  final Color? labelColor;

  const CustomTextFormField({
    super.key,
    this.label,
    this.labelWeight,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.textColor,

    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              color: labelColor ?? AppColors.greyDark,
              fontWeight: labelWeight ?? FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          maxLines: maxLines ?? 1,
          style: TextStyle(
            color: textColor ?? AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          validator: (value) => value!.isEmpty ? 'Field cannot be empty' : null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.greyMedium),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
