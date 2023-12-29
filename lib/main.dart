import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'admin/controllers/menu_controller.dart' as MyMenuController;
import 'landing/navebar/homepage.dart';
import 'landing/splash.dart';
import 'login/Login/login_screen.dart';
import 'login/Signup/components/signup_form.dart';
import 'package:firebase_core/firebase_core.dart';

import 'usrTime/screens/detailstore/store2/componants/categury.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
   MultiProvider(
      providers: [
        ChangeNotifierProvider<MyMenuController.MenuController>(create: (_) => MyMenuController.MenuController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget homePage;

    if (kIsWeb) {
      homePage =  WebHomePage();
    } else {
      homePage = const MobileHomePage();
    }

    return MaterialApp(
      title: 'My App',
      home: homePage,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'singup': (context) => const SignUpScreen(),
        'singin': (context) => const LoginScreen(),
      },
    );
  }
}

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' WheelsWell',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Barlow',
          textTheme: TextTheme(
              displayLarge: const TextStyle(
                fontSize: 70,
                color: Colors.black,
                fontFamily: 'DMSerifDisplay',
              ),
              displayMedium: const TextStyle(
                  fontSize: 55,
                  color: Colors.black,
                  fontFamily: 'DMSerifDisplay'),
              displaySmall: const TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontFamily: 'DMSerifDisplay'),
              titleMedium: TextStyle(fontSize: 30, color: Colors.grey[500]),
              titleSmall: TextStyle(fontSize: 20, color: Colors.grey[500]),
              bodyLarge: const TextStyle(
                  fontSize: 20, color: Colors.black, height: 1.25),
              bodyMedium: const TextStyle(
                  fontSize: 17, color: Colors.black, height: 1.25),
              bodySmall: const TextStyle(
                  fontSize: 15, color: Colors.black, height: 1.25),
              labelLarge:
                  const TextStyle(fontSize: 17, color: Color(0xff1e1e24)))),
      home: const HomePage(),
    );
  }
}
