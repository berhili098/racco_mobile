import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/blocage/type_blocage_widget.dart';
import 'package:tracking_user/widgets/validation/blocage_validation/type_blocage_validation_widget.dart';

class OptionBlocageValidationPage extends StatelessWidget {
    final String idAffectation;

  const OptionBlocageValidationPage({super.key, required this.idAffectation});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
          appBar: AppBarWidget(
        title: "Type \nblocage",
      ),
      backgroundColor: Colors.white,

      body:  TypeBlocageValidationWidget(idAffectation: idAffectation));
  }
}