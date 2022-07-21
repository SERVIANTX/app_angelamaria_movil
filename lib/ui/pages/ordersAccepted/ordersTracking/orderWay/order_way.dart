// ignore_for_file: file_names, deprecated_member_use, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:app_angelamaria_movil/ui/pages/ordersAccepted/ordersTracking/orderWay/order_way_detail.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../../../app/data/data_required/data_required.dart';

//Consumidores de api
import '../../../../../app/data/helpers/http.dart';
import '../../../../../app/data/helpers/http_method.dart';
import '../../../../../app/data/data_remote/data_ordersdetail.dart';

//Librerias de flutter
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//Servicios
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:emojis/emojis.dart';
import '../../../../../Services/String/string_extension.dart';
import '../../../../../Services/notifications/notificationservice.dart';
// import 'package:phone_caller/phone_caller.dart';

//Variables Globales
import '../../../../../config/global_variables.dart';
import '../../../../widgets/loading/loading.dart';


class OrderOnTheWay extends StatefulWidget {

    String id;
    String address;
    String phone;
    String date;
    String namepickup;

    OrderOnTheWay(this.id,this.address,this.phone,this.date,this.namepickup);

    @override

    _OrderOnTheWay createState() => _OrderOnTheWay();

}

class _OrderOnTheWay extends State<OrderOnTheWay>{

  File? image;
  String? img64;
  File? file;

  Future pickImage(ImageSource source) async {
    try{
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
      final bytes = File(image.path).readAsBytesSync();
        img64 = base64Encode(bytes);
    }
    on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Navigator.of(context).pop();
  }

