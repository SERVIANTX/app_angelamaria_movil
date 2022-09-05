// ignore_for_file: file_names, deprecated_member_use, library_private_types_in_public_api, use_key_in_widget_constructors, non_constant_identifier_names
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/request/confirmed_order.dart';
import '../../widgets/request/order_delivered.dart';
import '../../widgets/request/order_way.dart';




class OrderAcceptedPage extends StatefulWidget {

    @override
    _OrderAcceptedState createState() => _OrderAcceptedState();

}

class _OrderAcceptedState extends State<OrderAcceptedPage>{

  var count = 0;
  var screen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
          children: [
          Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  'Pedidos Aceptados:',
                  style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .apply(fontWeightDelta: 2),
                ),
              ],
            ),
          AnimatedButtonBar(
            radius: 32.0,
            padding: const EdgeInsets.all(16.0),
            backgroundColor: Theme.of(context).cardColor,
            foregroundColor:  Theme.of(context).primaryColor,
            elevation: 8,
            borderColor:  Theme.of(context).primaryColor,
            borderWidth: 2,
            innerVerticalPadding: 16,
            children: [
              ButtonBarEntry(
                  onTap: () => {setState(() => screen= 0),},
                  child: Icon(Icons.done_all_rounded, color: Theme.of(context).canvasColor,)),
              ButtonBarEntry(
                  // ignore: avoid_print
                  onTap: () =>{setState(() => screen= 1),},
                  child: Icon(Icons.airport_shuttle, color: Theme.of(context).canvasColor,)),
              ButtonBarEntry(
              // ignore: avoid_print
              onTap: () =>{setState(() => screen= 2),},
              child: Icon(Icons.shopping_bag_rounded, color: Theme.of(context).canvasColor,)),
            ],
          ),
          Expanded(
            child: screen == 0? ConfirmedOrder()
            :screen == 1?  orderWay()
            :orderDelivered()
            ),
        ],
      )
    );
  }

}
