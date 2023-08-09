import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/declaration/option_list_widget.dart';

class OptionPage extends StatefulWidget {
    final String idAffectation;

  const OptionPage({super.key, required this.idAffectation});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: OptionListWidget());
  }
}