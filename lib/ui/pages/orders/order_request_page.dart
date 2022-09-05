// ignore_for_file: file_names, deprecated_member_use, library_private_types_in_public_api, use_key_in_widget_constructors, non_constant_identifier_names

//Librerias de flutter
import 'package:flutter/material.dart';

//Consumidores de api

//Variables Globales
//paginas
import '../../widgets/order_assigment/order_assigment.dart';


class OrderRequestPage extends StatefulWidget {

    @override
    _OrderRequestState createState() => _OrderRequestState();

}

class _OrderRequestState extends State<OrderRequestPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:OrderAssigment()
    );
  }

}
