// ignore: file_names
// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, deprecated_member_use, non_constant_identifier_names, await_only_futures, library_private_types_in_public_api, use_key_in_widget_constructors

//Librerias de flutter
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

//Consumidores de api
import '../../../app/data/helpers/http.dart';
import '../../../app/data/helpers/http_method.dart';

//Widgets
import '../../widgets/login/footer.dart';
import '../../widgets/login/header.dart';
import '../../widgets/login/logo.dart';
import '../../widgets/login/titulo_login.dart';

//Servicios
import '../../../Services/notifications/notificationservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emojis/emojis.dart';
import 'package:animate_do/animate_do.dart';
import 'package:timezone/data/latest.dart' as tz;

//Variables Globales
import '../../../config/global_variables.dart';


class LoginPage extends StatefulWidget {

    @override
    _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

    bool isChecked = false;
    final email = TextEditingController();
    final password = TextEditingController();
    bool _obscureText = true;

    String em = '';
    String pass = '';
    final i = 1;

    String correoR = '';
    String passwordR = '';

  @override
  Widget build(BuildContext context) {
      Color getColor(Set<MaterialState> states) {
        return Theme.of(context).primaryColor;
      }
      return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: (){
          final FocusScopeNode focus = FocusScope.of(context);
            if(!focus.hasPrimaryFocus && focus.hasFocus){
              FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          physics: const BouncingScrollPhysics(),
          children: [
            Stack (
              children: [
                HeaderLogin(),
                LogoHeader(),
              ],
            ),
            FadeInDown(
              child: Titulo(),
            ),
            const SizedBox(height: 20),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        FadeInDown(
                          child:Container(
                            decoration: BoxDecoration(
                                boxShadow:  [
                                  BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                    blurRadius: 4,
                                      offset: const Offset(1, 1)
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))
                                    ),
                              child: TextField(
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                  labelStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .apply(fontWeightDelta: 2),
                                  hintText: 'Correo',
                                  hintStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .apply(fontWeightDelta: 2),
                                  filled: true,
                                  fillColor:  Theme.of(context).cardColor,
                                  prefixIcon: Icon(Icons.mail_outline, color: Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromARGB(255, 158, 165, 173)),
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).cardColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        FadeInDown(
                          child:Container(
                            decoration: BoxDecoration(
                                boxShadow:  [
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor,
                                    blurRadius: 4,
                                    offset: const Offset(1, 1)
                                  ),
                                ],
                                borderRadius:const BorderRadius.all(
                                    Radius.circular(15)
                                    )
                              ),
                            child: TextField(
                              controller: password,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                              suffixIcon: GestureDetector(onTap: (){
                                  setState(() {
                                    _obscureText=!_obscureText;
                                  });
                              },
                                child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,color: Theme.of(context).primaryColor,
                                ),
                              ),
                              labelStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .apply(fontWeightDelta: 2),
                              hintStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .apply(fontWeightDelta: 2),
                              hintText: 'Contraseña',
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromARGB(255, 158, 165, 173)),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).cardColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        FadeInDown(
                          child:GestureDetector(
                            onTap: () {
                              isChecked = !isChecked;
                              setState(() {
                            });},
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    value: isChecked,
                                    onChanged: (value){
                                      isChecked = !isChecked;
                                      setState(() {
                                      });
                                    },
                                  ),
                                  Expanded(child:
                                    Text(
                                      'Recuérdame',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .apply(fontWeightDelta: 2),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            FadeInDown(
              child:Container(
              margin: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 4,
                      offset: const Offset(1, 1)),
                ],
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: FlatButton (
                  height: 50,
                  splashColor: Theme.of(context).primaryColor,
                  shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
                  child:
                    Text(
                      'INICIAR SESIÓN',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                    ),
                  onPressed: () async {
                    em = email.text;
                    pass = password.text;
                    if(em == '' && pass == ''){
                      showTopSnackBar(
                          context,
                          const CustomSnackBar.error(
                            textStyle: TextStyle(fontFamily: 'Antipasto',fontSize: 20,),
                            message:
                                "Correo y Contraseña se encuentra vacio!",
                          ),
                        );
                    }
                    else if(em == ''){
                      showTopSnackBar(
                          context,
                          const CustomSnackBar.error(
                            textStyle: TextStyle(fontFamily: 'Antipasto',fontSize: 20,),
                            message:
                                "Correo se encuentra vacio!",
                          ),
                        );
                    }else if(pass == ''){
                      showTopSnackBar(
                          context,
                          const CustomSnackBar.error(
                            textStyle: TextStyle(fontFamily: 'Antipasto',fontSize: 20,),
                            message:
                                "Contraseña se encuentra vacio!",
                          ),
                        );
                    }
                    else {
                      final http = Http(baseUrl: urlGlobal().url);
                      final result = await http.request('/users?login=true&suffix=user',
                      method: HttpMethod.post,
                      headers: {
                        "Authorization": keyGlobal().key,
                      },
                      body: {
                        "email_user": em,
                        "password_user": pass,
                      },
                      );
                      if(result.statusCode == 200){
                        var datos = result.data['results'];
                        var datos2 = datos[0];
                        var token = datos2['token_user'];
                        String id = datos2['id_user'].toString();
                        if(isChecked == true){
                          GuardarDatos(em, pass, token, id);
                        }
                        NotificationService().stylishNotification(
                          1,
                          Emojis.smilingFace + datos2['displayname_user'],
                          'Bienvenido!'
                          );
                        Navigator.of(context).pushReplacementNamed('/routes', arguments: {'nombre':datos2['displayname_user'], 'usuario':datos2['email_user'], 'id': id,'image':datos2['picture_user']}
                      );
                      }else{
                        showTopSnackBar(
                          context,
                          const CustomSnackBar.error(
                            textStyle: TextStyle(fontFamily: 'Antipasto',fontSize: 20,),
                            message:
                                "Correo o Contraseña Erroneos!",
                          ),
                        );
                      }
                      email.text = '';
                      password.text = '';
                    }
                  },
                ),
              ),
            ),
            FadeInDown(
              child:const FootterLogin(),
            ),
          ],
        ),
      )
    );
  }
  Future<void> GuardarDatos(em, pass, token,id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('correo', em);
    await prefs.setString('password', pass);
    await prefs.setString('token', token);
    await prefs.setString('id', id);
  }

  Future<void>CargarDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var correo = await prefs.getString('correo');
    var password = await prefs.getString('password');
    if(correo != null ){
      if(password != null){
        final http = Http(baseUrl: urlGlobal().url);
        final result = await http.request('/users?login=true&suffix=user',
          method: HttpMethod.post,
          headers: {
            "Authorization": keyGlobal().key,
          },
          body: {
            "email_user": correo,
            "password_user": password,
          },
        );
      if(result.statusCode == 200){
        var datos = result.data['results'];
        var datos2 = datos[0];
        var token = datos2['token_user'];
        String id = datos2['id_user'].toString();
        await prefs.setString('token', token);
        await prefs.setString('id', id);
        Navigator.of(context).pushReplacementNamed('/routes', arguments: {'nombre':datos2['displayname_user'], 'usuario':datos2['email_user'], 'id':datos2['id_user'],'image':datos2['picture_user']}
      );
      }
      }
    }
  }

  @override
  void initState(){
    super.initState();
    CargarDatos();
    tz.initializeTimeZones();
  }

}