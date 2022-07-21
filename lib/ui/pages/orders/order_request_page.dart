// ignore_for_file: file_names, deprecated_member_use, library_private_types_in_public_api, use_key_in_widget_constructors, non_constant_identifier_names

//Librerias de flutter
import 'package:flutter/material.dart';

//Consumidores de api
import '../../../app/data/data_remote/data_orders.dart';
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';

//Variables Globales
import '../../../config/global_variables.dart';

//paginas
import '../../widgets/loading/loading.dart';
import 'order_detail_page.dart';


class OrderRequestPage extends StatefulWidget {

    @override
    _OrderRequestState createState() => _OrderRequestState();

}

class _OrderRequestState extends State<OrderRequestPage>{

  var count = 0;
  bool loading = true;

  List<Data_Orders> data = <Data_Orders>[];

  Future<List<Data_Orders>> TraerDatos() async{

    final http = Http(baseUrl: urlGlobal().url);
    final result = await http.request('/orders?select=*&linkTo=status_order&equalTo=0',
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
    })
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:Container(
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
                        Text('N° de pedido: ${data[index].id_order}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),],),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(' Cliente: ${data[index].namepickup_order}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                        Text(' Dirección: ${data[index].address_order}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
                      ] ,),
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('',style: TextStyle(fontSize: 5)),
                          Image.network('${urlImgGlobal().urlImg}/users/${data[index].id_user_order}/${data[index].id_user_order}.png',height: 45,width: 45,),
                          ],)
                    ),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(color:const Color(0xFF6366F1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)), child: const Text('Ver detalles', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white)),
                          onPressed:(){
                            String id = data[index].id_order.toString();
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                              return OrderDetailPage(id,data[index].address_order,data[index].phone_order,data[index].date_order,data[index].namepickup_order);
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

      )
    );
  }

}
