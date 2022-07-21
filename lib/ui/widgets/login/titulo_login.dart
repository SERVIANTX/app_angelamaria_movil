// ignore_for_file: use_key_in_widget_constructors

//librerias de flutter
import 'package:flutter/material.dart';

class Titulo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children:[
          Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .headline3!
          ),
          const SizedBox(height: 7.5),
          Text(
            'Bienvenido de vuelta!',
            style: Theme.of(context)
                .textTheme
                .headline2!
          ),
        ],
      ),
      );
  }

}