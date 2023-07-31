import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/planification/affectation_planifier.dart';

class PlanificationPage extends StatefulWidget {
  const PlanificationPage({super.key});

  @override
  State<PlanificationPage> createState() => _PlanificationPageState();
}

class _PlanificationPageState extends State<PlanificationPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBarWidget(title: "Planification \nclient"),
      body :const  AffectationsPlanifierListWidget()
    );
  }
}