import 'dart:async';
import 'dart:convert';

import 'package:busca_cep/app/app_colors.dart';
import 'package:busca_cep/app/app_text_style.dart';
import 'package:busca_cep/models/endereco.dart';
import 'package:busca_cep/pages/home_page/widgets/app_bar/app_bar_widget.dart';
import 'package:busca_cep/pages/home_page/widgets/text_result/text_result_widget.dart';
import 'package:busca_cep/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final StreamController _streamController = StreamController<Map>.broadcast();

  TextEditingController cepController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(mask: '##.###-###', filter: { "#": RegExp(r'[0-9]') });
  FocusNode textFieldFocus = FocusNode();
  String? msgError;

  EnderecoEntity endereco = EnderecoEntity();

  bool loading = false;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool web = MediaQuery.of(context).size.width > 650;

    return GestureDetector(
      onTap: () {
        textFieldFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBarWidget(web),
        backgroundColor: AppColors.secundary,
        body: web
          ? Center(
            child: SingleChildScrollView(
              child: Row(
                  children: [
                    Expanded(child: boxCep()),
                    Center(
                      child: Icon(
                        Icons.double_arrow_rounded,
                        color: AppColors.primary,
                        size: 80,
                      ),
                    ),
                    Expanded(child: boxEndereco())
                  ],
                ),
            ),
          )
          : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                boxCep(),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(90 / 360),
                  child: Icon(
                    Icons.double_arrow_rounded,
                    color: AppColors.primary,
                    size: 80,
                  )
                ),
                boxEndereco()
              ],
            ),
          )
      ),
    );
  }

  void _buscar() async {
    String cep = cepController.text.replaceAll(".", "").replaceAll("-", "");
    if (cep.length < 8) {
      msgError = "CEP inválido";
    } else {
      setState(() {
        loading = true;
      });
      var retorno = await Api.buscarCep(cep);
      if (retorno['erro'] == null || retorno['erro'].toString() != "true") {
        endereco = EnderecoEntity.fromMap(retorno);
      }
      loading = false;
    }
    setState(() {});
  }

  Widget boxCep() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Digite seu CEP abaixo:", style: AppTextStyles.title),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: cepController,
              inputFormatters: [maskFormatter],
              focusNode: textFieldFocus,
              onChanged: (_) {
                setState(() {
                  msgError = null;
                });
              },
              style: AppTextStyles.textFieldText,
              onFieldSubmitted: (_) => _buscar(),
              decoration: InputDecoration(
                hintText: "Ex: 00.000-000",
                errorText: msgError,
                errorStyle: AppTextStyles.textFieldTextError,
                hintStyle: AppTextStyles.textFieldTextGray,
                labelStyle: AppTextStyles.textFieldText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primary)
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.lightRed)
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.darkRed)
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
    );
  }

  Widget boxEndereco () {
    return Container(
      padding: EdgeInsets.all(20),
      child: loading
        ? Center(child: CircularProgressIndicator(color: AppColors.primary))
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Endereço do CEP ${cepController.text}:", style: AppTextStyles.title),
              SizedBox(height: 10),
              TextResultWidget("Rua", endereco.rua),
              TextResultWidget("Bairro", endereco.bairro),
              Row(
                children: [
                  Expanded(flex: 8, child: TextResultWidget("Cidade", endereco.cidade)),
                  SizedBox(width: 10),
                  Expanded(flex: 2, child: TextResultWidget("UF", endereco.uf)),
                ],
              ),
            ],
          )
    );
  }
}

                // try {
                //   _streamController.add(retorno);
                //   setState(() {});
                // } catch (e) {}



                // StreamBuilder (
                //   stream: _streamController.stream,
                //   builder: (context, snapshot) {
                //     switch (snapshot.connectionState) {
                //       case ConnectionState.none:
                //       case ConnectionState.waiting:
                //         return Center(
                //           child: CircularProgressIndicator(
                //             color: AppColors.primary,
                //           ),
                //         );
                //       default:
                //         if (snapshot.hasError || snapshot.data == null) {
                //           return Center(
                //             child: Column(
                //               children: [
                //                 Text(
                //                   "Ocorreu um erro ao buscar pelo CEP"
                //                 ),
                //                 Text(
                //                   "Verifique sua conexão e tente novamente"
                //                 )
                //               ],
                //             ),
                //           );
                //         } else {
                //           endereco = EnderecoEntity.fromMap(snapshot.data);
                //           return Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text("Endereço do CEP ${cepController.text}:", style: AppTextStyles.title),
                //               SizedBox(height: 10),
                //               TextResultWidget("Rua", endereco.rua),
                //               TextResultWidget("Bairro", endereco.bairro),
                //               Row(
                //                 children: [
                //                   Expanded(flex: 8, child: TextResultWidget("Cidade", endereco.cidade)),
                //                   SizedBox(width: 10),
                //                   Expanded(flex: 2, child: TextResultWidget("UF", endereco.uf)),
                //                 ],
                //               ),
                //             ],
                //           );
                //         }
                //     }
                //   },
                // )