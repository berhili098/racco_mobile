import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/client_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/affectations/affectation_item_widget.dart';
import 'package:tracking_user/widgets/affectations/client_info_modal_widget.dart';
import 'package:tracking_user/widgets/loading/loading_affectation_widget.dart';


class AffectationsDeclarerListWidget extends StatelessWidget {
  const AffectationsDeclarerListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);

    return Builder(builder: (context) {
      if (clientProvider.isLoading) {
        return const LoadingAffectationWidget();
      }
      return Column(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              return
              
              
               ListView.builder(
                 itemCount: affectationProvider.affectationsDeclarer.length,
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
                                 return ClientInfoModalWidget(
                                             withPlanification: false,
                                   affectation: affectationProvider.affectationsDeclarer[i],
                                 );
                               })
                               ;
                         },
                         affectation: affectationProvider.affectationsDeclarer[i],
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
