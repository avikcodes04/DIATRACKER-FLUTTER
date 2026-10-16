import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diatrack/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: AppColors.accentColor,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint ?? "Enter $label",
          labelStyle: GoogleFonts.poppins(
            color: AppColors.newTextColor,
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: AppColors.newAccentColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.newBorderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.newBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.accentColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
