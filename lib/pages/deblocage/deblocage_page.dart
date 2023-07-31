import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/services/providers/deblocage_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/deblocage/form_deblocage_widget.dart';
import 'package:tracking_user/widgets/declaration/form_declaration_widget.dart';

class DeblocagePage extends StatefulWidget {
  final Affectations affectation;

  const DeblocagePage({super.key, required this.affectation});

  @override
  State<DeblocagePage> createState() => _DeblocagePageState();
}

class _DeblocagePageState extends State<DeblocagePage> {
  @override
  void initState() {


    // WidgetsBinding.instance.addPostFrameCallback((_) {
  
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        final deblocageProvider = Provider.of<DeblocageProvider>(context);

    return LoadingOverlay(
      isLoading: deblocageProvider.loading, child :Scaffold(
          appBar: AppBarWidget(
            title: "Débloquer \nclient",
          ),
          body:   FormeDeblocageWidget(affectation: widget.affectation,)),
    );
  }
}
