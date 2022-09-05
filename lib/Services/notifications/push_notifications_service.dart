
// ignore_for_file: prefer_interpolation_to_compose_strings, await_only_futures, avoid_print, unused_element

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/data/helpers/http.dart';
import '../../app/data/helpers/http_method.dart';
import '../../config/global_variables.dart';
import 'notificationservice.dart';

class PushNotificationService {

  static FirebaseMessaging  messaging = FirebaseMessaging.instance;
  
  static String? token;


  static Future<void> _backgroundHandler(RemoteMessage message) async{
    print('onbackground Handler ${message.messageId}');
  }
  static Future<void> _onMessageHandler(RemoteMessage message) async{
    print('onMessage Handler ${message.messageId}');
  }
  static Future<void> _onMessageOpenedApp(RemoteMessage message) async{
    print('onOpenMessageOpenApp Handler ${message.messageId}');
  }

  static Future initializeApp() async{

    //push Notifications
    await Firebase.initializeApp();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await FirebaseMessaging.instance.getToken();

    var tokenApi = await prefs.getString('token');
    var id = await prefs.getString('id');
    final http = Http(baseUrl: urlGlobal().url);

    final result = await http.request('/users?id=$id&nameId=id_user&token=$tokenApi&table=users&suffix=user',
    method: HttpMethod.put,
    headers: {
      "Authorization": keyGlobal().key,
    },
    body: {
      "token_phone_user": token,
    },
    );
    if(result.statusCode == 200){
      print("se guardo");
    }else{
      print("no se pudo guardar");
    }


    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().stylishNotification(
      2,
      message.data['title'],
      message.data['body']
      );
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("notificación recibida");
      });
  }
}