// ignore_for_file: file_names, use_key_in_widget_constructors

//Librerias de flutter
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading:BackButton(
                color: Theme.of(context).canvasColor
              ),
      backgroundColor: Theme.of(context).backgroundColor,
      title:Row(
        children:[
          Text(
            'Políticas de privacidad',
            style: Theme.of(context)
              .textTheme
              .headline2!
              .apply(fontWeightDelta: 2),
          ),
        ]
      ),
    ),
    backgroundColor:  Theme.of(context).backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(15),
        children:
          [Column(
            children:  const [
              Text("Términos y condiciones", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
              SizedBox(height: 10,),
              Text("Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
              SizedBox(height: 15,),
              Text("Usar los servicios y plataformas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
              SizedBox(height: 10,),
              Text("Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
              SizedBox(height: 15,),
              Text("Usar los servicios y plataformas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
            SizedBox(height: 10,),
            Text("Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            Text("Usar los servicios y plataformas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
            SizedBox(height: 10,),
            Text("Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            Text("Usar los servicios y plataformas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
            SizedBox(height: 10,),
            Text("Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            Text("Usar los servicios y plataformas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
            SizedBox(height: 10,),
            Text("Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones. Para usar esa aplicación es necesario que aceptes los términos y condiciones.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            ],
          ),
        ],
      ),

    );
  }
}