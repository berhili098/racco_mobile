import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/historiques/historique_widget.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  @override
  void initState() {
    getDataAsync();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HistoriqueWidget();
  }

  Future getDataAsync() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final affectationProvider =
          Provider.of<AffectationProvider>(context, listen: false);

      affectationProvider.getIndexTab(0);
      affectationProvider.getAffectationTechnicien(
          context, userProvider.userData!.technicienId.toString());

      affectationProvider.getAffectationPlanifier(
          context, userProvider.userData!.technicienId.toString());

      affectationProvider.getAffectationValider(
          context, userProvider.userData!.technicienId.toString());

      // affectationProvider.getAffectationDeclarer(
      //     context, userProvider.userData!.technicienId.toString());

      affectationProvider.getAffectationBlocage(
          context, userProvider.userData!.technicienId.toString());
      affectationProvider.getAffectationBeforValidationBlocage(
          context, userProvider.userData!.technicienId.toString());
    });
  }
}
