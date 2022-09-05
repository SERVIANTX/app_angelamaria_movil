// ignore_for_file: file_names, deprecated_member_use, non_constant_identifier_names, library_private_types_in_public_api, use_key_in_widget_constructors, camel_case_types

//librerias de flutter
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

//Servicios
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/data_remote/data_ordersatdestination.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';
import '../../pages/ordersAccepted/ordersTracking/orderDelivered/order_delivered_detail.dart';
import '../loading/loading.dart';

class orderDelivered extends StatefulWidget {

    @override
    _order_delivered createState() => _order_delivered();
}

class _order_delivered extends State<orderDelivered>{

    bool loading = true;
    var count = 0;

  List<Data_OrdersAtDestination> data_at_destination = <Data_OrdersAtDestination>[];

  Future<List<Data_OrdersAtDestination>?> cargar_datos_at_destination() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final DateTime now = DateTime.now();
        var date = now.toString().substring(0, 10);
        var id = prefs.getString('id');
        const select = 'id_order,date_order,address_order,phone_order,notes_order,displayname_customer,id_customer';
        final http = Http(baseUrl: urlGlobal().url);
        final result = await http.request('/relations?rel=orders,customers&type=order,customer&select=$select&linkTo=status_order,id_user_order,date_updated_order&equalTo=3,${id!},$date',
        method: HttpMethod.get,
        headers: {
          "Authorization": keyGlobal().key,
        },
        );
        if( result.statusCode == 200){
          var datos = result.data['results'];
          var count = result.data['total'];
          var registros = <Data_OrdersAtDestination>[];
          for(var i = 0; i < count; i++){
            var datos2 = datos[i];
            registros.add(Data_OrdersAtDestination.fromJson(datos2));
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
      child: loading == true ? Loading()
            :count != data_at_destination.length? ListView.builder(
              itemCount: data_at_destination.length,
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
                          Text("ENTREGADO", style: TextStyle(color: Colors.green)),
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const SizedBox(height: 15,),
                        Text('N° de pedido: #${data_at_destination[index].id_order}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3,),
                        ],),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Cliente: ${data_at_destination[index].displayname_customer}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3,),
                        Text('Dirección: ${data_at_destination[index].address_order}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                      ] ,),
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          ExtendedImage.network(
                            '${urlImgGlobal().urlImg}/users/${data_at_destination[index].id_customer}/${data_at_destination[index].id_customer}.png',
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
                            FlatButton(color:Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)), child: const Text('Ver Detalles', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)),
                            onPressed:(){
                              String id = data_at_destination[index].id_order.toString();
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                return OrderDeliveredDetail(id,data_at_destination[index].address_order,data_at_destination[index].phone_order,data_at_destination[index].date_order,data_at_destination[index].displayname_customer,data_at_destination[index].notes_order);
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
                      const Text('No hay pedidos entregados',
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