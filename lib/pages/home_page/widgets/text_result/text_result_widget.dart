import 'package:busca_cep/app/app_colors.dart';
import 'package:busca_cep/app/app_text_style.dart';
import 'package:flutter/material.dart';

class TextResultWidget extends StatelessWidget {
  final String tipo;
  final String value;
  TextResultWidget(this.tipo, this.value);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: value != "" ? value : "Não encontrado");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        style: AppTextStyles.textFieldText,
        enabled: false,
        decoration: InputDecoration(
          labelText: tipo,
          labelStyle: AppTextStyles.textFieldText,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary)
          ),
        ),
      ),
    );
  }
}