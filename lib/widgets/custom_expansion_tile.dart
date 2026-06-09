import 'package:flutter/material.dart';
import '../pallete.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textColor: Pallete.newTextColor,
        collapsedTextColor: Pallete.newTextColor,

        iconColor: Pallete.accentColor,
        collapsedIconColor: Pallete.newTextColor,

        backgroundColor: Pallete.whiteColor,
        collapsedBackgroundColor: Pallete.expansionClosedTileColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(
            color: Pallete.newBorderColor,
          ),
        ),

        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(
            color: Pallete.newBorderColor,
          ),
        ),

        title: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Pallete.accentColor,
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