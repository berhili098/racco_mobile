import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/validation_provider.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/validation/form_validation_widget.dart';

class ValidationPage extends StatefulWidget {
    final String idAffectation;

  const ValidationPage({super.key, required this.idAffectation});

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  @override
  Widget build(BuildContext context) {
        final validationProvider = Provider.of<ValidationProvider>(context);


    return LoadingOverlay(

            isLoading: validationProvider.loading,
      child: Scaffold(
         appBar: AppBarWidget(title: "Validation \nclient",),
        body: FormValidationWidget(idAffectation: widget.idAffectation,)),
    );
  }
}