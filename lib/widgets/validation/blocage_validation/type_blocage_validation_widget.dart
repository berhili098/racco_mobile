import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/widgets/blocage/button_send_widget.dart';

class TypeBlocageValidationWidget extends StatelessWidget {
  final String idAffectation;

  const TypeBlocageValidationWidget({Key? key, required this.idAffectation})
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
                  itemCount: BlocageValidationClient.values.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.of(context).size.width,
                            color: const Color.fromRGBO(217, 217, 217, 1),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            blocageProvider.setValueTypeValidationBlocage(
                                BlocageValidationClient.values[index]);
                            // annoncePageProvider.setEtat(
                            //   localeProvider.countryCode == 'FR'
                            //   ?
                            //     annoncePageProvider.etatlist[index].titre
                            //     :   annoncePageProvider.etatlist[index].titreArabe
                            //     ,
                            //     annoncePageProvider.etatlist[index].id);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width,
                            // height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: etatText(
                                      blocageProvider
                                          .getStringFromTypeValidationSwitch(
                                              BlocageValidationClient
                                                  .values[index]),
                                    )),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Radio<String>(
                                      value: blocageProvider
                                          .getStringFromTypeValidationSwitch(BlocageValidationClient
                                          .values[index]),
                                      groupValue: blocageProvider
                                          .typeBlocageValidationController.text,
                                      activeColor:
                                          const Color(0XFF6171ba),
                                      onChanged: (value) {
                                        // blocageProvider
                                        //     .setValueTypeValidationBlocage(
                                        //         value ?? '');
                                      },
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
              context.pushNamed(routeBlocageValidationPage,
                  params: {'idAffectation': idAffectation});
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
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
    );
  }
}
