import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final String filial;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.role,
    required this.filial,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Foto com botão de câmera
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Pallete.primaryRed.withOpacity(0.1),
                border: Border.all(color: Pallete.whiteColor, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 52,
                color: Pallete.primaryRed,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Pallete.primaryRed,
                    shape: BoxShape.circle,
                    border: Border.all(color: Pallete.whiteColor, width: 2),
                  ),
                  child: const Icon(
                    Icons.photo_camera_rounded,
                    size: 16,
                    color: Pallete.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Nome
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 6),

        // Cargo
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Pallete.primaryRed.withOpacity(0.08),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            role,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Pallete.primaryRed,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Filial ativa
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14,
              color: Pallete.textColor.withOpacity(0.7),
            ),
            const SizedBox(width: 4),
            Text(
              filial,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Pallete.textColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}