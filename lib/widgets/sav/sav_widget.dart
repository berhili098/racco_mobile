import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/widgets/loading/loading_affectation_widget.dart';
import 'package:tracking_user/widgets/sav/client_sav_info_modal_widget.dart';
import 'package:tracking_user/widgets/sav/sav_ticket_item.dart';

class SavTicketListWidget extends StatefulWidget {
  const SavTicketListWidget({Key? key}) : super(key: key);

  @override
  State<SavTicketListWidget> createState() => _SavTicketListWidgetState();
}

class _SavTicketListWidgetState extends State<SavTicketListWidget> {
  @override
  Widget build(BuildContext context) {
    final affectationProvider = Provider.of<AffectationProvider>(context);

    return Builder(builder: (context) {
      if (affectationProvider.loading) {
        return const LoadingAffectationWidget();
      }

      return Column(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              return ListView.builder(
                itemCount: affectationProvider.savTicket.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SavTicketItem(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0))),
                              context: context,
                              builder: (context) {
                                return ClientSavInfoModalWidget(
                                  withPlanification: false,
                                  affectation: affectationProvider.savTicket[i],
                                );
                              }).whenComplete(() {});
                        },
                        affectation: affectationProvider.savTicket[i],
                        showInfoIcon: true),
                  );
                },
              );
            }),
          ),
        ],
      );
    });
  }
}
