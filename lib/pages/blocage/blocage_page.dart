import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/widgets/blocage/forms_blocage_client_widget.dart';

class BlocagePage extends StatefulWidget {
  final String idAffectation;
  const BlocagePage({Key? key, required this.idAffectation}) : super(key: key);

  @override
  State<BlocagePage> createState() => _BlocagePageState();
}

class _BlocagePageState extends State<BlocagePage> {


@override
  void initState() {
    final blocageProvider = Provider.of<BlocageProvider>(context,listen: false);


    blocageProvider.clearList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Colors.white,
        body: FormsBlocageClientWidget(idAffectation: widget.idAffectation));
  }
}
