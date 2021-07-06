import 'package:busca_cep/app/app_colors.dart';
import 'package:busca_cep/app/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextResultWidget extends StatelessWidget {
  final String tipo;
  final TextEditingController controller;
  final String value;
  TextResultWidget(this.tipo, this.controller, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        onChanged: (_) {
          controller.text = value;
        },
        style: AppTextStyles.textFieldText,
        enabled: value != "",
        decoration: InputDecoration(
          suffixIcon: value != ""
            ? IconButton(
              icon: Icon(Icons.copy, color: AppColors.white),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
              }
            )
            : SizedBox(),
          labelText: tipo,
          labelStyle: AppTextStyles.textFieldText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary)
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary)
          ),
        ),
      ),
    );
  }
}