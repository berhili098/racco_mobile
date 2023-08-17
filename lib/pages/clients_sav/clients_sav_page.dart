import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';

import '../../widgets/sav/sav_widget.dart';

class ClientSavPage extends StatefulWidget {
  const ClientSavPage({Key? key}) : super(key: key);

  @override
  State<ClientSavPage> createState() => _ClientSavPageState();
}

class _ClientSavPageState extends State<ClientSavPage> {
  @override
  void initState() {
    // clientProvider.getClients(context,userProvider.latLngUser);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Clients Sav \nAffecter",
      ),
      body: const SavTicketListWidget(),
    );
  }
}
