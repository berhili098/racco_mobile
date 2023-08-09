import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/affectations/affactations_list_widget.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';

class ClientPage extends StatefulWidget {
const   ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  void initState() {


    // clientProvider.getClients(context,userProvider.latLngUser);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Clients \nAffecter",
      ),
      body: const AffectationsListWidget(),
    );
  }
}
