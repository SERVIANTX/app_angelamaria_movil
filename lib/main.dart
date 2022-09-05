// ignore_for_file: use_key_in_widget_constructors

// Librerias de flutter
import 'dart:io';
import 'package:flutter/material.dart';

// Librerias para los temas.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'Services/notifications/push_notifications_service.dart';
import 'config/theme.dart';
import 'states/theme_mode_state.dart';

// Servicios
import 'Services/notifications/notificationservice.dart';


// Librerias para las paginas
import 'ui/pages/login/login_page.dart';
import 'ui/pages/notification/notification_page.dart';
import 'ui/pages/terms&conditions/privacy&policy_page.dart';
import 'ui/pages/perfil/profile_page.dart';
import 'ui/pages/terms&conditions/terms&conditions_page.dart';
import 'ui/routes/routes.dart';

void main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  final Directory tmpDir = await getTemporaryDirectory();
  await Hive.initFlutter(tmpDir.toString());
  await Hive.openBox('prefs');
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(
    ProviderScope(
      child: AngelaMaria(),
    ),
  );
}

class AngelaMaria extends ConsumerWidget {

    @override
    Widget build(BuildContext context, WidgetRef ref) {
    final ThemeModeState currentTheme = ref.watch(themeProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentTheme.themeMode,
      routes: {
          '/loginPage' : (context) => LoginPage(),
          '/routes'  :(context) =>  Routes(),
          '/TermsConditions'  :(context) =>  TermsConditionsPage(),
          '/PrivacyPolicy'  :(context) =>  PrivacyPolicyPage(),
          '/Notification'  :(context) =>  NotificationPage(),
          '/Profile'  :(context) =>  ProfilePage(),
        },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }

}