  optionCamera(context){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            title: Text('Elige una opción',style: TextStyle(color: Theme.of(context).primaryColor),),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(height: 1,color: Theme.of(context).primaryColor,),
                  ListTile(
                    onTap: (){
                      pickImage(ImageSource.camera);
                    },
                    title: Text('Cámara', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).canvasColor)),
                    leading: Icon(Icons.camera,color: Theme.of(context).primaryColor,),
                  ),
                  Divider(height: 1,color: Theme.of(context).primaryColor,),
                  ListTile(
                    onTap: (){
                      pickImage(ImageSource.gallery);
                    },
                    title: Text('Galería', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).canvasColor)),
                    leading: Icon(Icons.account_box,color: Theme.of(context).primaryColor,),
                  ),
                ],
              ),
            ),
          );
        }
      );
    }

  @override
  Widget build(BuildContext context) {
    DateTime date =DateTime.parse(widget.date);
    var outputFormat = DateFormat('hh:mm a | MM/dd/yyyy');
    var outputDate = outputFormat.format(date);
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
                    color: Theme.of(context).canvasColor
                  ),
          backgroundColor: Theme.of(context).backgroundColor,
          title:Row(
            children: [
              Text(
                'Detalles del pedido N° ${widget.id}',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .apply(fontWeightDelta: 2),
              ),
            ]
          ),
        ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    'Datos:',
                    style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .apply(fontWeightDelta: 2),
                  ),
                ],
              ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(15),
            elevation: 10,
            child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                title: Text('Pedido N° ${widget.id}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).canvasColor)),
                subtitle:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const SizedBox(height: 3,),
                        RichText(text: TextSpan(
                          children:<TextSpan>[ TextSpan(text: 'Fecha: ' ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
                          TextSpan(text: outputDate ,style: TextStyle(fontSize: 17,color: Theme.of(context).canvasColor),
                          ),
                          ],
                        )),
                        const SizedBox(height: 3,),
                        RichText(text: TextSpan(
                          children:<TextSpan>[ TextSpan(text: 'Cliente: ' ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
                          TextSpan(text: widget.namepickup ,style: TextStyle(fontSize: 17,color: Theme.of(context).canvasColor),
                          ),
                          ],
                        )),
                        const SizedBox(height: 5),
                        RichText(text: TextSpan(
                          children:<TextSpan>[ TextSpan(text: 'Celular: ' ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
                          TextSpan(text: widget.phone ,style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColor),
                            recognizer: TapGestureRecognizer()..onTap = () async{
                              FlutterPhoneDirectCaller.callNumber(widget.phone);
                            }
                          ),
                          ],
                        )),
                        const SizedBox(height: 5),
                        RichText(text: TextSpan(
                          children:<TextSpan>[ TextSpan(text: 'Dirección: ' ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
                          TextSpan(text: widget.address ,style: TextStyle(fontSize: 17,color: Theme.of(context).canvasColor)),
                          ],
                        )),
                        const SizedBox(height: 18,),
                        FlatButton(color:const Color(0xFF6366F1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)), child: const Text('Ver productos', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)),
                          onPressed:(){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return OrderWayDetail(widget.id, widget.address, widget.phone, widget.date, widget.namepickup);
                            }
                            ));
                          },),
                            const SizedBox(width: 10,),
                        ] ,
                        ),
              ),
            ],
          ),
          ),
          Column(
              children: [
                const SizedBox(height: 15),
                Text('Imagen:',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
              ],
            ),
          Expanded(
            child:Column(
              children: [
              FlatButton(color:const Color(0xFF6366F1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)), child: const Text('Tomar la captura del DNI', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)),
                          onPressed:() async{
                            optionCamera(context);
                          },
                        ),
              const SizedBox(height: 20,),
              image == null ? Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 158, 165, 173),
                          blurRadius: 10,
                          offset: Offset(1, 1)),
                    ],
                    color: Theme.of(context).cardColor,
                  ),
                  margin: const EdgeInsets.only(top: 5, right: 20, left: 20,bottom: 5),   // Establece un margin de 10 en todas las direcciones
                  alignment: Alignment.center,
                  child: Text('Esperando la imagen...',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
                ),
              ) : Image.file(image!,width: 350,height: 200,fit: BoxFit.cover,),
              ],
            )
            ),

            FadeInDown(
              child:Container(
              margin: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                boxShadow:  const [
                  BoxShadow(
                      color: Color.fromARGB(255, 158, 165, 173),
                      blurRadius: 10,
                      offset: Offset(1, 1)),
                ],
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(50))),
                child:FlatButton(color:Theme.of(context).cardColor,
                splashColor: Theme.of(context).primaryColor,
                minWidth: 300.0,
                height: 45.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                child:
                  Text(
                        ' Actualizar estado ',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                      ),
                onPressed:() async{

                  if(img64 == null){
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.RIGHSLIDE,
                      headerAnimationLoop: true,
                      title: 'Error',
                      desc:
                          'Debes de tomar foto al dni del Cliente.',
                      btnOkOnPress: () {},
                      btnOkIcon: Icons.cancel,
                      btnOkColor: Colors.red,
                    ).show();
                  }else{
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.QUESTION,
                      headerAnimationLoop: false,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Actualizar pedido',
                      desc: '¿Verificastes la calidad de la imagen?',
                      buttonsTextStyle: TextStyle(color: Theme.of(context).canvasColor),
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async{
                          final http = Http(baseUrl: urlImgGlobal().urlImg);

                          final result = await http.request('/api.php',
                          method: HttpMethod.post,
                          headers: {
                            "Authorization": keyGlobal().key,
                          },
                          body: {
                            "src": img64,
                            "name": widget.id,
                          },
                          );
                          if(result.statusCode == 200){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var token = prefs.getString('token');
                            var id = prefs.getString('id');

                            final http = Http(baseUrl: urlGlobal().url);

                            final result = await http.request('/orders?id=${widget.id}&nameId=id_order&token=${token!}&table=users&suffix=user',
                            method: HttpMethod.put,
                            headers: {
                              "Authorization": keyGlobal().key,
                            },
                            body: {
                              "status_order": '3',
                              "id_userrepartidor_order": id,
                              "dni_picture_order": '${widget.id}.png',
                            },
                            );
                            if(result.statusCode == 200){
                                Navigator.of(context).pop();
                                  final snackBar = SnackBar(
                                    margin: const EdgeInsets.all(17),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                    behavior: SnackBarBehavior.floating,
                                    content: const Text('Pedido entregado exitosamente',style: TextStyle(fontSize: 16.0,fontFamily: 'Antipasto'), textAlign: TextAlign.center,),
                                    backgroundColor: const Color.fromARGB(255, 42, 146, 39),
                                    duration: const Duration(seconds: 2),
                                    padding: const EdgeInsets.all(16.0),
                                  );
                                NotificationService().stylishNotification(
                                1,
                                '🛍️ Pedido N° ${widget.id} ha sido entregado!',
                                '¡Entrega exitosa!'
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else{
                              Navigator.of(context).pop();
                              final snackBar = SnackBar(
                                  margin: const EdgeInsets.all(17),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text('Error al actualizar el pedido',style: TextStyle(fontSize: 16.0,fontFamily: 'Antipasto'), textAlign: TextAlign.center,),
                                  backgroundColor: const Color.fromARGB(255, 42, 146, 39),
                                  duration: const Duration(seconds: 2),
                                  padding: const EdgeInsets.all(16.0),
                                );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }else{
                            Navigator.of(context).pop();
                            final snackBar = SnackBar(
                                margin: const EdgeInsets.all(17),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                behavior: SnackBarBehavior.floating,
                                content: const Text('Error al subir la imagen intente nuevamente',style: TextStyle(fontSize: 16.0,fontFamily: 'Antipasto'), textAlign: TextAlign.center,),
                                backgroundColor: const Color.fromARGB(255, 42, 146, 39),
                                duration: const Duration(seconds: 2),
                                padding: const EdgeInsets.all(16.0),
                              );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                      },
                      ).show();
                  }
                    }
                  ),
                ),
            ),
            Column(
              children: const [
                SizedBox(height: 15),
              ],
            ),
        ],
      )
    );
  }

}
