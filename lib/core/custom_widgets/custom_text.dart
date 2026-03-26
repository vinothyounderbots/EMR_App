import 'package:emr_application/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.text,
    double? size,
    double? fontSize,
    FontWeight? weight,
    FontWeight? fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
  })  : size = size ?? fontSize ?? 16.0,
        weight = weight ?? fontWeight ?? FontWeight.normal;

  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? theme.textTheme.bodyMedium?.color ?? AppColors.black,
      ),
    );
  }
}
