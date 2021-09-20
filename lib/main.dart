import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/suggestions_bloc.dart';
import 'package:gerenciador_aquifero/blocs/user_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/controllers/MenuController.dart';
import 'package:gerenciador_aquifero/models/especie/especie_manager.dart';
import 'package:gerenciador_aquifero/screens/login/login_screen.dart';
import 'package:gerenciador_aquifero/stores/page_store.dart';
import 'package:gerenciador_aquifero/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocation();
  runApp(MyApp());
}

final location = GetIt.instance;

void setupLocation() {
  location.registerSingleton(UserManagerStore());
  location.registerSingleton(PageStore());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => UserBloc(), singleton: true),
        Bloc((i) => SuggestionsBloc(), singleton: true)
      ],
      dependencies: [],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
          ChangeNotifierProxyProvider0<EspecieManager>(
            lazy: true,
            create: (_) => EspecieManager(),
            update: (_, especieManager) => especieManager..update(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BioCheck Tapajós',
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: bgColor,
              textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                  .apply(bodyColor: Colors.white),
              canvasColor: secondaryColor,
            ),
            home: LoginScreen()),
      ),
    );
  }
}
