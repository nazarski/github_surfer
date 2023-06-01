import 'package:flutter/material.dart';
import 'package:github_surfer/resources/app_colors.dart';

class AppStyles {
  AppStyles._();
  static const TextStyle header = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle body = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle bodyMessage = TextStyle(
    color: AppColors.textPlaceHolder,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
}
