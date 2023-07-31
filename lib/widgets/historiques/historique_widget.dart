import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';

import 'package:tracking_user/widgets/blocage/affectation_blocage_list_widget.dart';
import 'package:tracking_user/widgets/declaration/affectation_declarer_widget.dart';
import 'package:tracking_user/widgets/login/field_login_widget.dart';
import 'package:tracking_user/widgets/planification/affectation_planifier.dart';
import 'package:tracking_user/widgets/validation/affectation_valider_widget.dart';
import 'package:tracking_user/widgets/validation/blocage_validation/list_blocage_befor_validation_widget.dart';

class HistoriqueWidget extends StatelessWidget {
  const HistoriqueWidget({Key? key});

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: AppBar(
            automaticallyImplyLeading: false, // Don't show the leading button
            leadingWidth: 40.w,

            leading: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.push('/home');
                }
              },
              icon: SvgPicture.asset(
                  'assets/icons/blocage/Arrow - Left Circle.svg'),
            ),

            elevation: 0,
            centerTitle: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFieldFormsEditProfileWidget(
                    // controller: blocageProvider.typeBlocageController,
                    hint: "Chercher par SIP ou nom de client",
                    onTap: () {},
                    onChanged: (value) {
                      affectationProvider.filtreaffectationsValider(value);

                      affectationProvider.filtreaffectationsPLafie(value);

                      affectationProvider.filtreaffectationsBloquee(value);

                      affectationProvider
                          .filtreaffectationsBloqueeValidation(value);
                    },

                    // controller: userProvider.passwordController,
                    prefixIcon: const Icon(IconlyLight.search),
                    // suffixIcon: const Icon(Icons.visibility),
                    readOnly: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 20,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          affectationProvider.getAffectationTechnicien(context,
                              userProvider.userData!.technicienId.toString());

                          affectationProvider.getAffectationPlanifier(context,
                              userProvider.userData!.technicienId.toString());

                          affectationProvider.getAffectationValider(context,
                              userProvider.userData!.technicienId.toString());

                          // affectationProvider.getAffectationDeclarer(
                          //     context, userProvider.userData!.technicienId.toString());

                          affectationProvider.getAffectationBlocage(context,
                              userProvider.userData!.technicienId.toString());
                          affectationProvider
                              .getAffectationBeforValidationBlocage(
                                  context,
                                  userProvider.userData!.technicienId
                                      .toString());

                          userProvider.getNotifications(context,
                              userProvider.userData!.id.toString());
                        },
                        icon: Icon(
                          Icons.refresh_rounded,
                          size: 28.w,
                        )),
                  ),
                ),
              ],
            ),

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Container(
                  // width: 428.w,
                  decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(1, 1.5),
                    end: Alignment(-0.94597145915031433, -0.8),
                    colors: [
                        Color.fromRGBO(89, 185, 255, 1),
                            Color.fromRGBO(97, 113, 186, 1)
                    ]),
              )),
            ),
            bottom: TabBar(
                labelColor: const Color(0XFF6171ba),
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                indicator: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white),
                onTap: (value) {
                  affectationProvider.getIndexTab(value);
                  //         print(value);
                },
                tabs: [
                  // Tab(
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       "Déclarer",
                  //       style: TextStyle(
                  //           fontSize: 16.sp, fontWeight: FontWeight.w800),
                  //     ),
                  //   ),
                  // ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Terminé",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),

                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Planiefié",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Blocage",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Blocages de validation",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        body: Column(

          children: const [
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(children: [
                AffectationsValiderListWidget(),
                // AffectationsDeclarerListWidget(),
                AffectationsPlanifierListWidget(),
                AffectationBlocageListWidget(),
                AffectationBlocageBeforValidationListWidget(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
