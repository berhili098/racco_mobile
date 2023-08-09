import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/client_provider.dart';
import 'package:tracking_user/widgets/loading/loading_affectation_widget.dart';

class AffectationListPage extends StatefulWidget {
  const AffectationListPage({Key? key}) : super(key: key);

  @override
  State<AffectationListPage> createState() => _AffectationListPageState();
}

class _AffectationListPageState extends State<AffectationListPage> {
  @override
  Widget build(BuildContext context) {
    // final affectationProvider = Provider.of<AffectationProvider>(context);
    final clientProvider = Provider.of<ClientProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (context) {
        if (clientProvider.isLoading) {
          return const LoadingAffectationWidget();
        }
        return Column(
          children: [
            Card(
              color: const Color.fromARGB(255, 90, 218, 117),
              // In many cases, the key isn't mandatory
              // key: ValueKey(myProducts[index]),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: const [
                      Text('Postion actuelle'),
                      Text('lat : 33.593'),
                      Text('long : -7.6179')
                    ],
                  )),
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: clientProvider.clientsAffecter.length,
                  itemBuilder: (context, i) {
                    return Card(
                      color: i < clientProvider.couteur
                          ? const Color.fromARGB(255, 226, 94, 71)
                          : const Color.fromARGB(255, 116, 143, 233),
                      // In many cases, the key isn't mandatory
                      // key: ValueKey(myProducts[index]),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Uid : ${clientProvider.clients[i].uuid}'),
                              // Text(userProvider.affectations[i].!),
                              Text(
                                  'Nom Client : ${clientProvider.clients[i].name!}'),

                              Text(
                                  'Numéro de client : ${clientProvider.clients[i].phoneNo!}'),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: const Text('Blocage')),
                                    const Text('Déclaration'),
                                    const Text('Planifiée'),
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
