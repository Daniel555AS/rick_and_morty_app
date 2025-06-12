import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';

class TextStyles {
  // Scafoold - AppBar
  static const TextStyle scaffoldAppBarTitle = TextStyle(
    color: AppColors.title,
    fontWeight: FontWeight.w900,
  );

  // Loading...
  static const TextStyle loadingStyle = TextStyle(
    color: AppColors.title,
    fontWeight: FontWeight.w900,
    fontSize: 20.0,
  );

  // Character Card
  static const TextStyle characterName = TextStyle(
    color: AppColors.characterName,
    fontWeight: FontWeight.w900,
    fontSize: 22,
  );

  static const TextStyle subtitleCharacter = TextStyle(
    color: AppColors.subtitleCharacter,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bodyCharacter = TextStyle(
    color: AppColors.bodyCharacter,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle characterStatusAndGender = TextStyle(
    color: AppColors.characterStatusAndGender,
    fontWeight: FontWeight.w500,
  );
}
