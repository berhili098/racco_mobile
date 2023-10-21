import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/widgets/declaration/button_declaration_widget.dart';
import 'package:tracking_user/widgets/declaration/scan_gpon/fieald_declaration_auto_complet_widget.dart';
import 'package:tracking_user/widgets/declaration/field_declaration_widget.dart';
import 'package:tracking_user/widgets/declaration/image_picker_widget.dart';
import 'package:tracking_user/widgets/declaration/scan_mac/fieald_declaration_auto_mac_complet_widget.dart';
import 'package:tracking_user/widgets/validation/option_image_widget.dart';

class FormDeclationWidget extends StatelessWidget {
  final Affectations affectation;

  const FormDeclationWidget({super.key, required this.affectation});

  @override
  Widget build(BuildContext context) {
    final declarationProvider = Provider.of<DeclarationProvider>(context);

    return Form(
      key: declarationProvider.formKey,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: const Offset(0, 3), // Offset from the top
            ),
          ],
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
          border: Border.all(
            color: Colors.grey.shade300, // Border color
            width: 2.0, // Border width
          ),
        ),
        child: Column(
          children: [
            Visibility(
              visible: declarationProvider.feedbackBO.isNotEmpty,
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
                    Text(declarationProvider.feedbackBO,
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
                            declarationProvider.validationInput(val);

                            return 'Le champ est obligatoire *';
                          }
                          return null;
                        },
                        controller: declarationProvider.testSignalFoController,
                        readOnly: false,
                        //  onTap: (){
                        //   context.push(routeOptionPage);
                        //  },
                        title: 'Test Signal FO (1 - 31)',
                        keyboardType: TextInputType
                            .number, // This sets the keyboard to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          MaxValueTextInputFormatter(
                              31) // set the maximum value to 100
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImagePickerWidget(
                        titel: 'Photo Test Signal FO',
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

                                  declarationProvider
                                      .selectGalleryImages(context)
                                      .then((value) {
                                    declarationProvider.imageTestSignalFo =
                                        value;
                                    declarationProvider.changeState();
                                  });
                                }, onCameraTap: () {
                                  context.pop();

                                  declarationProvider
                                      .selectCameraImages(context)
                                      .then((value) {
                                    declarationProvider.imageTestSignalFo =
                                        value;
                                    declarationProvider.changeState();
                                  });
                                });
                              }).whenComplete(() {});
                        },
                        image: declarationProvider.imageTestSignalFo,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImagePickerWidget(
                        image: declarationProvider.photoPboAvant,
                        titel: 'Photo PBO avant',
                        onTap: () async {
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

                                  declarationProvider
                                      .selectGalleryImages(context)
                                      .then((value) {
                                    declarationProvider.photoPboAvant = value;
                                    declarationProvider.changeState();
                                  });
                                }, onCameraTap: () {
                                  context.pop();

                                  declarationProvider
                                      .selectCameraImages(context)
                                      .then((value) {
                                    declarationProvider.photoPboAvant = value;
                                    declarationProvider.changeState();
                                  });
                                });
                              }).whenComplete(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImagePickerWidget(
                        image: declarationProvider.photoPboApres,
                        titel: 'Photo PBO après',
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

                                  declarationProvider
                                      .selectGalleryImages(context)
                                      .then((value) {
                                    declarationProvider.photoPboApres = value;
                                    declarationProvider.changeState();
                                  });
                                }, onCameraTap: () {
                                  context.pop();

                                  declarationProvider
                                      .selectCameraImages(context)
                                      .then((value) {
                                    declarationProvider.photoPboApres = value;
                                    declarationProvider.changeState();
                                  });
                                });
                              }).whenComplete(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImagePickerWidget(
                        image: declarationProvider.photoPbIAvant,
                        titel: 'Photo PBI avant',
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

                                  declarationProvider
                                      .selectGalleryImages(context)
                                      .then((value) {
                                    declarationProvider.photoPbIAvant = value;
                                    declarationProvider.changeState();
                                  });
                                }, onCameraTap: () {
                                  context.pop();

                                  declarationProvider
                                      .selectCameraImages(context)
                                      .then((value) {
                                    declarationProvider.photoPbIAvant = value;
                                    declarationProvider.changeState();
                                  });
                                });
                              }).whenComplete(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImagePickerWidget(
                        image: declarationProvider.photoPbIApres,
                        titel: 'Photo PBI après',
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

                                  declarationProvider
                                      .selectGalleryImages(context)
                                      .then((value) {
                                    declarationProvider.photoPbIApres = value;
                                    declarationProvider.changeState();
                                  });
                                }, onCameraTap: () {
                                  context.pop();

                                  declarationProvider
                                      .selectCameraImages(context)
                                      .then((value) {
                                    declarationProvider.photoPbIApres = value;
                                    declarationProvider.changeState();
                                  });
                                });
                              }).whenComplete(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImagePickerWidget(
                        image: declarationProvider.photoSpliter,
                        titel: 'Photo Splitter',
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

                                  declarationProvider
                                      .selectGalleryImages(context)
                                      .then((value) {
                                    declarationProvider.photoSpliter = value;
                                    declarationProvider.changeState();
                                  });
                                }, onCameraTap: () {
                                  context.pop();

                                  declarationProvider
                                      .selectCameraImages(context)
                                      .then((value) {
                                    declarationProvider.photoSpliter = value;
                                    declarationProvider.changeState();
                                  });
                                });
                              }).whenComplete(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FieldDeclarationWidget(
                        validator: (val) {
                          if (val!.isEmpty) {
                            declarationProvider.validationInput(val);

                            return 'Le champ est obligatoire *';
                          }
                          return null;
                        },
                        controller:
                            declarationProvider.typeDePassageDeCableController,
                        readOnly: true,
                        hint: 'Choisir le type de passage de câble',
                        onTap: () {
                          context.push(routeOptionTypePassagePage);
                        },
                        title: 'Type de passage de câble',
                        keyboardType: TextInputType
                            .number, // This sets the keyboard to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          // MaxValueTextInputFormatter(
                          //     2)
                        ],
                      ),
                    ),
                    Visibility(
                      visible: declarationProvider
                                  .typeDePassageDeCableController.text !=
                              "Passage via gaine" &&
                          declarationProvider
                              .typeDePassageDeCableController.text.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImagePickerWidget(
                          image: declarationProvider.photoFacade1,
                          titel: 'Facade 1',
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

                                    declarationProvider
                                        .selectGalleryImages(context)
                                        .then((value) {
                                      declarationProvider.photoFacade1 = value;
                                      declarationProvider.changeState();
                                    });
                                  }, onCameraTap: () {
                                    context.pop();

                                    declarationProvider
                                        .selectCameraImages(context)
                                        .then((value) {
                                      declarationProvider.photoFacade1 = value;
                                      declarationProvider.changeState();
                                    });
                                  });
                                }).whenComplete(() {});
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: declarationProvider
                                  .typeDePassageDeCableController.text !=
                              "Passage via gaine" &&
                          declarationProvider
                              .typeDePassageDeCableController.text.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImagePickerWidget(
                          image: declarationProvider.photoFacade2,
                          titel: 'Facade 2',
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

                                    declarationProvider
                                        .selectGalleryImages(context)
                                        .then((value) {
                                      declarationProvider.photoFacade2 = value;
                                      declarationProvider.changeState();
                                    });
                                  }, onCameraTap: () {
                                    context.pop();

                                    declarationProvider
                                        .selectCameraImages(context)
                                        .then((value) {
                                      declarationProvider.photoFacade2 = value;
                                      declarationProvider.changeState();
                                    });
                                  });
                                }).whenComplete(() {});
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: declarationProvider
                                  .typeDePassageDeCableController.text !=
                              "Passage via gaine" &&
                          declarationProvider
                              .typeDePassageDeCableController.text.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImagePickerWidget(
                          image: declarationProvider.photoFacade3,
                          titel: 'Facade 3',
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

                                    declarationProvider
                                        .selectGalleryImages(context)
                                        .then((value) {
                                      declarationProvider.photoFacade3 = value;
                                      declarationProvider.changeState();
                                    });
                                  }, onCameraTap: () {
                                    context.pop();

                                    declarationProvider
                                        .selectCameraImages(context)
                                        .then((value) {
                                      declarationProvider.photoFacade3 = value;
                                      declarationProvider.changeState();
                                    });
                                  });
                                }).whenComplete(() {});
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FieldDeclarationWidget(
                        validator: (val) {
                          if (val!.isEmpty) {
                            declarationProvider.validationInput(val);

                            return 'Le champ est obligatoire *';
                          }
                          return null;
                        },
                        controller: declarationProvider.typeDeRoteurController,
                        readOnly: true,
                        hint: 'Choisir type de routeur',
                        onTap: () {
                          context.push(routeOptionListRoteurWidget);
                        },
                        title: 'Type de routeur',
                        keyboardType: TextInputType
                            .number, // This sets the keyboard to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          // MaxValueTextInputFormatter(
                          //     2)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FiealdDeclarationAutoCompletWidget(
                        title: 'Routeur Gpon',
                        controller: declarationProvider.routeueGponController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FiealdDeclarationAutoCompletMacWidget(
                        title: 'Routeur MAC',
                        controller: declarationProvider.routeueMacController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FieldDeclarationWidget(
                        controller: declarationProvider.sNController,
                        readOnly: false,
                        //  onTap: (){
                        //   context.push(routeOptionPage);
                        //  },
                        title: 'SN télephone',
                        keyboardType: TextInputType
                            .text, // This sets the keyboard to numeric
                        // inputFormatters: <TextInputFormatter>[
                        //   FilteringTextInputFormatter.,
                        //   // MaxValueTextInputFormatter(
                        //   //     2)
                        // ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FieldDeclarationWidget(
                        validator: (val) {
                          if (val!.isEmpty) {
                            declarationProvider.validationInput(val);

                            return 'Le champ est obligatoire *';
                          }
                          return null;
                        },
                        controller:
                            declarationProvider.nbrJarretieresController,
                        readOnly: false,
                        //  onTap: (){
                        //   context.push(routeOptionPage);
                        //  },
                        title: 'Nbr jarretières (0,1,2)',
                        keyboardType: TextInputType
                            .number, // This sets the keyboard to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          MaxValueTextInputFormatter(
                              2) // set the maximum value to 100
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FieldDeclarationWidget(
                        validator: (val) {
                          if (val!.isEmpty) {
                            declarationProvider.validationInput(val);

                            return 'Le champ est obligatoire *';
                          }
                          return null;
                        },
                        controller: declarationProvider.cableMetreController,
                        readOnly: false,
                        //  onTap: (){
                        //   context.push(routeOptionPage);
                        //  },
                        title: 'Cable metre (0 - 200)',
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
                      child: FieldDeclarationWidget(
                        controller: declarationProvider.ptoController,
                        readOnly: false,
                        //  onTap: (){
                        //   context.push(routeOptionPage);
                        //  },
                        title: 'PTO (0,1)',
                        validator: (val) {
                          if (val!.isEmpty) {
                            declarationProvider.validationInput(val);

                            return 'Le champ est obligatoire *';
                          }
                          return null;
                        },
                        keyboardType: TextInputType
                            .number, // This sets the keyboard to numeric
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          MaxValueTextInputFormatter(
                              1) // set the maximum value to 100
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: ButtonDeclarationWidget(
                affectation: affectation,
                width: MediaQuery.of(context).size.width,
                title: 'Déclarer',
              ),
            )
          ],
        ),
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
