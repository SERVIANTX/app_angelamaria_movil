// ignore_for_file: file_names, deprecated_member_use, camel_case_types, library_private_types_in_public_api, use_key_in_widget_constructors, non_constant_identifier_names

//librerias de flutter
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

//Servicios
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/data_remote/data_ordersintransit.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';
import '../../pages/ordersAccepted/ordersTracking/orderWay/order_way.dart';
import '../loading/loading.dart';

class orderWay extends StatefulWidget {

    @override
    _order_way createState() => _order_way();
}

class _order_way extends State<orderWay>{

    bool loading = true;
    var count = 0;

  List<Data_OrdersInTransit> data_in_transit = <Data_OrdersInTransit>[];

  Future<List<Data_OrdersInTransit>?> cargar_datos_in_transit() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var id = prefs.getString('id');
        final http = Http(baseUrl: urlGlobal().url);
        const select = 'id_order,date_order,address_order,phone_order,notes_order,displayname_customer,id_customer';
        final result = await http.request('/relations?rel=orders,customers&type=order,customer&select=$select&linkTo=status_order,id_user_order&equalTo=2,${id!}',
        method: HttpMethod.get,
        headers: {
          "Authorization": keyGlobal().key,
        },
        );
        if( result.statusCode == 200){
          var datos = result.data['results'];
          var count = result.data['total'];
          var registros = <Data_OrdersInTransit>[];
          for(var i = 0; i < count; i++){
            var datos2 = datos[i];
            registros.add(Data_OrdersInTransit.fromJson(datos2));
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
      child: loading == true ? Loading()
            :count != data_in_transit.length? ListView.builder(
              itemCount: data_in_transit.length,
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
                          Text("EN CAMINO", style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const SizedBox(height: 15,),
                        Text('N° de pedido: #${data_in_transit[index].id_order}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3,),
                        ],),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Cliente: ${data_in_transit[index].displayname_customer}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3,),
                        Text('Dirección: ${data_in_transit[index].address_order}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                      ] ,),
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          ExtendedImage.network(
                            '${urlImgGlobal().urlImg}/users/${data_in_transit[index].id_customer}/${data_in_transit[index].id_customer}.png',
                            fit: BoxFit.contain,
                            mode: ExtendedImageMode.gesture,
                            initGestureConfigHandler: (ExtendedImageState state) {
                              return GestureConfig(
                                inPageView: true,
                                initialScale: 1.0,
                                maxScale: 5.0,
                                animationMaxScale: 6.0,
                                initialAlignment: InitialAlignment.center,
                              );
                            },
                            width: 45,
                            height: 45,
                          ),
                          ],)
                    ),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(color:Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)), child: const Text('Actualizar', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)),
                            onPressed:(){
                              String id = data_in_transit[index].id_order.toString();
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                return OrderOnTheWay(id,data_in_transit[index].address_order,data_in_transit[index].phone_order,data_in_transit[index].date_order,data_in_transit[index].displayname_customer,data_in_transit[index].notes_order);
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
                      const Text('No hay pedidos en camino',
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