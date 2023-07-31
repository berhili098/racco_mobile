import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/declaration/form_declaration_widget.dart';

class DeclaratioinPage extends StatefulWidget {
  final Affectations affectation;

  const DeclaratioinPage({super.key, required this.affectation});

  @override
  State<DeclaratioinPage> createState() => _DeclaratioinPageState();
}

class _DeclaratioinPageState extends State<DeclaratioinPage> {
  @override
  void initState() {
    final declarationProvider =
        Provider.of<DeclarationProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      declarationProvider.getRouteurs();


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final declarationProvider = Provider.of<DeclarationProvider>(context);

    return LoadingOverlay(
      isLoading: declarationProvider.loading,
      child: Scaffold(
          appBar: AppBarWidget(
            title: "Déclaration \nclient",
          ),
          body: FormDeclationWidget(affectation: widget.affectation)),
    );
  }
}
