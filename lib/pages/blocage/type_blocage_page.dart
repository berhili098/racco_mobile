import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/blocage/type_blocage_widget.dart';

class OptionBlocagePage extends StatelessWidget {
    final String idAffectation;

  const OptionBlocagePage({super.key, required this.idAffectation});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
          appBar: AppBarWidget(
        title: "Type \nblocage",
      ),
      backgroundColor: Colors.white,

      body:  TypeBlocageWidget(idAffectation: idAffectation));
  }
}