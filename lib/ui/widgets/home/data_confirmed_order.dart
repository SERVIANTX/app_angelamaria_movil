// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, await_only_futures

//librerias de flutter
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

//Servicios
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/data_remote/data_consult/data_cofirmed_order.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';

class dataConfirmedOrder extends StatefulWidget {

    @override
    _data_confirmed_order createState() => _data_confirmed_order();
}

class _data_confirmed_order extends State<dataConfirmedOrder>{

    bool loading = true;
    var count = 0;

  List<data_Confirmed_Order> data_accepted = <data_Confirmed_Order>[];

  Future<List<data_Confirmed_Order>?> cargar_datos_accepted() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var id = await prefs.getString('id');
        final http = Http(baseUrl: urlGlobal().url);

        final result = await http.request('/orders?linkTo=status_order,id_user_order&equalTo=1,$id&select=id_order',
        method: HttpMethod.get,
        headers: {
          "Authorization": keyGlobal().key,
        },
        );
        if( result.statusCode == 200){
          var datos = result.data['results'];
          count = result.data['total'];
          var registros = <data_Confirmed_Order>[];
          for(var i = 0; i < count; i++){
            var datos2 = datos[i];
            registros.add(data_Confirmed_Order.fromJson(datos2));
          }
          return registros;
        }
        return [];
  }

  @override
  void initState() {

    super.initState();
    cargar_datos_accepted().then((value){
      setState(() {
        data_accepted.addAll(value!);
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
                      Icon(Icons.done_all_rounded,
                          color: Theme.of(context).primaryColor,size: 30,),
                      const SizedBox(width: 10),
                      Text(
                        'Pedidos Preparandose: $count',
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