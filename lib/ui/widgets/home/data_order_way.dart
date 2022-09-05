// ignore_for_file: file_names, deprecated_member_use, camel_case_types, library_private_types_in_public_api, use_key_in_widget_constructors, non_constant_identifier_names, await_only_futures

//librerias de flutter
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

//Servicios
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/data_remote/data_consult/data_order_in_transit.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';

class dataorderWay extends StatefulWidget {

    @override
    _data_order_way createState() => _data_order_way();
}

class _data_order_way extends State<dataorderWay>{

    bool loading = true;
    var count = 0;

  List<data_Orders_In_Transit> data_in_transit = <data_Orders_In_Transit>[];

  Future<List<data_Orders_In_Transit>?> cargar_datos_in_transit() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var id = await prefs.getString('id');
        final http = Http(baseUrl: urlGlobal().url);

        final result = await http.request('/orders?linkTo=status_order,id_user_order&equalTo=2,$id&select=id_order',
        method: HttpMethod.get,
        headers: {
          "Authorization": keyGlobal().key,
        },
        );
        if( result.statusCode == 200){
          var datos = result.data['results'];
          count = result.data['total'];
          var registros = <data_Orders_In_Transit>[];
          for(var i = 0; i < count; i++){
            var datos2 = datos[i];
            registros.add(data_Orders_In_Transit.fromJson(datos2));
          }
          return registros;
        }
        return [];
  }

  @override
  void initState() {

    super.initState();
    cargar_datos_in_transit().then((value){
      setState(() {
        data_in_transit.addAll(value!);
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.airport_shuttle,
                          color: Theme.of(context).primaryColor,size: 30,),
                      const SizedBox(width: 10),
                      Text(
                        'Pedidos en Camino: $count',
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