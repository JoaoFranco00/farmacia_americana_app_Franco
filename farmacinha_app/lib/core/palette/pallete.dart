import "package:flutter/material.dart";

class Pallete {
  // ===== PRIMÁRIA (VERMELHO) =====
  static const Color primaryRed = Color.fromRGBO(220, 20, 60, 1);      // Vermelho vivo
  static const Color redDark = Color.fromRGBO(178, 34, 52, 1);         // Vermelho escuro
  static const Color redLight = Color.fromRGBO(239, 68, 68, 1);        // Vermelho claro

  // ===== SECUNDÁRIA (AMARELO) =====
  static const Color accentYellow = Color.fromRGBO(250, 192, 0, 1);    // Amarelo principal
  static const Color yellowLight = Color.fromRGBO(254, 215, 0, 1);     // Amarelo claro

  // ===== NEUTRAS =====
  static const Color backgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
  static const Color grayColor = Color.fromRGBO(240, 240, 240, 1);
  static const Color textColor = Color.fromRGBO(100, 100, 100, 1);
  static const Color borderColor = Color.fromRGBO(220, 220, 220, 1);

  // ===== DEPRECATED (Manter compatibilidade) =====
  static const Color gradient1 = Color.fromRGBO(220, 20, 60, 1);       // primaryRed
  static const Color gradient2 = Color.fromRGBO(239, 68, 68, 1);       // redLight
  static const Color gradient3 = Color.fromRGBO(250, 192, 0, 1);       // accentYellow
  static const Color actionButton = Color.fromRGBO(250, 192, 0, 1);    // accentYellow

  // ===== REDES SOCIAIS =====
  static const Color facebookLogo = Color.fromARGB(255, 4, 20, 249);
  static const Color googleLogo = Color.fromARGB(255, 1, 190, 8);
}
