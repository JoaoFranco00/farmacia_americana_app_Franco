import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../palette/pallete.dart';

class SocialButton extends StatelessWidget {
  final String iconName;
  final String label;
  final double horizontalPadding;
  final VoidCallback onPressed;
  final Color textColor;
  final Color iconColor;

  const SocialButton({
    super.key,
    required this.iconName,
    required this.label,
    this.horizontalPadding = 70.0,
    required this.onPressed,
    this.textColor = Pallete.whiteColor,
    this.iconColor = Pallete.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/svgs/$iconName.svg',
        width: 25,
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 22,
            horizontal: horizontalPadding,
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Pallete.borderColor, width: 3),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}