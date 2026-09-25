import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'config/app_config.dart';
import 'controller/base_client.dart';
import 'view/welcome/welcome_screen.dart';
import 'view/home/home_screen.dart';
import 'controller/home_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  // Load cached / remote API base URL before any network calls
  await AppConfig.instance.init();
  BaseClient.applyBaseUrl(AppConfig.instance.apiBaseUrl);

  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    String lang = storage.read('lang') ?? 'en';
    final token = storage.read('token');

    return GetMaterialApp(
      title: 'Al Nawras',
      debugShowCheckedModeBanner: false,
      locale: Locale(lang),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE30613),
          primary: const Color(0xFFE30613),
        ),
        primaryColor: const Color(0xFFE30613),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE30613),
          elevation: 0,
        ),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: (token != null && token.toString().isNotEmpty)
          ? const HomeScreen()
          : const WelcomeScreen(),
    );
  }
}
