import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/widgets/affectations/affectation_item_widget.dart';
import 'package:tracking_user/widgets/blocage/client_info_modal_blocage_widget.dart';
import 'package:tracking_user/widgets/loading/loading_affectation_widget.dart';

class AffectationBlocageListWidget extends StatelessWidget {
  const AffectationBlocageListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final affectationProvider = Provider.of<AffectationProvider>(context);

    return Builder(builder: (context) {
      if (affectationProvider.loading) {
        return const LoadingAffectationWidget();
      }

      else if (affectationProvider.affectationsBlocage.isEmpty) {
       return const Center(child:  Text("Aucune affectation trouvée",
       
        style: TextStyle(
         color: Colors.black38
        ),
       ));
      }
      return Column(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              return ListView.builder(
                itemCount: affectationProvider.affectationsBlocage.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AffectationItemWidget(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0))),
                              context: context,
                              builder: (context) {
                                return ClientInfoModalBlocageWidget(
                                  withPlanification: false,
                                  blocage: affectationProvider
                                      .affectationsBlocage[i],
                                );
                              });
                        },
                        affectation: affectationProvider
                            .affectationsBlocage[i].affectation!,
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
