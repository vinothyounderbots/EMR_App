import 'package:emr_application/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String iconAsset;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? iconSize;
  final Color? iconColor;

  const AppIconButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.iconAsset,
    this.width,
    this.height = 48,
    this.backgroundColor,
    this.iconSize = 20,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconAsset,
              width: iconSize,
              height: iconSize,
              color: iconColor,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
