// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, await_only_futures

//librerias de flutter
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

//Servicios
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/data_remote/data_consult/data_order_accepted.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';

class dataOrderActive extends StatefulWidget {

    @override
    _data_order_active createState() => _data_order_active();
}

class _data_order_active extends State<dataOrderActive>{


    var count = 0;
    var count2 = 0;

  List<data_Orders_Accepted> data_accepted = <data_Orders_Accepted>[];

  Future<List<data_Orders_Accepted>?> cargar_datos_accepted() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var id = await prefs.getString('id');
        final http = Http(baseUrl: urlGlobal().url);
        final result = await http.request('/orders?linkTo=id_user_order&equalTo=$id&select=status_order,id_order',
        method: HttpMethod.get,
        headers: {
          "Authorization": keyGlobal().key,
        },
        );
        if(result.statusCode == 200){
          var datos = result.data['results'];
          count = result.data['total'];
          var registros = <data_Orders_Accepted>[];
          for(var i = 0; i < count; i++){
            var datos2 = datos[i];
            registros.add(data_Orders_Accepted.fromJson(datos2));

            if(datos2['status_order'] == '1'){
              count2++;

            }else if(datos2['status_order'] == '2'){
              count2++;
            }
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
          FadeInDown(
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
                      Icon(Icons.local_activity_sharp,
                          color: Theme.of(context).primaryColor,size: 30,),
                      const SizedBox(width: 16),
                      Text(
                        'Pedidos activos: $count2',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
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