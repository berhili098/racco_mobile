import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/blocage_image.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/services/providers/validation_provider.dart';
import 'package:tracking_user/widgets/affectations/icon_botton_widget.dart';
import 'package:tracking_user/widgets/blocage/button_send_widget.dart';
import 'package:tracking_user/widgets/blocage/image/image_picker_widget.dart';
import 'package:tracking_user/widgets/shared/field_description_widget.dart';
import 'package:tracking_user/widgets/login/field_login_widget.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';
import 'package:tracking_user/widgets/validation/image_picker_widget.dart';
import 'package:tracking_user/widgets/validation/option_image_widget.dart';

class FormsBlocageValidationWidget extends StatelessWidget {
  final String idAffectation;
  const FormsBlocageValidationWidget({Key? key, required this.idAffectation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocageProvider = Provider.of<BlocageProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);
    final validationProvider = Provider.of<ValidationProvider>(context);

    return LoadingOverlay(
      isLoading: blocageProvider.isLoading,
      child: Column(
        children: [
          Container(
            width: 428.w,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
              ),
              gradient: LinearGradient(
                  begin: Alignment(1, 1.5),
                  end: Alignment(-0.94597145915031433, -0.8),
                  colors: [
                    Color.fromRGBO(89, 185, 255, 1),
                    Color.fromRGBO(97, 113, 186, 1)
                  ]),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 80.w),
              child: SizedBox(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextFieldFormsEditProfileWidget(
                  controller: blocageProvider.typeBlocageValidationController,
                  hint: "Choisir le type de blocage",
                  onTap: () {
                    context.go(routeTypeBlocageValidationWidget,
                        extra: {'idAffectation': idAffectation});

                    // blocageProvider.showDialog(
                    //     Column(
                    //       // mainAxisAlignment: MainAxisAlignment.end,
                    //       children: <Widget>[
                    //         Container(
                    //           decoration: const BoxDecoration(
                    //             color: Color(0xffffffff),
                    //             border: Border(
                    //               bottom: BorderSide(
                    //                 color: Color(0xff999999),
                    //                 width: 0.0,
                    //               ),
                    //             ),
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: <Widget>[
                    //               CupertinoButton(
                    //                 child: Text('Cancel'),
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //                 padding: const EdgeInsets.symmetric(
                    //                   horizontal: 16.0,
                    //                   vertical: 5.0,
                    //                 ),
                    //               ),
                    //               CupertinoButton(
                    //                 child: Text('Confirm'),
                    //                 onPressed: () {
                    //                   blocageProvider.getValueBlocageClient(
                    //                       blocageProvider
                    //                           .checkValueBlocageClient);

                    //                   Navigator.pop(context);
                    //                 },
                    //                 padding: const EdgeInsets.symmetric(
                    //                   horizontal: 16.0,
                    //                   vertical: 5.0,
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           height: 220.0,
                    //           // color: Color(0xfff7f7f7),
                    //           child: CupertinoPicker(
                    //             magnification: 1.22,
                    //             // squeeze: 2.2,
                    //             // offAxisFraction: 1.2,
                    //             useMagnifier: false,
                    //             itemExtent: 50,
                    //             // This is called when selected item is changed.
                    //             onSelectedItemChanged:
                    //                 (int selectedItem) {
                    //               blocageProvider.getValueBlocageClient(
                    //                   BlocageClient
                    //                       .values[selectedItem].name);
                    //             },
                    //             children: List<Widget>.generate(
                    //                 BlocageClient.values.length,
                    //                 (int index) {
                    //               return Center(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 20.0),
                    //                   child: Text(blocageProvider
                    //                       .getStringFromSwitch(
                    //                           BlocageClient
                    //                               .values[index])),
                    //                 ),
                    //               );
                    //             }),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     context);
                  },
                  // controller: userProvider.passwordController,
                  prefixIcon: Image.asset(
                    'assets/icons/blocage/Mask group (8).png',
                    color: const Color.fromRGBO(97, 113, 186, 1),
                  ),
                  // suffixIcon: const Icon(Icons.visibility),
                  readOnly: true,
                ),
              )),
            ),
          ),
          Expanded(
            child: blocageProvider.checkValueBlocageValidatinClient.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconBottonWidget(
                          icon: IconlyLight.arrow_right_2,
                          text: "Choisir le type de blocage",
                          onTap: () => context.pushNamed(routeTypeBlocage,
                              params: {'idAffectation': idAffectation}))
                      // Text(
                      //   "Choisir le type de blocage !",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w600, fontSize: 20.sp),
                      // ),
                    ],
                  ))
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      blocageProvider.checkValueBlocageValidatinClient ==
                                  blocageProvider
                                      .getStringFromTypeValidationSwitch(
                                          BlocageValidationClient.idErronee) ||
                              blocageProvider
                                      .checkValueBlocageValidatinClient ==
                                  blocageProvider
                                      .getStringFromTypeValidationSwitch(
                                          BlocageValidationClient
                                              .activationBloque) ||
                              blocageProvider
                                      .checkValueBlocageValidatinClient ==
                                  blocageProvider
                                      .getStringFromTypeValidationSwitch(
                                          BlocageValidationClient
                                              .demenagement) ||
                              blocageProvider
                                      .checkValueBlocageValidatinClient ==
                                  blocageProvider
                                      .getStringFromTypeValidationSwitch(
                                          BlocageValidationClient
                                              .retardDactivation)
                          ?
                          
                          ImagePickerBlocageWidget(imageTitle: 'OGIF', titel: 'OGIF',)
                          
                         :SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: FieldDescriptionWidget(
                          hint: 'déscription',
                          readOnly: false, height: 200,
                          controller: blocageProvider.descriptionController,
                          maxLines: 20,

                          // minLines: 1
                        ),
                      )
                    ],
                  ),
          ),
          Visibility(
            visible:
                blocageProvider.typeBlocageValidationController.text.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
              child: ButtonSendWidget(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  if ((blocageProvider.checkValueBlocageValidatinClient ==
                          blocageProvider.getStringFromTypeValidationSwitch(
                              BlocageValidationClient.idErronee) ||
                      blocageProvider.checkValueBlocageValidatinClient ==
                          blocageProvider.getStringFromTypeValidationSwitch(
                              BlocageValidationClient.activationBloque) ||
                      blocageProvider.checkValueBlocageValidatinClient ==
                          blocageProvider.getStringFromTypeValidationSwitch(
                              BlocageValidationClient.demenagement) ||
                      blocageProvider.checkValueBlocageValidatinClient ==
                          blocageProvider.getStringFromTypeValidationSwitch(
                              BlocageValidationClient.retardDactivation))) {


                    if (blocageProvider.imageList.isEmpty) {
                      SncakBarWidgdet.snackBarError(
                          context, "L'image est obligatoire  !");
                    } else {
                      blocageProvider
                          .declarationBlocage(
                              context,
                              blocageProvider.idAffectation,
                              blocageProvider.checkValueBlocageValidatinClient,
                              blocageProvider.descriptionController.text,
                              userProvider.latLngUser,
                              true)
                          .whenComplete(() {
                        affectationProvider.getAffectationTechnicien(context,
                            userProvider.userData!.technicienId.toString());

                        affectationProvider.getAffectationBlocage(context,
                            userProvider.userData!.technicienId.toString());

                        // affectationProvider.removeAffectationBlocage(idAffectation);
                      });
                    }
                  } else if (blocageProvider.checkValueBlocageValidatinClient ==
                          blocageProvider.getStringFromTypeValidationSwitch(
                              BlocageValidationClient.pasDeticket) ||
                      blocageProvider.checkValueBlocageValidatinClient ==
                          blocageProvider.getStringFromTypeValidationSwitch(
                              BlocageValidationClient.porta)) {
                    if (blocageProvider.descriptionController.text.isEmpty) {
                      SncakBarWidgdet.snackBarError(
                          context, "La déscription est obligatoire  !");
                    } else {
                      blocageProvider.clearImage();

                      blocageProvider
                          .declarationBlocage(
                              context,
                              blocageProvider.idAffectation,
                              blocageProvider.checkValueBlocageValidatinClient,
                              blocageProvider.descriptionController.text,
                              userProvider.latLngUser,
                              true)
                          .whenComplete(() {
                        affectationProvider.getAffectationTechnicien(context,
                            userProvider.userData!.technicienId.toString());

                        affectationProvider.getAffectationBlocage(context,
                            userProvider.userData!.technicienId.toString());

                        // affectationProvider.removeAffectationBlocage(idAffectation);
                      });
                    }
                  }

                  // final form = userProvider.formKeyLogin.currentState;

                  // if (form!.validate()) {
                  //   await userProvider.login(userProvider.emailController.text,
                  //       userProvider.passwordController.text, context);
                  // }

                  
                },
                title: "Envoyée",
                width: MediaQuery.of(context).size.width,
              ),
            ),
          )
        ],
      ),
    );
  }
}
