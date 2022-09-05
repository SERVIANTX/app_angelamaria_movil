// ignore_for_file: file_names
import 'package:flutter/material.dart';

import '../../widgets/notification/order_notification.dart';

// ignore: use_key_in_widget_constructors
class NotificationPage extends StatefulWidget {

    @override
    // ignore: library_private_types_in_public_api
    _NotificationState createState() => _NotificationState();

}

class _NotificationState extends State<NotificationPage>{
  var count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
                    color: Theme.of(context).canvasColor
                  ),
          backgroundColor: Theme.of(context).backgroundColor,
          title:Row(
            children: [
              Text(
                'Notificaciones',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
              ),
            ]
          ),
        ),
      backgroundColor: Theme.of(context).backgroundColor,
      body:OrderNotification(),
    );
  }

}