import 'package:busca_cep/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Busca CEP",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}