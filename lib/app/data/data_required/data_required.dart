import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class variablesGlobales {
  String key = "YJEntU7gJwbnqeukvXxnRgNzA3jg9Q";
}

class ProceessedData {
  ProceessedData(this.data);
  bool data;
}
// ignore: non_constant_identifier_names
Future<String> DataLogin() async {
  // ignore: prefer_typing_uninitialized_variables
  final verif;
  SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    var correo = await prefs.getString('correo');
    // ignore: await_only_futures
    var password = await prefs.getString('password');

     if(correo != null && password != null){

      verif = "true";
      }else{
       verif ="false";
      }
  return verif;
}


