import 'package:busca_cep/app/app_colors.dart';
import 'package:busca_cep/app/app_text_style.dart';
import 'package:busca_cep/pages/home_page/widgets/app_bar/app_bar_widget.dart';
import 'package:busca_cep/pages/home_page/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  MaskedTextController controller = MaskedTextController(mask: "000.000.000-00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      backgroundColor: AppColors.black,
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Digite seu CEP abaixo", style: AppTextStyles.title),
                TextFieldWidget(controller)
              ],
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}