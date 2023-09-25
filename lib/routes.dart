import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/pages/auth/login/login_page.dart';
import 'package:tracking_user/pages/blocage/blocage_page.dart';
import 'package:tracking_user/pages/blocage/type_blocage_page.dart';
import 'package:tracking_user/pages/clients/clients_page.dart';
import 'package:tracking_user/pages/deblocage/deblocage_page.dart';
import 'package:tracking_user/pages/declaration/declaration_page.dart';
import 'package:tracking_user/pages/declaration/option_page.dart';
import 'package:tracking_user/pages/historique/historique_page.dart';
import 'package:tracking_user/pages/home/home_page.dart';
import 'package:tracking_user/pages/notifications/notifications_page.dart';
import 'package:tracking_user/pages/permission/permission_page.dart';
import 'package:tracking_user/pages/planification/planification_page.dart';
import 'package:tracking_user/pages/promoteur/promoteur_page.dart';
import 'package:tracking_user/pages/validation/blocage/blocage_validation_page.dart';
import 'package:tracking_user/pages/validation/blocage/type_blocage_validation_page.dart';
import 'package:tracking_user/pages/validation/option_validation_page.dart';
import 'package:tracking_user/pages/validation/validation_page.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/storage/shared_preferences.dart';
import 'package:tracking_user/widgets/declaration/option_list_roteur_widget.dart';
import 'package:tracking_user/widgets/validation/option_cin_widget.dart';
import 'package:tracking_user/widgets/declaration/option_type_passage_widget.dart';
import 'package:tracking_user/widgets/declaration/scan_gpon/scan_bar_code_widget.dart';

const String routeInitial = 'home';

const String routeLogin = '/';
const String routeAffectations = '/affectation';
const String routePromoteur = '/promoteur';
const String routeAffectationsClient = '/affectationClient';
const String routeScanBarCodePage = '/scanBarCodePage';
const String routeOptionBlocage = '/optionBlocage';
const String routeFormBlocage = 'FormBlocage/:idAffectation';
const String routeTypeBlocage = '/TypeBlocage/:idAffectation';
const String routeFormTechniqueBlocage = '/FormTechniqueBlocage';
const String routeOptionPage = '/OptionPage';
const String routeOptionTypePassagePage = '/OptionTypePassagePage';
const String routeOptionListRoteurWidget = '/OptionListRoteurWidget';
const String routeOptionCinPage = '/OptionCinPage';
const String routeDeclarationPage = 'DeclarationPage:affectation';
const String routeValidationPage = 'ValidationPage:idAffectation';
const String routePlanificationPage = '/PlanificationPage';
const String routeHistoriquePage = '/HistoriquePage';
const String routeOptionValidationPage = 'OptionValidationPage:idAffectation';
const String routeBlocageValidationPage = 'BlocageValidationPage:idAffectation';
const String routeTypeBlocageValidationWidget =
    '/TypeBlocageValidationWidget:idAffectation';
const String routeNotificationPage = '/NotificationPage';

const String routeDeblocagePage = 'DeblocagePage:affectation';
const String routePermission = 'Permission';

