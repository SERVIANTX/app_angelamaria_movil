// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, camel_case_types, library_private_types_in_public_api, non_constant_identifier_names

//librerias de flutter
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

//Servicios
import '../../../app/data/data_remote/data_orders.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';
import '../../../config/global_variables.dart';
import '../../pages/orders/order_detail_page.dart';
import '../loading/loading.dart';

class OrderAssigment extends StatefulWidget {

    @override
    _order_Assigment createState() => _order_Assigment();
}

class _order_Assigment extends State<OrderAssigment>{

    bool loading = true;
    var count = 0;

  List<Data_Orders> data = <Data_Orders>[];

  Future<List<Data_Orders>> TraerDatos() async{
    const select = 'id_order,date_order,address_order,phone_order,notes_order,displayname_customer,id_customer';
    final http = Http(baseUrl: urlGlobal().url);
    const complement = '/relations?rel=orders,customers&type=order,customer&select=$select&linkTo=status_order&equalTo=0';
    final result = await http.request(complement,
      method: HttpMethod.get,
      headers: {
        "Authorization": keyGlobal().key,
      },
    );
    if(result.statusCode == 200){
      var datos = result.data['results'];
      var count = result.data['total'];
      var registros = <Data_Orders>[];
      for(var i = 0; i < count; i++){
        var datos2 = datos[i];
        registros.add(Data_Orders.fromJson(datos2));
      }
      return registros;
    }
    return [];
  }

  @override
  void initState() {

    super.initState();
    TraerDatos().then((value){
      setState(() {
        data.addAll(value);
          loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
      child: loading == true ?Loading()
      :count != data.length? Column(
        children: [
          Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    'Pedidos',
                    style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .apply(fontWeightDelta: 2),
                  ),
                  const SizedBox(height: 15),
                ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.all(15),
                  elevation: 10,
                  child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const Text('',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                        Text('N° de pedido: #${data[index].id_order}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),],),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(' Cliente: ${data[index].displayname_customer}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                        Text(' Dirección: ${data[index].address_order}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                      ] ,),
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          ExtendedImage.network(
                            '${urlImgGlobal().urlImg}/users/${data[index].id_customer}/${data[index].id_customer}.png',
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
                            FlatButton(color:const Color(0xFF6366F1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)), child: const Text('Ver detalles', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)),
                          onPressed:(){
                            String id = data[index].id_order.toString();
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return OrderDetailPage(id,data[index].address_order,data[index].phone_order,data[index].date_order,data[index].displayname_customer,data[index].notes_order);
                            }
                            ));
                          },),
                          const SizedBox(width: 10, height: 60,),
                          ],
                    ),
                  ],
                ),
                ),
                );
              },
            ),
            ),
        ],
      ) : Container(
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.center,
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.list_alt_rounded, color: Theme.of(context).primaryColor, size: 75,),
          const SizedBox(height: 15),
          Container(
            alignment: Alignment.center,
            child:
              const Text('No hay pedidos',
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