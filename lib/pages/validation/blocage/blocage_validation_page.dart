import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/widgets/validation/blocage_validation/form_blocage_validation_widget.dart';

class BlocageValidationPage extends StatelessWidget {
  final String idAffectation;
  const BlocageValidationPage({Key? key, required this.idAffectation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocageProvider = Provider.of<BlocageProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: FormsBlocageValidationWidget(idAffectation: idAffectation));
  }
}
