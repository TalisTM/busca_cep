import 'package:busca_cep/app/app_colors.dart';
import 'package:busca_cep/app/app_text_style.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {

  AppBarWidget(bool web) : super(
    preferredSize: Size.fromHeight(web ? 120 : 50),
    child: Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        gradient: AppColors.gradient
      ),
      child: Center(child: Text("BuscaCEP", style: web ? AppTextStyles.titleBold : AppTextStyles.titleBoldMobile)),
    )
  );
}