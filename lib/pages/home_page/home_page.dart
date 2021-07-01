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

  FocusNode textFieldFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        textFieldFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBarWidget(),
        backgroundColor: AppColors.secundary,
        body: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Digite seu CEP abaixo:", style: AppTextStyles.title),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: controller,
                        inputFormatters: [maskFormatter],
                        focusNode: textFieldFocus,
                        style: AppTextStyles.textFieldText,
                        onSubmitted: (_) => _buscar(),
                        decoration: InputDecoration(
                          hintText: "Ex: 00.000-000",
                          hintStyle: AppTextStyles.textFieldTextGray,
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
                            borderSide: BorderSide(color: AppColors.lightYellow)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient: AppColors.gradientButton,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Buscar", style: AppTextStyles.buttonText),
                        ),
                      ),
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: _buscar
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.double_arrow_rounded,
                color: AppColors.primary,
                size: 80,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Endereço:", style: AppTextStyles.title),
                    SizedBox(height: 10),
                    TextResultWidget("Rua", "Rua tal tal tal"),
                    Row(
                      children: [
                        Expanded(flex: 8, child: TextResultWidget("Bairro", "bairro tal tal tal")),
                        SizedBox(width: 10),
                        Expanded(flex: 2, child: TextResultWidget("Número", "00")),
                      ],
                    ),
                    TextResultWidget("Cidade", "cidade tal tal tal"),
                    TextResultWidget("Estado", "estado tal tal"),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  void _buscar() {

  }
}