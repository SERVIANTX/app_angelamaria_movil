// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/home/chart_history.dart';

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
                    children: <Widget>[
                      const Icon(Icons.local_activity_sharp,
                          color: Color(0xFF6366F1),size: 30,),
                      const SizedBox(width: 16),
                      Text(
                        'Pedidos activos:',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '6',
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
          const SizedBox(height: 15,),
          FadeInDown(
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [

                  BarChartSample2(),

                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          FadeInDown(
            child:Card(
              elevation: 2,
              color:  Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: <Widget>[
                  ListTile(
                  title: Column(
                    children: <Widget>[
                      const Icon(Icons.done_all_rounded,
                          color: Color(0xFF6366F1),size: 30,),
                      const SizedBox(height: 10),
                      Text(
                        'Pedidos Preparandose: 2',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  ),
                ]
              ),
            ),
          ),
          FadeInDown(
            child:Card(
              elevation: 2,
              color:  Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: <Widget>[
                  ListTile(
                  title: Column(
                    children: <Widget>[
                      const Icon(Icons.airport_shuttle,
                          color: Color(0xFF6366F1),size: 30,),
                      const SizedBox(height: 10),
                      Text(
                        'Pedidos en Camino: 1',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  ),
                ]
              ),
            ),
          ),
          FadeInDown(
            child:Card(
              elevation: 2,
              color:  Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: <Widget>[
                  ListTile(
                  title: Column(
                    children: <Widget>[
                      const Icon(Icons.shopping_bag_rounded,
                          color: Color(0xFF6366F1),size: 30,),
                      const SizedBox(height: 10),
                      Text(
                        'Pedidos Entregados: 3',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  ),
                ]
              ),
            ),
          ),
        ]),

    );
  }

}
