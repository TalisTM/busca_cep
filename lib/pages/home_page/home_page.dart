import 'dart:async';

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

  TextEditingController rua = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController cidade = TextEditingController();
  TextEditingController uf = TextEditingController();

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
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 1000
                ),
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
                boxEndereco(),
                SizedBox(height: 30)
              ],
            ),
          )
      ),
    );
  }

  void _buscar() async {
    String cep = cepController.text.replaceAll(".", "").replaceAll("-", "");
    if (cep.length < 8) {
      msgError = "CEP inv??lido";
    } else {
      setState(() {
        loading = true;
      });
      Map<String, dynamic> retorno = await Api.buscarCep(cep);
      if (retorno['erro'] == null || retorno['erro'].toString() != "true") {
        endereco = EnderecoEntity.fromMap(retorno);
      } else {
        endereco = EnderecoEntity();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.secundary,
            title: Text("Erro", style: AppTextStyles.titleErro),
            content: Text("Lamentamos, ocorreu um erro ao buscar pelo CEP: \"${cepController.text}\".\nVerifique sua conex??o e tente novamente.", style: AppTextStyles.content),
            actions: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: AppColors.gradientButton,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text("Ok", style: AppTextStyles.buttonText),
                    ),
                  ),
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () => Navigator.pop(context)
                ),
              )
            ],
          ));
      }

      rua.text = endereco.rua;
      bairro.text = endereco.bairro;
      cidade.text = endereco.cidade;
      uf.text = endereco.uf;
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
          TextFormField(
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
          SizedBox(height: 20),
          TextButton(
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
              Text("Endere??o do CEP ${cepController.text}:", style: AppTextStyles.title),
              SizedBox(height: 10),
              TextResultWidget("Rua", rua, endereco.rua),
              TextResultWidget("Bairro", bairro, endereco.bairro),
              Row(
                children: [
                  Expanded(flex: 75, child: TextResultWidget("Cidade", cidade, endereco.cidade)),
                  SizedBox(width: 10),
                  Expanded(flex: 25, child: TextResultWidget("UF", uf, endereco.uf)),
                ],
              ),
            ],
          )
    );
  }
}