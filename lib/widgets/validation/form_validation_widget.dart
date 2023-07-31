import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/widgets/shared/field_description_widget.dart';
import 'package:tracking_user/widgets/validation/button_validation_widget.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/services/providers/validation_provider.dart';
import 'package:tracking_user/widgets/declaration/field_declaration_widget.dart';
import 'package:tracking_user/widgets/validation/image_picker_widget.dart';
import 'package:tracking_user/widgets/validation/option_image_widget.dart';

class FormValidationWidget extends StatelessWidget {
  final String idAffectation;

  const FormValidationWidget({super.key, required this.idAffectation});

  @override
  Widget build(BuildContext context) {
    final validationProvider = Provider.of<ValidationProvider>(context);

    return Form(
      key: validationProvider.formKey,
      child: Column(
        children: [

          Visibility(
            visible: validationProvider.feedbackBO.isNotEmpty,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey.shade400,
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("* Champs a modifié :  ",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(validationProvider.feedbackBO,
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 15),
                  Container(
                    color: Colors.grey.shade400,
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                            Padding(
            padding: const EdgeInsets.all(8.0),
            child: FieldDeclarationWidget(
              validator: (val) {
                if (val!.isEmpty) {
                  validationProvider.validationInput(val);

                  return 'Le champ est obligatoire *';
                }
                return null;
              },
              controller: TextEditingController(
                  text: validationProvider.cinDescription),
              readOnly: true,
              hint: "Prenez une photo recto de la CIN du client",
              onTap: () {
                context.push(routeOptionCinPage);
              },
              title: 'CIN client',
              keyboardType:
                  TextInputType.number, // This sets the keyboard to numeric
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                // MaxValueTextInputFormatter(
                //     2)
              ],
            ),
          ),
          Visibility(
            visible: validationProvider.cinValueSelected == 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FieldDescriptionWidget(
                readOnly: false,
                hint: "Justification",
                validator: (val) {
                  if (val!.isEmpty &&
                      validationProvider.cinValueSelected == 0) {
                    validationProvider.validationInput(val);

                    return 'Le champ est obligatoire *';
                  }
                  return null;
                },
                controller: validationProvider.justificationCinController,
                title: 'CIN client justification ',
              ),
            ),
          ),
         
          Visibility(
            visible: validationProvider.cinValueSelected == 1 ||
                validationProvider.cinValueSelected == 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImagePickerWidget(
                titel: 'Photo CIN client recto',
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0))),
                      context: context,
                      builder: (context) {
                        return OptionImage(onGaleryTap: () {
                          context.pop();

                          validationProvider
                              .selectGalleryImages(context)
                              .then((value) {
                            validationProvider.cinImage = value;
                            validationProvider.changeState();
                          });
                        }, onCameraTap: () {
                          context.pop();

                          validationProvider
                              .selectCameraImages(context)
                              .then((value) {
                            validationProvider.cinImage = value;
                            validationProvider.changeState();
                          });
                        });
                      }).whenComplete(() {});
                },
                image: validationProvider.cinImage,
              ),
            ),
          ),
        
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FieldDeclarationWidget(
                      controller: validationProvider.testDebitFo,
                      readOnly: false,
                      //  onTap: (){
                      //   context.push(routeOptionPage);
                      //  },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Le champ est obligatoire *';
                        }
                        return null;
                      },
                      title: 'Test_debit_FO :',
                      keyboardType: TextInputType
                          .number, // This sets the keyboard to numeric
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        MaxValueTextInputFormatter(
                            200) // set the maximum value to 100
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImagePickerWidget(
                      titel: 'Test debit via cable img',
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0))),
                            context: context,
                            builder: (context) {
                              return OptionImage(onGaleryTap: () {
                                context.pop();

                                validationProvider
                                    .selectGalleryImages(context)
                                    .then((value) {
                                  validationProvider.testDebitViaCableImg =
                                      value;
                                  validationProvider.changeState();
                                });
                              }, onCameraTap: () {
                                context.pop();

                                validationProvider
                                    .selectCameraImages(context)
                                    .then((value) {
                                  validationProvider.testDebitViaCableImg =
                                      value;
                                  validationProvider.changeState();
                                });
                              });
                            }).whenComplete(() {});
                      },
                      image: validationProvider.testDebitViaCableImg,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImagePickerWidget(
                      titel: 'Photo test debit via Wifi',
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0))),
                            context: context,
                            builder: (context) {
                              return OptionImage(onGaleryTap: () {
                                context.pop();

                                validationProvider
                                    .selectGalleryImages(context)
                                    .then((value) {
                                  validationProvider.photoTestDebitViaWifiImg =
                                      value;
                                  validationProvider.changeState();
                                });
                              }, onCameraTap: () {
                                context.pop();

                                validationProvider
                                    .selectCameraImages(context)
                                    .then((value) {
                                  validationProvider.photoTestDebitViaWifiImg =
                                      value;
                                  validationProvider.changeState();
                                });
                              });
                            }).whenComplete(() {});
                      },
                      image: validationProvider.photoTestDebitViaWifiImg,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ImagePickerWidget(
                  //     titel: 'Image_Test_Signal_FO ',
                  //     onTap: () async {
                  //       FocusScope.of(context).requestFocus(FocusNode());

                  //       showModalBottomSheet(
                  //           isScrollControlled: true,
                  //           shape: const RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(25.0),
                  //                   topRight: Radius.circular(25.0))),
                  //           context: context,
                  //           builder: (context) {
                  //             return OptionImage(onGaleryTap: () {
                  //               context.pop();

                  //               validationProvider
                  //                   .selectGalleryImages(context)
                  //                   .then((value) {
                  //                 validationProvider.imageTestDebitFo = value;
                  //                 validationProvider.changeState();
                  //               });
                  //             }, onCameraTap: () {
                  //               context.pop();

                  //               validationProvider
                  //                   .selectCameraImages(context)
                  //                   .then((value) {
                  //                 validationProvider.imageTestDebitFo = value;
                  //                 validationProvider.changeState();
                  //               });
                  //             });
                  //           }).whenComplete(() {});
                  //     },
                  //     image: validationProvider.imageTestDebitFo,
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImagePickerWidget(
                      titel: 'Routeur/Tel',
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0))),
                            context: context,
                            builder: (context) {
                              return OptionImage(onGaleryTap: () {
                                context.pop();

                                validationProvider
                                    .selectGalleryImages(context)
                                    .then((value) {
                                  validationProvider.routeurTel = value;
                                  validationProvider.changeState();
                                });
                              }, onCameraTap: () {
                                context.pop();

                                validationProvider
                                    .selectCameraImages(context)
                                    .then((value) {
                                  validationProvider.routeurTel = value;
                                  validationProvider.changeState();
                                });
                              });
                            }).whenComplete(() {});
                      },
                      image: validationProvider.routeurTel,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImagePickerWidget(
                      titel: 'Etiquetage',
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0))),
                            context: context,
                            builder: (context) {
                              return OptionImage(onGaleryTap: () {
                                context.pop();

                                validationProvider
                                    .selectGalleryImages(context)
                                    .then((value) {
                                  validationProvider.etiquetageImg = value;
                                  validationProvider.changeState();
                                });
                              }, onCameraTap: () {
                                context.pop();

                                validationProvider
                                    .selectCameraImages(context)
                                    .then((value) {
                                  validationProvider.etiquetageImg = value;
                                  validationProvider.changeState();
                                });
                              });
                            }).whenComplete(() {});
                      },
                      image: validationProvider.etiquetageImg,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImagePickerWidget(
                      titel: 'PV',
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0))),
                            context: context,
                            builder: (context) {
                              return OptionImage(onGaleryTap: () {
                                context.pop();

                                validationProvider
                                    .selectGalleryImages(context)
                                    .then((value) {
                                  validationProvider.pV = value;
                                  validationProvider.changeState();
                                });
                              }, onCameraTap: () {
                                context.pop();

                                validationProvider
                                    .selectCameraImages(context)
                                    .then((value) {
                                  validationProvider.pV = value;
                                  validationProvider.changeState();
                                });
                              });
                            }).whenComplete(() {});
                      },
                      image: validationProvider.pV,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ImagePickerWidget(
                  //     titel: "Fiche d'installation ",
                  //     onTap: () async {
                  //       FocusScope.of(context).requestFocus(FocusNode());

                  //       showModalBottomSheet(
                  //           isScrollControlled: true,
                  //           shape: const RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(25.0),
                  //                   topRight: Radius.circular(25.0))),
                  //           context: context,
                  //           builder: (context) {
                  //             return OptionImage(onGaleryTap: () {
                  //               context.pop();

                  //               validationProvider
                  //                   .selectGalleryImages(context)
                  //                   .then((value) {
                  //                 validationProvider.ficheInstallation =
                  //                     value;
                  //                 validationProvider.changeState();
                  //               });
                  //             }, onCameraTap: () {
                  //               context.pop();

                  //               validationProvider
                  //                   .selectCameraImages(context)
                  //                   .then((value) {
                  //                 validationProvider.ficheInstallation =
                  //                     value;
                  //                 validationProvider.changeState();
                  //               });
                  //             });
                  //           }).whenComplete(() {});
                  //     },
                  //     image: validationProvider.ficheInstallation,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10),
                  child: ButtonValidationWidget(
                    idAffectation: idAffectation,
                    width: MediaQuery.of(context).size.width,
                    title: 'Valider',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MaxValueTextInputFormatter extends TextInputFormatter {
  final int maxValue;

  MaxValueTextInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      int value = int.parse(newValue.text);
      if (value > maxValue) {
        return oldValue; // return the old value if the new value is greater than the maximum value
      }
    }
    return newValue;
  }
}
