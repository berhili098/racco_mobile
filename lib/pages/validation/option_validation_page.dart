import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';
import 'package:tracking_user/widgets/validation/option_validation/button_navigation_widget.dart';

class OptionValidationPage extends StatelessWidget {
  final String idAffectation;

  const OptionValidationPage({super.key, required this.idAffectation});

  @override
  Widget build(BuildContext context) {


        final blocageProvider = Provider.of<BlocageProvider>(context);

    return FlutterCloseAppPage(
      interval: 10,
      condition: false,
      onCloseFailed: () {
        SncakBarWidgdet.snackBarSucces(
            context, "Merci de continuer la procédure.");
      },
      child: Scaffold(
        appBar: AppBarWidget(title: "Validation \nclient", show: false),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonNavigationWidget(
                title: 'Declarer en blocage',
                onTap: () {
                  
                  blocageProvider.getIdAffectation(idAffectation) ; 
                  
                  context.pushNamed(routeTypeBlocageValidationWidget,
                    params: {'idAffectation': idAffectation});}
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonNavigationWidget(
                title: "Valider l'affectation",
                onTap: () => context.pushNamed(routeValidationPage,
                    params: {'idAffectation': idAffectation}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
