// ignore_for_file: file_names

//librerias de flutter
import 'package:flutter/material.dart';

//Servicios
import 'package:flutter/gestures.dart';

class Loading extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
      child: Center(
        child:SizedBox(
        width: 130,
        height: 130,
        child: CircularProgressIndicator(
          strokeWidth : 10,
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }

}