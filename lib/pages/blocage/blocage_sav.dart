import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/blocage/type_blocage_widget.dart';

class OptionBlocageSavPage extends StatelessWidget {
  final String idAffectation;
  bool? isSav = false;

  OptionBlocageSavPage(
      {super.key, this.isSav = false, required this.idAffectation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: isSav == true && isSav != null
              ? "Type Sav \nblocage"
              : "Type  \nblocage",
        ),
        backgroundColor: Colors.white,
        body: TypeBlocageWidget(isSav: isSav, idAffectation: idAffectation));
  }
}
