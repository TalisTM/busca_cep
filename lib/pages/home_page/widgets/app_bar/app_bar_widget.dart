import 'package:busca_cep/app/app_colors.dart';
import 'package:busca_cep/app/app_text_style.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {

  AppBarWidget() : super(
    preferredSize: Size.fromHeight(130),
    child: Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        gradient: AppColors.gradient
      ),
      child: Center(child: Text("BuscaCEP", style: AppTextStyles.titleBold)),
    )
  );
}