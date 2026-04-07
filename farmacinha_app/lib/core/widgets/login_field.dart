import 'package:flutter/material.dart';
import '../palette/pallete.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller; // VARIÁVEL 

  const LoginField({
    super.key, 
    required this.hintText, 
    required this.controller, // 'this.controller' PARA GUARDAR O VALOR
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 330),
      child: TextFormField(
        controller: controller, // VINCULAR O CONTROLLER AO TEXTFORMFIELD
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.actionButton,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}