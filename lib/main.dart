import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/screens/login/login_screen.dart';
import 'package:gerenciador_aquifero/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocation();
  runApp(MyApp());
}

final location = GetIt.instance;

void setupLocation() {
  location.registerSingleton(UserManagerStore());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instituto Alter do Chão',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: LoginScreen());
  }
}
