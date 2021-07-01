import 'package:busca_cep/app/app_colors.dart';
import 'package:busca_cep/app/app_text_style.dart';
import 'package:busca_cep/pages/home_page/widgets/app_bar/app_bar_widget.dart';
import 'package:busca_cep/pages/home_page/widgets/text_result/text_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController controller = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(mask: '##.###-###', filter: { "#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      backgroundColor: AppColors.secundary,
      body: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Digite seu CEP abaixo:", style: AppTextStyles.title),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: controller,
                      inputFormatters: [maskFormatter],
                      style: AppTextStyles.textFieldText,
                      decoration: InputDecoration(
                        labelStyle: AppTextStyles.textFieldText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextResultWidget("Rua", "Rua tal tal tal"),
                  Row(
                    children: [
                      Expanded(flex: 8, child: TextResultWidget("Bairro", "bairro tal tal tal")),
                      SizedBox(width: 10),
                      Expanded(flex: 2, child: TextResultWidget("Número", "bairro tal tal tal")),
                    ],
                  ),
                  TextResultWidget("Numero", "bairro tal tal tal"),
                  TextResultWidget("Cidade", "bairro tal tal tal"),
                  TextResultWidget("Estado", "bairro tal tal tal"),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}