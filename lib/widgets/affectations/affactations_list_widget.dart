import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/client_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/affectations/affectation_item_widget.dart';
import 'package:tracking_user/widgets/affectations/client_info_modal_widget.dart';
import 'package:tracking_user/widgets/loading/loading_affectation_widget.dart';


class AffectationsListWidget extends StatefulWidget {
  const AffectationsListWidget({Key? key}) : super(key: key);

  @override
  State<AffectationsListWidget> createState() => _AffectationsListWidgetState();
}

class _AffectationsListWidgetState extends State<AffectationsListWidget> {
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);

    return Builder(builder: (context) {
      if (affectationProvider.loading) {
        return const LoadingAffectationWidget();
      }
      
      return Column(
          children: [
            Expanded(
              child: Builder(builder: (context) {
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const WaterDropHeader(),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text("pull up load");
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("release to load more");
                      } else {
                        body = const Text("No more Data");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: affectationProvider.refreshController,
                  onRefresh: () => affectationProvider.onRefresh(context,userProvider.userData!.technicienId.toString()),
                  onLoading: () => clientProvider.onLoading(context,userProvider.userData!.technicienId.toString()),
                  child: ListView.builder(
                    itemCount: affectationProvider.affectations.length,
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

                                      withPlanification: true,
                                      affectation: affectationProvider.affectations[i],
                                    );
                                  }).whenComplete((){});
                            },
                            affectation: affectationProvider.affectations[i],
                            showInfoIcon: true),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        );
    });
  }
}
