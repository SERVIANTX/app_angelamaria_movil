// ignore_for_file: file_names, deprecated_member_use, must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously


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


class OrderWayDetail extends StatefulWidget {

    String id;
    String address;
    String phone;
    String date;
    String namepickup;

    OrderWayDetail(this.id,this.address,this.phone,this.date,this.namepickup);

    @override

    _OrderWayDetail createState() => _OrderWayDetail();

}

class _OrderWayDetail extends State<OrderWayDetail>{

  bool loading = true;

  List<Data_OrdersDetail> data = <Data_OrdersDetail>[];

  // ignore: body_might_complete_normally_nullable
  Future<List<Data_OrdersDetail>?> cargardatos() async{
    final http = Http(baseUrl: urlGlobal().url);
        final result = await http.request('/relations?rel=ordersdetails,products&type=orderdetail,product&select=*&linkTo=id_order&equalTo=${widget.id}',
        method: HttpMethod.get,
        headers: {
          "Authorization": variablesGlobales().key,
        },
        );
        var datos = result.data['results'];
        var count = result.data['total'];
        var registros = <Data_OrdersDetail>[];
        for(var i = 0; i < count; i++){
          var datos2 = datos[i];
          registros.add(Data_OrdersDetail.fromJson(datos2));
        }
       return registros;
  }
  @override
  void initState() {
    super.initState();
    cargardatos().then((value){
      setState(() {
        data.addAll(value!);
        loading = false;
      });
    });
  }
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
                Text('Productos:',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
              ],
            ),
          Expanded(
            child: loading==true ? Loading()
            :ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(5),
                  elevation: 10,
                  child: Column(
                  children: <Widget>[
                    ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          RichText(text: TextSpan(
                          children:<TextSpan>[TextSpan(text: 'Producto: ' ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
                            TextSpan(text: data[index].name_product.toCapitalized(), style: TextStyle(fontSize: 17,color: Theme.of(context).canvasColor)),
                            ],
                          )),
                          ],),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        RichText(text: TextSpan(
                          children:<TextSpan>[ TextSpan(text: 'Cantidad: ' ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor,fontFamily: 'Antipasto')),
                            TextSpan(text: data[index].quantity_orderdetail.toString() , style: TextStyle(fontSize: 17,color: Theme.of(context).canvasColor)),
                            ],
                          )),
                      ] ,),
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('',style: TextStyle(fontSize: 5)),
                          Image.network("${urlImgGlobal().urlImg}/products/${data[index].image_product}",height: 45,width: 45,),
                          ],)
                    )
                  ],
                ),
                ),
                );
              },
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
