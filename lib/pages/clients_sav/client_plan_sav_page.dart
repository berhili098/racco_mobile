import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/sav/sav_plan_widget.dart';

class ClientSavPlanPage extends StatefulWidget {
  const ClientSavPlanPage({Key? key}) : super(key: key);

  @override
  State<ClientSavPlanPage> createState() => _ClientSavPlanPageState();
}

class _ClientSavPlanPageState extends State<ClientSavPlanPage> {
  @override
  void initState() {
    // clientProvider.getClients(context,userProvider.latLngUser);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Clients Sav \nPlanifié",
      ),
      body: const SavTickePlantListWidget(),
    );
  }
}
