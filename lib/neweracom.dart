import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/pallete_color.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/services/providers/client_provider.dart';
import 'package:tracking_user/services/providers/deblocage_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/services/providers/validation_provider.dart';

class NewEraCom extends StatefulWidget {
  const NewEraCom({super.key});

  @override
  State<NewEraCom> createState() => _NewEraComState();
}

class _NewEraComState extends State<NewEraCom> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // log(' state app tarcking app  : ${state.name}');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<DeblocageProvider>(
            create: (_) => DeblocageProvider()),
        ChangeNotifierProvider<AffectationProvider>(
            create: (_) => AffectationProvider()),
        ChangeNotifierProvider<ClientProvider>(create: (_) => ClientProvider()),
        ChangeNotifierProvider<BlocageProvider>(
            create: (_) => BlocageProvider()),
        ChangeNotifierProvider<DeclarationProvider>(
            create: (_) => DeclarationProvider()),
        ChangeNotifierProvider<ValidationProvider>(
            create: (_) => ValidationProvider()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(428, 929),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
                theme: ThemeData(
                    primarySwatch: Palette.kToDark,
                    scaffoldBackgroundColor: Palette.bgColor,
                    textTheme: Theme.of(context).textTheme.apply(
                          // fontFamily: 'Lexend',
                        ),
                    buttonTheme: const ButtonThemeData(
                      buttonColor: Palette.kToDark,
                      textTheme: ButtonTextTheme.primary,
                    )),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [Locale('fr', 'FR')],
                debugShowCheckedModeBanner: false,
                // routeInformationParser: router.routeInformationParser,
                // routerDelegate: router.routerDelegate,
                routerConfig: router);
          }),
    );
  }
}