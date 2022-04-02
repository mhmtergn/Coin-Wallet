import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_firebase/screens/splash_screen.dart';
import 'screens/entrance_page.dart';
import 'screens/home_page.dart';
import 'screens/signup_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/signUpLoginPage': (context) => const SignUpLoginPage(),
        '/homePage': (context) => const HomePage(),
        '/entrancePage': ((context) => const EntrancePage()),
      },
      //   routes: <String, WidgetBuilder>{
      //   '/HomeScreen': (BuildContext context) => const HomeScreen(),
      //   '/NavigateScreen': (BuildContext context) => const NavigateScreen()
      // },
    );
  }
}
