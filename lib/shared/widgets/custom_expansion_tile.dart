import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diatrack/core/constants/app_colors.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final IconData? icon;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        textColor: AppColors.newTextColor,
        collapsedTextColor: AppColors.newTextColor,
        iconColor: AppColors.accentColor,
        collapsedIconColor: AppColors.newTextColor,
        backgroundColor: AppColors.whiteColor,
        collapsedBackgroundColor: AppColors.expansionClosedTileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(
            color: AppColors.newBorderColor,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(
            color: AppColors.newBorderColor,
          ),
        ),
        title: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: AppColors.accentColor,
              ),
              const SizedBox(width: 10),
            ],
            Text(
              title,
              style: GoogleFonts.afacad(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        children: children,
      ),
    );
  }
}
