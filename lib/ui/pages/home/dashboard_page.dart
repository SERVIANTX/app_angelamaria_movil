// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../widgets/home/chart_history.dart';
import '../../widgets/home/data_confirmed_order.dart';
import '../../widgets/home/data_order_active.dart';
import '../../widgets/home/data_order_assigment.dart';
import '../../widgets/home/data_order_delivered.dart';
import '../../widgets/home/data_order_way.dart';

class DashboardPage extends StatefulWidget {

    @override
    // ignore: library_private_types_in_public_api
    _DashboardPageState createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage>{
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
          children: <Widget>[
          const SizedBox(height: 12),
          dataOrderActive(),
          const SizedBox(height: 15,),
          FadeInLeft(
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [

                  BarChartSample1(),

                ],
              ),
            ),
          ),

          const SizedBox(height: 15),
          DataAssigmentOrder(),
          const SizedBox(height: 5),
          dataConfirmedOrder(),
          const SizedBox(height: 5),
          dataorderWay(),
          const SizedBox(height: 5),
          dataOrderDelivered(),
          const SizedBox(height: 5),
        ]),

    );
  }

}
