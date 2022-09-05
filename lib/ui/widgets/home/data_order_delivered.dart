// ignore_for_file: file_names, deprecated_member_use, camel_case_types, library_private_types_in_public_api, use_key_in_widget_constructors, non_constant_identifier_names, await_only_futures, unused_import

//librerias de flutter
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

//Servicios
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/data_remote/data_consult/data_order_delivered.dart';
import '../../../app/data/data_remote/data_ordersatdestination.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';
import '../../pages/ordersAccepted/ordersTracking/orderDelivered/order_delivered_detail.dart';
import '../loading/loading.dart';

class dataOrderDelivered extends StatefulWidget {

    @override
    _data_order_delivered createState() => _data_order_delivered();
}

class _data_order_delivered extends State<dataOrderDelivered>{

    bool loading = true;
    var count = 0;

  List<data_Orders_Delivered> data_at_destination = <data_Orders_Delivered>[];

  Future<List<data_Orders_Delivered>?> cargar_datos_at_destination() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final DateTime now = DateTime.now();
        var date = now.toString().substring(0, 10);

        var id = await prefs.getString('id');
        final http = Http(baseUrl: urlGlobal().url);
        final result = await http.request('/orders?linkTo=status_order,id_user_order,date_updated_order&equalTo=3,$id,$date&select=id_order',
        method: HttpMethod.get,
        headers: {
          "Authorization": keyGlobal().key,
        },
        );
        if( result.statusCode == 200){
          var datos = result.data['results'];
          count = result.data['total'];
          var registros = <data_Orders_Delivered>[];
          for(var i = 0; i < count; i++){
            var datos2 = datos[i];
            registros.add(data_Orders_Delivered.fromJson(datos2));
          }
          return registros;
        }
        return [];
  }

  @override
  void initState() {

    super.initState();
    cargar_datos_at_destination().then((value){
      setState(() {
        data_at_destination.addAll(value!);
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
      child:
        FadeInLeft(
            child:Card(
              elevation: 2,
              color:  Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: <Widget>[
                  ListTile(
                  title:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.shopping_bag_rounded,
                          color: Theme.of(context).primaryColor,size: 30,),
                      const SizedBox(width: 10),
                      Text(
                        'Pedidos Entregados Hoy: $count',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                  ),
                ]
              ),
            ),
          ),
    );
  }

}