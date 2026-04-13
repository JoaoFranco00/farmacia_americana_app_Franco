import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Foto com botão de câmera sobreposto
        Stack(
          alignment: Alignment.center,
          children: [
            // Círculo da foto
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Pallete.primaryRed.withOpacity(0.1),
                border: Border.all(
                  color: Pallete.primaryRed.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 52,
                color: Pallete.primaryRed,
              ),
            ),

            // Botão de câmera no canto inferior direito
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Futuramente: abrir galeria ou câmera
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Pallete.primaryRed,
                    shape: BoxShape.circle,
                    border: Border.all(color: Pallete.whiteColor, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 16,
                    color: Pallete.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Nome do gerente
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 4),

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
      ],
    );
  }
}