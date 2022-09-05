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
              Text("Políticas de privacidad", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
              SizedBox(height: 10,),
              Text("Queda prohibido alterar o modificar ninguna parte de la APP a de los contenidas de la misma, eludir, desactivar o manipular de cualquier otra forma (o tratar de eludir, desactivar o manipular) las funciones de seguridad u otras funciones del programa y utilizar la APP o sus contenidos para un fin comercial o publicitario. Queda prohibido el uso de la APP con la finalidad de lesionar bienes, derechos o intereses de Angela Maria o de terceros. Queda igualmente prohibido realizar cualquier otro uso que altere, dañe o inutilice las redes, servidores, equipos, productos y programas informáticos de Angela Maria o de terceros.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
              SizedBox(height: 15,),
              Text("Copyright", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
              SizedBox(height: 10,),
              Text("La APP y sus contenidos (textos, fotografías, gráficos, imágenes, tecnología, software, links, contenidos, diseño gráfico, código fuente, etc.), así como las marcas y demás signos distintivos son propiedad de Angela Maria o de terceros, no adquiriendo el Usuario ningún derecho sobre ellos por el mero uso de la APP. El Usuario, deberá abstenerse de:", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
              SizedBox(height: 8,),
            Text("Reproducir, copiar, distribuir, poner a disposición de terceros, comunicar públicamente, transformar o modificar la APP o sus contenidos, salvo en los casos contemplados en la ley o expresamente autorizados por Angela Maria o por el titular de dichos derechos", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 8,),
            Text("Reproducir o copiar para uso privado la APP o sus contenidos, así como comunicarlos públicamente o ponerlos a disposición de terceros cuando ello conlleve su reproducción. Asi como extraer o reutilizar todo o parte sustancial de los contenidos integrantes de la APP.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            Text("Politicas sujetos a cambios", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
            SizedBox(height: 10,),
            Text("Podemos, sin que esto suponga ninguna obligación contigo, modificar estas politicas de uso sin avisar en cualquier momento. Si continúas utilizando la aplicación una vez realizada cualquier modificación en estas Condiciones de uso, esa utilización continuada constituirá la aceptación por tu parte de tales modificaciones. Si no aceptas estas condiciones de uso ni aceptas quedar sujeto a ellas, no debes utilizar la aplicación ni descargar o utilizar cualquier software relacionado. El uso que hagas de la aplicación queda bajo tu única responsabilidad. No tenemos responsabilidad alguna por la eliminación o la incapacidad de almacenar o trasmitir cualquier contenido u otra información mantenida o trasmitida por la aplicación. No somos responsables de la precisión o la fiabilidad de cualquier información o consejo trasmitidos a través de la aplicación. Podemos, en cualquier momento, limitar o interrumpir tu uso a nuestra única discreción. Hasta el máximo que permite la ley, en ningún caso seremos responsables por cualquier pérdida o daño relacionados.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            Text("Privacidad", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Antipasto'),),
            SizedBox(height: 10,),
            Text("El Usuario se compromete a hacer un uso correcto de la APP, de conformidad con la Ley, con los presentes Términos y Condiciones de Uso y con las demás reglamentos e instrucciones que, en su caso, pudieran ser de aplicación El Usuario responderá frente a Angela Maria y frente a terceros de cualesquiera daños o perjuicios que pudieran causarse por incumplimiento de estas obligaciones.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,),
            SizedBox(height: 15,),
            ],
          ),
        ],
      ),

    );
  }
}