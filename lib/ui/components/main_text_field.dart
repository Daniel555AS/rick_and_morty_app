import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';

class MainTextField extends StatelessWidget {
  final TextEditingController controller;

  const MainTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.textFieldInput),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.textFieldIcon),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.scaffoldAppBarBackground),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldIcon),
          ),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: AppColors.textFieldFillColor,
        ),
      ),
    );
  }
}