final List<RouteBase> routeAffectationsList = [
  GoRoute(
      name: routeFormBlocage,
      path: routeFormBlocage,
      builder: (BuildContext context, GoRouterState state) => BlocagePage(
            idAffectation: state.params['idAffectation'] ?? '',
          )),
  GoRoute(
      name: routeOptionValidationPage,
      path: routeOptionValidationPage,
      pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: OptionValidationPage(
            idAffectation: state.params['idAffectation'] ?? '',
          ))),
  GoRoute(
    name: routeValidationPage,
    path: routeValidationPage,
    builder: (BuildContext context, GoRouterState state) {
      return ValidationPage(
        idAffectation: state.params['idAffectation'] ?? '',
      );
    },
    // pageBuilder: (context, state) => Materi^alPage(
    //   key: state.pageKey,
    //   child: const HomePage(),
    // ),
  ),
  GoRoute(
    name: routeBlocageValidationPage,
    path: routeBlocageValidationPage,
    builder: (BuildContext context, GoRouterState state) {
      return BlocageValidationPage(
        idAffectation: state.params['idAffectation'] ?? '',
      );
    },
    // pageBuilder: (context, state) => Materi^alPage(
    //   key: state.pageKey,
    //   child: const HomePage(),
    // ),
  ),
  GoRoute(
    name: routeDeclarationPage,
    path: routeDeclarationPage,
    builder: (BuildContext context, GoRouterState state) {
      final clientJson = state.params['affectation'];
      final affectations = Affectations.fromJson(json.decode(clientJson!));
      return DeclaratioinPage(
        affectation: affectations,
      );
    },
  ),
  GoRoute(
    name: routeDeblocagePage,
    path: routeDeblocagePage,
    builder: (BuildContext context, GoRouterState state) {
      final clientJson = state.params['affectation'];
      final affectations = Affectations.fromJson(json.decode(clientJson!));
      return DeblocagePage(
        affectation: affectations,
      );
    },
  ),
];

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: routeLogin,
      // pageBuilder: (context, state) {
      //   return MaterialPage(
      //     key: state.pageKey,
      //     child: const LoginPage(),
      //   );
      // },
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },

      redirect: (context, state) async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.getLocation(context);

        if (await userProvider.checkUserAuth() == true) {
          return '/home';
        }

        return '/';
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/permission',

      builder: (BuildContext context, GoRouterState state) {
        return const PermissionPage();
      },

      // pageBuilder: (context, state) => MaterialPage(
      //   key: state.pageKey,
      //   child: const HomePage(),
      // ),
    ),
    GoRoute(
      path: routeNotificationPage,

      builder: (BuildContext context, GoRouterState state) {
        return const NotificationPage();
      },

      // pageBuilder: (context, state) => MaterialPage(
      //   key: state.pageKey,
      //   child: const HomePage(),
      // ),
    ),
    GoRoute(
      path: routeHistoriquePage,
      builder: (BuildContext context, GoRouterState state) {
        return const HistoriquePage();
      },
      // pageBuilder: (context, state) => MaterialPage(
      //   key: state.pageKey,
      //   child: const HomePage(),
      // ),
    ),
    GoRoute(
      path: routePlanificationPage,
      builder: (BuildContext context, GoRouterState state) {
        return const PlanificationPage();
      },
      // pageBuilder: (context, state) => MaterialPage(
      //   key: state.pageKey,
      //   child: const HomePage(),
      // ),
    ),
    GoRoute(
      path: routeOptionTypePassagePage,
      builder: (BuildContext context, GoRouterState state) {
        return const OptionTypePassagePage();
      },
      // pageBuilder: (context, state) => MaterialPage(
      //   key: state.pageKey,
      //   child: const HomePage(),
      // ),
    ),
    GoRoute(
      path: routeOptionListRoteurWidget,
      builder: (BuildContext context, GoRouterState state) {
        return const OptionListRoteurWidget();
      },
      // pageBuilder: (context, state) => MaterialPage(
      //   key: state.pageKey,
      //   child: const HomePage(),
      // ),
    ),
    GoRoute(
      path: routeOptionCinPage,
      builder: (BuildContext context, GoRouterState state) {
        return const OptionCinPage();
      },
      // pageBuilder: (context, state) => MaterialPage(
      //   key: state.pageKey,
      //   child: const HomePage(),
      // ),
    ),
    GoRoute(
        name: routeAffectations,
        path: routeAffectations,
        pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const ClientPage(),
            ),
        routes: routeAffectationsList),
    GoRoute(
      name: routePromoteur,
      path: routePromoteur,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const PromoteurPage(),
      ),
    ),
    GoRoute(
      name: routeTypeBlocage,
      path: routeTypeBlocage,
      pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: OptionBlocagePage(
            idAffectation: state.params['idAffectation'] ?? '',
          )),
    ),
    GoRoute(
      name: routeTypeBlocageValidationWidget,
      path: routeTypeBlocageValidationWidget,
      builder: (BuildContext context, GoRouterState state) {
        return OptionBlocageValidationPage(
          idAffectation: state.params['idAffectation'] ?? '',
        );
      },
      // pageBuilder: (context, state) => Materi^alPage(
      //   key: state.pageKey,
      //   child: const HomePage(),
      // ),
    ),
    GoRoute(
      path: routeScanBarCodePage,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ScanBarCodePage(),
      ),
    ),
    GoRoute(
        path: routeFormTechniqueBlocage,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const PlanificationPage())),
    GoRoute(
        path: routeOptionPage,
        pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: OptionPage(
              idAffectation: state.params['idAffectation'] ?? '',
            ))),
    GoRoute(
        path: '/logout',
        pageBuilder: (context, state) {
          dropSessionUser();
          return MaterialPage(key: state.pageKey, child: const LoginPage());
        }),
  ],
);




  // Future<bool> checkSessionMiddleware(
  //     BuildContext context, GoRouterState state) async {
  //    state.name('/login');
  // }

  // static Future<void> logout(BuildContext context) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('sessionToken');
  //   final routerState = GoRouter.of(context);
  //   routerState.replaceAll('/login');
  // }
