import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/pages/clients_sav/blockage_sav_page.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/widgets/blocage/button_send_widget.dart';

import '../../routes.dart';

class TypeBlocageWidget extends StatelessWidget {
  final String idAffectation;
  bool? isSav = false;

  TypeBlocageWidget({Key? key, this.isSav = false, required this.idAffectation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocageProvider = Provider.of<BlocageProvider>(context);

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: isSav == true
                      ? BlocageSavClient.values.length
                      : BlocageClient.values.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.w, right: 12.w),
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width,
                            color: const Color.fromRGBO(217, 217, 217, 1),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            isSav == false
                                ? blocageProvider.setValueTypeBlocage(
                                    BlocageClient.values[index])
                                : blocageProvider.setValueTypeBlocageSav(
                                    BlocageSavClient.values[index]);

                            isSav == true
                                ? blocageProvider.checlValueTypeBlocageSav(
                                    BlocageSavClient.values[index])
                                : blocageProvider.checlValueTypeBlocage(
                                    BlocageClient.values[index]);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 3, bottom: 3),
                            width: MediaQuery.of(context).size.width,
                            // height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: etatText(
                                      isSav == true
                                          ? blocageProvider
                                              .getStringFromSwitchSav(
                                                  BlocageSavClient
                                                      .values[index])
                                          : blocageProvider.getStringFromSwitch(
                                              BlocageClient.values[index]),
                                    )),
                                isSav == false
                                    ? Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Radio<String>(
                                            value: blocageProvider
                                                .getStringFromSwitch(
                                                    BlocageClient
                                                        .values[index]),
                                            groupValue: blocageProvider
                                                .typeBlocageController.text,
                                            activeColor: const Color.fromRGBO(
                                                151, 72, 150, 1),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Radio<String>(
                                            value: blocageProvider
                                                .getStringFromSwitchSav(
                                                    BlocageSavClient
                                                        .values[index]),
                                            groupValue: blocageProvider
                                                .typeBlocageController.text,
                                            activeColor: const Color.fromRGBO(
                                                151, 72, 150, 1),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              //  Container(
              //   alignment: Alignment.center,
              //   child: ButtonCreateAnnonceWidget(
              //     title:S.of(context)!.confirmer,
              //     width: MediaQuery.of(context).size.width * .9,
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
          child: ButtonSendWidget(
            onPressed: () async {
              if (isSav == true) {
                blocageProvider.validate(context).then((val) {
                  if (val) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlockageSavPage(
                                type:
                                    blocageProvider.typeBlocageController.text,
                                affectation: idAffectation.toString(),
                              )),
                    );
                  }
                });
                // blocageProvider.submit(context, idAffectation);
              } else {
                context.pushReplacementNamed(routeFormBlocage,
                    params: {'idAffectation': idAffectation.toString()});
              }
            },
            title: "Confirmer",
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }

  Widget etatText(String name) {
    return Text(
      name,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
    );
  }
}
