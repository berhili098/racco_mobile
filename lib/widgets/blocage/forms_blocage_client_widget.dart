import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/affectations/icon_botton_widget.dart';
import 'package:tracking_user/widgets/blocage/button_send_widget.dart';
import 'package:tracking_user/widgets/shared/field_description_widget.dart';
import 'package:tracking_user/widgets/blocage/filed_link_adresse_widget.dart';
import 'package:tracking_user/widgets/blocage/image/image_picker_widget.dart';
import 'package:tracking_user/widgets/login/field_login_widget.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class FormsBlocageClientWidget extends StatelessWidget {
  final String idAffectation;
  const FormsBlocageClientWidget({Key? key, required this.idAffectation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocageProvider = Provider.of<BlocageProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);

    return LoadingOverlay(
      isLoading: blocageProvider.isLoading,
      child: Column(
        children: [
          // Figma Flutter Generator Rectangle4164Widget - RECTANGLE
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
                  controller: blocageProvider.typeBlocageController,
                  hint: "Choisir le type de blocage",
                  onTap: () {
                    blocageProvider.clearList();
                    context.pushReplacementNamed(routeTypeBlocage,
                        params: {'idAffectation': idAffectation.toString()});
                  },
                  // controller: userProvider.passwordController,
                  prefixIcon:
                      Image.asset('assets/icons/blocage/Mask group (8).png'),
                  // suffixIcon: const Icon(Icons.visibility),
                  readOnly: true,
                ),
              )),
            ),
          ),
          Expanded(
            child: blocageProvider.checkValueBlocageClient.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconBottonWidget(
                        icon: IconlyLight.arrow_right_2,
                        text: "Choisir le type de blocage",
                        onTap: () => context.push(routeTypeBlocage),
                      )
                    ],
                  ))
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Visibility(
                        visible: blocageProvider.checkValueBlocageClient ==
                            BlocageClient.signalDegrade.name,
                        child: const ImagePickerBlocageWidget(
                            titel: 'Choisir une photo boite',
                            imageTitle: "Photo de boite"),
                      ),
                      blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.adresseErroneDeploye.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.adresseErroneNonDeploye.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.nonEligible.name
                          ? const ImagePickerBlocageWidget(
                              titel: "Choisir une image d'Elecr",
                              imageTitle: "Image d'Elecr")
                          : const SizedBox(),
                      blocageProvider.checkValueBlocageClient ==
                                  BlocageClient
                                      .blocageFacadeCoteApparetemment.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.blocageFacadeCoteVilla.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.blocageFacadeCoteMagasin.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.cabelTransportSature.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une image de blocage',
                              imageTitle: "Image de blocage")
                          : const SizedBox(),
                      blocageProvider.checkValueBlocageClient ==
                              BlocageClient.cabelTransportSature.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une image de transport',
                              imageTitle: "Image de transport")
                          : const SizedBox(),
                      blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.clientAnnuleSaDemande.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.contactErronee.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.demandeEnDouble.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.indisponible.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.injoignableSMS.name
                          ? const ImagePickerBlocageWidget(
                              titel: "Importer une screen d'appel",
                              imageTitle: "screen d'appel")
                          : const SizedBox(),
                      blocageProvider.checkValueBlocageClient ==
                              BlocageClient.injoignableSMS.name
                          ? const ImagePickerBlocageWidget(
                              titel: "Importer une screen de SMS",
                              imageTitle: "Screen de SMS")
                          : const SizedBox(),
                      blocageProvider.typeBlocageController.text ==
                                  blocageProvider.getStringFromSwitch(
                                      BlocageClient.caleTransportDgrades) ||
                              blocageProvider.typeBlocageController.text ==
                                  blocageProvider.getStringFromSwitch(
                                      BlocageClient.manqueCableTransport) ||
                              blocageProvider.checkValueBlocageTechnicien ==
                                  BlocageClient.nonEligible.name ||
                              blocageProvider.checkValueBlocageTechnicien ==
                                  BlocageClient.cabelTransportSature.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.nonEligible.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.adresseErroneDeploye.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.adresseErroneNonDeploye.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une image de facade',
                              imageTitle: "Image de facade")
                          : const SizedBox(),
                      blocageProvider.checkValueBlocageClient ==
                                  BlocageClient
                                      .blocageFacadeCoteApparetemment.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.problemeVerticalite.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.blocageFacadeCoteVilla.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.blocageFacadeCoteMagasin.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une image de schéma',
                              imageTitle: "Image de schéma")
                          : const SizedBox(),
                      blocageProvider.typeBlocageController.text ==
                                  blocageProvider.getStringFromSwitch(
                                      BlocageClient.manqueCableTransport) ||
                              blocageProvider.typeBlocageController.text ==
                                  blocageProvider.getStringFromSwitch(
                                      BlocageClient.caleTransportDgrades) ||
                              blocageProvider.checkValueBlocageTechnicien ==
                                  BlocageClient.cabelTransportSature.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.problemeVerticalite.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une image de blocage',
                              imageTitle: "Image de blocage")
                          : const SizedBox(),
                      blocageProvider.typeBlocageController.text ==
                                  blocageProvider.getStringFromSwitch(
                                      BlocageClient.gponSature) ||
                              blocageProvider.checkValueBlocageTechnicien ==
                                  BlocageClient.splitterSature.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.pasSignal.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.splitterSature.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une photo de spliter',
                              imageTitle: "Photo de spliter")
                          : const SizedBox(),
                      blocageProvider.checkValueBlocageTechnicien ==
                                  BlocageClient.splitterSature.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.pasSignal.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.splitterSature.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une photo de chambre',
                              imageTitle: "Photo de chambre")
                          : const SizedBox(),
                      blocageProvider.typeBlocageController.text ==
                              blocageProvider
                                  .getStringFromSwitch(BlocageClient.gponSature)
                          ? ImagePickerBlocageWidget(
                              titel: 'Choisir une photo GPON saturée',
                              imageTitle:
                                  blocageProvider.checkValueBlocageClient)
                          : const SizedBox(),
                      blocageProvider.checkValueBlocageTechnicien ==
                                  BlocageClient.pasSignal.name ||
                              blocageProvider.checkValueBlocageClient ==
                                  BlocageClient.signalDegrade.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une photo signal',
                              imageTitle: "Photo signal")
                          : const SizedBox(),
                      blocageProvider.checkValueBlocageTechnicien ==
                              BlocageClient.nonEligible.name
                          ? const ImagePickerBlocageWidget(
                              titel: 'Choisir une photo electr',
                              imageTitle: "Photo electr")
                          : const SizedBox(),
                      Visibility(
                        visible: blocageProvider.checkValueBlocageClient ==
                                BlocageClient.adresseErroneDeploye.name ||
                            blocageProvider.checkValueBlocageClient ==
                                BlocageClient.adresseErroneNonDeploye.name ||
                            blocageProvider.checkValueBlocageClient ==
                                BlocageClient.nonEligible.name,
                        child: FieldLinkAdresseWidget(
                          title: 'Adresse',
                          hint:
                              "Veuillez entrer le lien avec l'adresse correcte.",
                          readOnly: false,
                          controller: blocageProvider.adresseLinkController,
                          onChanged: (value) {
                            //
                          },
                        ),
                      ),
                      Visibility(
                        visible: !(blocageProvider.checkValueBlocageClient ==
                                BlocageClient.adresseErroneDeploye.name ||
                            blocageProvider.checkValueBlocageClient ==
                                BlocageClient.adresseErroneNonDeploye.name),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: FieldDescriptionWidget(
                            title: 'Justification',
                            hint: 'Veuillez entrer Justification',
                            readOnly: false, height: 200,
                            controller: blocageProvider.descriptionController,
                            maxLines: 20,

                            // minLines: 1
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Visibility(
            visible: blocageProvider.typeBlocageController.text.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
              child: ButtonSendWidget(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  userProvider.checkPermission(context).whenComplete(() {
                    if (blocageProvider.checkValueBlocageClient ==
                            BlocageClient.clientAnnuleSaDemande.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.contactErronee.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.demandeEnDouble.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.indisponible.name) {
                      if (blocageProvider.imageList.isEmpty) {
                        SncakBarWidgdet.snackBarError(
                            context, "Les images sont obligatoire !");
                      } else {
                        userProvider.latLngUser ?? 
                        print(userProvider.latLngUser.latitude.toString());
                        blocageProvider
                            .declarationBlocage(
                                context,
                                idAffectation,
                                blocageProvider.typeBlocageController.text,
                                blocageProvider.descriptionController.text,
                                userProvider.latLngUser,
                                false)
                            .whenComplete(() {
                          affectationProvider.getAffectationTechnicien(context,
                              userProvider.userData!.technicienId.toString());

                          affectationProvider.getAffectationBlocage(context,
                              userProvider.userData!.technicienId.toString());

                          affectationProvider
                              .removeAffectationBlocage(idAffectation);

                          affectationProvider.getAffectationPlanifier(context,
                              userProvider.userData!.technicienId.toString());
                        });
                      }
                    } else if (blocageProvider.typeBlocageController.text ==
                            blocageProvider.getStringFromSwitch(
                                BlocageClient.gponSature) ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.nonEligible.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.cabelTransportSature.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.blocageFacadeCoteApparetemment.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.blocageFacadeCoteVilla.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.blocageFacadeCoteMagasin.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.manqueCableTransport.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.splitterSature.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.caleTransportDgrades.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.pasSignal.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.injoignableSMS.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.adresseErroneDeploye.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.adresseErroneNonDeploye.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.problemeVerticalite.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.signalDegrade.name) {
                      if (blocageProvider.imageList.length < 2) {
                        SncakBarWidgdet.snackBarError(
                            context, "Les images sont obligatoire  !");
                      } else {
                        if ((blocageProvider.checkValueBlocageClient ==
                                    BlocageClient.adresseErroneDeploye.name ||
                                blocageProvider.checkValueBlocageClient ==
                                    BlocageClient
                                        .adresseErroneNonDeploye.name ||
                                blocageProvider.checkValueBlocageClient ==
                                    BlocageClient.nonEligible.name) &&
                            blocageProvider.isLinkGoogle(blocageProvider
                                    .adresseLinkController.text) ==
                                false) {
                          SncakBarWidgdet.snackBarError(context,
                              "Veuillez entrer le lien avec l'adresse correcte. !");
                        } else {
                          blocageProvider
                              .declarationBlocage(
                                  context,
                                  idAffectation,
                                  blocageProvider.typeBlocageController.text,
                                  (blocageProvider.checkValueBlocageClient ==
                                              BlocageClient
                                                  .adresseErroneDeploye.name ||
                                          blocageProvider
                                                  .checkValueBlocageClient ==
                                              BlocageClient
                                                  .adresseErroneNonDeploye.name)
                                      ? blocageProvider
                                          .adresseLinkController.text
                                      : blocageProvider
                                          .descriptionController.text,
                                  userProvider.latLngUser,
                                  false)
                              .whenComplete(() {
                            affectationProvider.getAffectationTechnicien(
                                context,
                                userProvider.userData!.technicienId.toString());

                            affectationProvider.getAffectationBlocage(context,
                                userProvider.userData!.technicienId.toString());

                            affectationProvider
                                .removeAffectationBlocage(idAffectation);

                            affectationProvider.getAffectationPlanifier(context,
                                userProvider.userData!.technicienId.toString());
                          });
                        }
                      }
                    } else if (blocageProvider.checkValueBlocageClient ==
                            BlocageClient.horsPlaque.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.manqueID.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.adresseErroneDeploye.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.adresseErroneNonDeploye.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.blocagePassageCoteSyndic.name) {
                      if (blocageProvider.descriptionController.text.isEmpty) {
                        SncakBarWidgdet.snackBarError(
                            context, "Le champs est obligatoire !");
                      } else {
                        blocageProvider
                            .declarationBlocage(
                                context,
                                idAffectation,
                                blocageProvider.typeBlocageController.text,
                                blocageProvider.descriptionController.text,
                                userProvider.latLngUser,
                                false)
                            .whenComplete(() {
                          affectationProvider.getAffectationTechnicien(context,
                              userProvider.userData!.technicienId.toString());

                          affectationProvider.getAffectationBlocage(context,
                              userProvider.userData!.technicienId.toString());

                          affectationProvider
                              .removeAffectationBlocage(idAffectation);

                          affectationProvider.getAffectationPlanifier(context,
                              userProvider.userData!.technicienId.toString());
                        });
                      }
                    } else if (blocageProvider.checkValueBlocageClient ==
                            BlocageClient.blocageBdc.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.blocageBesoinJartterier.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.blocageSwan.name ||
                        blocageProvider.checkValueBlocageClient ==
                            BlocageClient.blocageManqueCarteNationel.name) {
                      blocageProvider
                          .declarationBlocage(
                              context,
                              idAffectation,
                              blocageProvider.typeBlocageController.text,
                              blocageProvider.descriptionController.text,
                              userProvider.latLngUser,
                              false)
                          .whenComplete(() {
                        affectationProvider.getAffectationTechnicien(context,
                            userProvider.userData!.technicienId.toString());

                        affectationProvider.getAffectationBlocage(context,
                            userProvider.userData!.technicienId.toString());

                        affectationProvider
                            .removeAffectationBlocage(idAffectation);

                        affectationProvider.getAffectationPlanifier(context,
                            userProvider.userData!.technicienId.toString());
                      });
                    }

                    // final form = userProvider.formKeyLogin.currentState;

                    // if (form!.validate()) {
                    //   await userProvider.login(userProvider.emailController.text,
                    //       userProvider.passwordController.text, context);
                    // }
                  });
                },
                title: "Envoyer",
                width: MediaQuery.of(context).size.width,
              ),
            ),
          )
        ],
      ),
    );
  }
}
