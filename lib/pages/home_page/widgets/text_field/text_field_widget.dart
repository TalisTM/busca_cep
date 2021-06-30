import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class TextFieldWidget extends StatelessWidget {
  final MaskedTextController controller;
  TextFieldWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

      ),
      child: TextField(
        keyboardType: TextInputType.number,  
        controller: controller,
        
      ),
    );
  }
}