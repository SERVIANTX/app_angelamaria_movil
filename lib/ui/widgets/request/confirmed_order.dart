// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors

//librerias de flutter
import 'package:flutter/material.dart';

//Servicios
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/data_remote/data_ordersaccepted.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';
import '../../pages/ordersAccepted/ordersTracking/confirmedOrder/confirmed_order_detail.dart';
import '../loading/loading.dart';

class ConfirmedOrder extends StatefulWidget {

    @override
    _confirmed_Order createState() => _confirmed_Order();
}

class _confirmed_Order extends State<ConfirmedOrder>{

    bool loading = true;
    var count = 0;

  List<Data_OrdersAccepted> data_accepted = <Data_OrdersAccepted>[];

  Future<List<Data_OrdersAccepted>?> cargar_datos_accepted() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // ignore: await_only_futures
        var id = await prefs.getString('id');
        final http = Http(baseUrl: urlGlobal().url);

        final result = await http.request('/orders?linkTo=status_order,id_userrepartidor_order&equalTo=1,${id!}&select=*',
        method: HttpMethod.get,
        headers: {
          "Authorization": keyGlobal().key,
        },
        );
        if( result.statusCode == 200){
          var datos = result.data['results'];
          var count = result.data['total'];
          var registros = <Data_OrdersAccepted>[];
          for(var i = 0; i < count; i++){
            var datos2 = datos[i];
            registros.add(Data_OrdersAccepted.fromJson(datos2));
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
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
      child: loading == true ? Loading()
            :count != data_accepted.length? ListView.builder(
              itemCount: data_accepted.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(15),
                  elevation: 10,
                  child: Column(
                  children: <Widget>[
                    ListTile(
                      trailing: Column(
                        children: const [
                          Text("CONFIRMADO", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const Text('',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                        Text('N° de pedido: ${data_accepted[index].id_order}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3,),
                        ],),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Cliente: ${data_accepted[index].namepickup_order}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3,),
                        Text('Dirección: ${data_accepted[index].address_order}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                      ] ,),
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('',style: TextStyle(fontSize: 5)),
                          Image.network('${urlImgGlobal().urlImg}/users/${data_accepted[index].id_user_order}/${data_accepted[index].id_user_order}.png',height: 45,width: 45,),
                          ],)
                    ),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(color:Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)), child: const Text('Actualizar', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)),
                            onPressed:(){
                              String id = data_accepted[index].id_order.toString();
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                return ConfirmedOrderDetail(id,data_accepted[index].address_order,data_accepted[index].phone_order,data_accepted[index].date_order,data_accepted[index].namepickup_order);
                              }
                              ));
                            },),
                            const SizedBox(width: 10, height: 60,),
                          ],
                        )
                  ],
                ),
                ),
                );
              },
            ):Container(
                alignment: Alignment.center,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_rounded, color: Theme.of(context).primaryColor, size: 75,),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.center,
                    child:
                      const Text('No hay pedidos Aceptados',
                        style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Antipasto',
                              color: Colors.grey,
                            ),
                            ),
                  ),
                ],
                ),
              ),
              ),
    );
  }

}