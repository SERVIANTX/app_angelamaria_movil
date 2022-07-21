
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_interpolation_to_compose_strings

//Librerias
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

//paginas
import '../pages/home/dashboard_page.dart';
import '../pages/ordersAccepted/order_accepted.dart';
import '../pages/orders/order_request_page.dart';

//Variables Globales
import '../../config/global_variables.dart';

class Routes extends StatefulWidget {

  @override
  _RoutesState createState() => _RoutesState();

}

class _RoutesState extends State<Routes> {

  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    var parametros = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var id = parametros['id'].toString();
    var url = "${urlImgGlobal().urlImg}/users/$id/" + parametros['image'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/Profile',arguments: {'nombre':parametros['displayname_user'], 'usuario':parametros['email_user'], 'id': id,'image':parametros['image']});
            },
          child:
        Row(
          children:[
            Container(
              height: 45.0,
              width: 45.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      url
                    ),
                    fit: BoxFit.cover,
                  ),
                  ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  child:
                  Text(
                    '  ${parametros['nombre']},',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .apply(fontWeightDelta: 2),
                  ),
                ),
                const SizedBox(height: 3),
                FadeInDown(
                  child:
                  Text(
                    '  Bienvenido!',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .apply(fontWeightDelta: 2),
                  ),
                ),
              ],
            )
          ]
        ),
        ),
        actions: <Widget>[
          FadeInDown(
            child:IconButton(
              icon: Icon(Icons.notifications_active_sharp, color: Theme.of(context).primaryColor,size:30,),
              onPressed: () {
                Navigator.of(context).pushNamed('/Notification');
              },
            ),
          ),
        ],
        elevation: 0,
        centerTitle: false,
      ),
      body: PageView(
        controller: _pageController,
        children: [
            DashboardPage(),
            OrderRequestPage(),
            OrderAcceptedPage(),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        backgroundColor:  Theme.of(context).cardColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            inactiveColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.home),
            title: const Text('Inicio'),
            activeColor: Theme.of(context).primaryColor,
            activeTitleColor: Theme.of(context).primaryColor,
          ),
          BottomBarItem(
            inactiveColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.list_alt_rounded),
            title: const Text('Pedidos'),
            activeColor: Theme.of(context).primaryColor,
          ),
          BottomBarItem(
            inactiveColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.shopping_bag_rounded),
            title: const Text('Aceptados'),
            backgroundColorOpacity: 0.1,
            activeColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

}
