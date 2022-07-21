// ignore_for_file: file_names, deprecated_member_use, use_build_context_synchronously, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, use_key_in_widget_constructors

//Librerias de flutter
import 'package:flutter/material.dart';

//Servicios
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';

//Widgets
import '../../widgets/theme_card/theme_card.dart';

//Variables Globales
import '../../../config/global_variables.dart';

final Uri _url = Uri.parse('https://www.youtube.com/');

class ProfilePage extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<ProfilePage>{

  bool isSwitchedTheme = false;
  bool isSwitchedNotification = false;

  @override
  Widget build(BuildContext context) {

    var parametros = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var id = parametros['id'].toString();
    var url = "${urlImgGlobal().urlImg}/users/$id/" + parametros['image'];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: BackButton(
                  color: Theme.of(context).canvasColor
                ),
        backgroundColor: Theme.of(context).backgroundColor,
      title:Row(
          children: [
            Text(
              'Perfil del usuario',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .apply(fontWeightDelta: 2),
            ),
          ]
        ),
      ),
      body:ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            height: 260,
            width: double.infinity,
            color: Theme.of(context).backgroundColor,
            alignment: Alignment.center,
            child: Center(
              child: Container(
                decoration:const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(80),
                      topLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80),
                      bottomLeft: Radius.circular(80),
                    ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 2,
                    )
                  ]
                ),
                child: Container(
                      height: 170.0,
                      width: 170.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(85.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            url
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              ),
            ),
          ),
            FadeInDown(
              child:GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.75 / 1,
                children: const <ThemeCard>[
                  ThemeCard(
                    mode: ThemeMode.system,
                    icon: Ionicons.contrast_outline,
                  ),
                  ThemeCard(
                    mode: ThemeMode.light,
                    icon: Ionicons.sunny_outline,
                  ),
                  ThemeCard(
                    mode: ThemeMode.dark,
                    icon: Ionicons.moon_outline,
                  ),
                ]
              ),
            ),
            const SizedBox(height: 15),
            FadeInDown(
            child:Card(
                elevation: 2,
                color:  Theme.of(context).cardColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: SwitchListTile(
                  value: isSwitchedNotification,
                  onChanged: (value) {
                    setState(() {
                      isSwitchedNotification = value;
                    });
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  title: Row(
                    children: <Widget>[
                      Icon(Ionicons.notifications,
                          color: Theme.of(context).primaryColor),
                      const SizedBox(width: 16),
                      Text(
                        'Notificaciones',
                        style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
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
                child: FlatButton (
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                  height: 54.0,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      Icon(Ionicons.list, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 16),
                      Text(
                        'Términos y condiciones',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/TermsConditions');
                },
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
                child: FlatButton (
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                  height: 54.0,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      Icon(Ionicons.shield_checkmark, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 16),
                      Text(
                        'Políticas de privacidad',
                        style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/PrivacyPolicy');
                  },
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
                child: FlatButton (
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                  height: 54.0,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      Icon(Ionicons.help, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 16),
                      Text(
                        'Ayuda',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                  onPressed: () {
                    _launchUrl();
                  },
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
                child: FlatButton (
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                  height: 54.0,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      Icon(Icons.logout, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 16),
                      Text(
                        'Cerrar Sesión',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil('/loginPage', (ruta) => false);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
        ],
      ),
    );
  }

}

void _launchUrl() async {

  if (!await launchUrl(_url)) throw 'No se pudo inciar $_url';

}