import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/promoteur/promoteur_list_widget.dart';

class PromoteurPage extends StatefulWidget {
  const PromoteurPage({super.key});

    

  @override
  State<PromoteurPage> createState() => _PromoteurPageState();
}

class _PromoteurPageState extends State<PromoteurPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Demandes \nPPI",  
      ),

      body: const PromoteurListWidget()

    );
  }
}