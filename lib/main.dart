import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_aquifero/blocs/suggestions_bloc.dart';
import 'package:gerenciador_aquifero/blocs/user_bloc.dart';
import 'package:gerenciador_aquifero/common/constants.dart';
import 'package:gerenciador_aquifero/controllers/MenuController.dart';
import 'package:gerenciador_aquifero/models/about_me/collaborators/collaborators_manager.dart';
import 'package:gerenciador_aquifero/models/about_me/team/team_manager.dart';
import 'package:gerenciador_aquifero/models/especie/especie_manager.dart';
import 'package:gerenciador_aquifero/models/info_presently/infos_manager.dart';
import 'package:gerenciador_aquifero/models/info_presently/presently_manager.dart';
import 'package:gerenciador_aquifero/models/ucs_trails/trails_manager.dart';
import 'package:gerenciador_aquifero/models/ucs_trails/ucs_manager.dart';
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
          ChangeNotifierProxyProvider0<TeamManager>(
            lazy: false,
            create: (_) => TeamManager(),
            update: (_, teamManager) => teamManager..update(),
          ),
          ChangeNotifierProxyProvider0<CollaboratorsManager>(
            lazy: false,
            create: (_) => CollaboratorsManager(),
            update: (_, collaboratorsManager) => collaboratorsManager..update(),
          ),
          ChangeNotifierProxyProvider0<UcsManager>(
            lazy: false,
            create: (_) => UcsManager(),
            update: (_, ucsManager) => ucsManager..update(),
          ),
          ChangeNotifierProxyProvider0<TrailsManager>(
            lazy: false,
            create: (_) => TrailsManager(),
            update: (_, trailsManager) => trailsManager..update(),
          ),
          ChangeNotifierProxyProvider0<InfosManager>(
            lazy: false,
            create: (_) => InfosManager(),
            update: (_, infosManager) => infosManager..update(),
          ),
          ChangeNotifierProxyProvider0<PresentlyManager>(
            lazy: false,
            create: (_) => PresentlyManager(),
            update: (_, presentlyManager) => presentlyManager..update(),
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
