import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/blocage/button_send_widget.dart';

class OptionListRoteurWidget extends StatelessWidget {
  const OptionListRoteurWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final declarationProvider = Provider.of<DeclarationProvider>(context);

    List<String> listRouteur = [
      "F680",
      "F6600"

    ];
    return Scaffold(
      appBar: AppBarWidget(
        title: "Type \nde roteur",
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listRouteur.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 10),
                            child: Container(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width,
                              color: const Color.fromRGBO(217, 217, 217, 1),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              declarationProvider
                                  .getValueTypeRoteur(listRouteur[index]);
    
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 10, bottom: 10),

                              width: MediaQuery.of(context).size.width,
                              // height: 200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: etatText(
                                              listRouteur[index]))),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Radio<String>(
                                        value: listRouteur[index],
                                        groupValue: declarationProvider
                                            .groupValueTypeRoteur,
                                        activeColor: const Color(0XFF6171ba),
                                        onChanged: (value) {


                                                       declarationProvider
                                  .getValueTypeRoteur(listRouteur[index]);
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
                context.pop();
                // final form = userProvider.formKeyLogin.currentState;

                // if (form!.validate()) {
                //   await userProvider.login(userProvider.emailController.text,
                //       userProvider.passwordController.text, context);
                // }
              },
              title: "Confirmer",
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }

  Column etatText(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
