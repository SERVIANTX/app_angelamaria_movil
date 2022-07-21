// ignore_for_file: file_names, use_key_in_widget_constructors

//librerias de flutter
import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: 65,
      left: MediaQuery.of(context).size.width * 0.27,
      child: SizedBox(
        height: 200,
        width: 200,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset('lib/assets/img/LOGO2.png',),
        ),
      ),
    );
  }
}