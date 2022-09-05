// ignore_for_file: file_names, use_key_in_widget_constructors

//Librerias de flutter
import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: BackButton(
                  color: Theme.of(context).canvasColor
                ),
      backgroundColor: Theme.of(context).backgroundColor,
      title:Row(
        children: [
          Text(
            'Términos y Condiciones',
            style: Theme.of(context)
                .textTheme
                .headline2!
          ),
        ]
      ),
    ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(15),
        children:
          [Column(
            children:  const [
              Text("Términos y condiciones", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Estos Términos y Condiciones de Uso regulan las reglas a que se sujeta la utilización de la APP, que puede descargarse desde el dominio e-angelamaria.me. La descarga o utilización de la APP atribuye la condición de usuario a quien lo haga e implica la aceptación de todas las condiciones incluidas en este documento y en la Política de Privacidad y el Aviso Legal de dicha página Web. El Usuario debería leer estas condiciones cada vez que utilice la APP, ya que podrían ser modificadas en lo sucesivo.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
              SizedBox(height: 15,),
              Text("Usar los servicios y plataformas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Únicamente los Usuarios expresamente autorizados por Angela Maria podrán acceder a la descarga y uso de la APP. Los Usuarios que no dispongan de autorización, no podrán acceder a dicho contenido.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
              SizedBox(height: 15,),
              Text("Cargos de uso", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Eres responsable del pago de todos los costes o gastos en los que incurras como resultado de descargar y usar la Aplicación de Angela Maria, incluido cualquier cargo de red de operador o itinerancia. Consulta con tu proveedor de servicios los detalles al respecto.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            Text("Estadísticas anónimas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Angela Maria se reserva el derecho a realizar un seguimiento de tu actividad en la Aplicación de y a informar de ello a nuestros proveedores de servicios estadísticos de terceros. Todo ello de forma anónima.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            Text("Protección de tu información personal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("queremos ayudarte a llevar a cabo todos los pasos necesarios para proteger tu privacidad e información. Consulta la Política de privacidad de Angela Maria y los avisos sobre privacidad de la Aplicación para conocer qué tipo de información recopilamos y las medidas que tomamos para proteger tu información personal.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            Text("Condiciones de uso", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Con sujeción a las condiciones establecidas en el apartado anterior, Angela Maria concede al Usuario una licencia de uso de la APP, no exclusiva, gratuita, para uso personal, circunscrita al territorio nacional y con carácter indefinido. Dicha licencia se concede también en los mismos términos con respecto a las actualizaciones y mejoras que se realizasen en la aplicación. Dichas licencias de uso podrán ser revocadas por Angela Maria unilateralmente en cualquier momento, mediante la mera notificación al Usuario.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            ],
          ),
        ],
      ),

    );
  }
}