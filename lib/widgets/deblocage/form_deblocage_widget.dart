import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/services/providers/deblocage_provider.dart';
import 'package:tracking_user/widgets/deblocage/button_deblocage_widegt.dart';
import 'package:tracking_user/widgets/deblocage/image_picker_widget.dart';
import 'package:tracking_user/widgets/validation/option_image_widget.dart';

class FormeDeblocageWidget extends StatelessWidget {
        final Affectations affectation;

  const FormeDeblocageWidget({super.key, required this.affectation});

  @override
  Widget build(BuildContext context) {
    final deblocageProvider =
        Provider.of<DeblocageProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImagePickerWidget(
              titel: 'Photo spliter avant',
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
                        deblocageProvider
                            .selectGalleryImages(context)
                            .then((value) {
                          deblocageProvider.spliterAvantPhoto =  value;
                          deblocageProvider.changeState();
                        });
                      }, onCameraTap: () {
                        context.pop();

                        deblocageProvider
                            .selectCameraImages(context)
                            .then((value) {
                          deblocageProvider.spliterAvantPhoto = value;
                          deblocageProvider.changeState();
                        });
                      });
                    }).whenComplete(() {



                    });
              },
              image: deblocageProvider.spliterAvantPhoto,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImagePickerWidget(
              titel: 'Photo spliter après',
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
                        deblocageProvider
                            .selectGalleryImages(context)
                            .then((value) {
                          deblocageProvider.spliterApresPhoto = value;
                          deblocageProvider.changeState();
                        });
                      }, onCameraTap: () {
                        context.pop();
                        deblocageProvider
                            .selectCameraImages(context)
                            .then((value) {
                          deblocageProvider.spliterApresPhoto = value;
                          deblocageProvider.changeState();
                        });
                      });
                    }).whenComplete(() {});
              },
              image: deblocageProvider.spliterApresPhoto,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImagePickerWidget(
              titel: 'Photo façade',
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
                        deblocageProvider
                            .selectGalleryImages(context)
                            .then((value) {
                          deblocageProvider.facedePhoto = value;
                          deblocageProvider.changeState();
                        });
                      }, onCameraTap: () {
                        context.pop();
                        deblocageProvider
                            .selectCameraImages(context)
                            .then((value) {
                          deblocageProvider.facedePhoto = value;
                          deblocageProvider.changeState();
                        });
                      });
                    }).whenComplete(() {});
              },
              image: deblocageProvider.facedePhoto,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImagePickerWidget(
              titel: 'Photo chambre',
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
                        deblocageProvider
                            .selectGalleryImages(context)
                            .then((value) {
                          deblocageProvider.chambrePhoto = value;
                          deblocageProvider.changeState();
                        });
                      }, onCameraTap: () {
                        context.pop();
                        deblocageProvider
                            .selectCameraImages(context)
                            .then((value) {
                          deblocageProvider.chambrePhoto = value;
                          deblocageProvider.changeState();
                        });
                      });
                    }).whenComplete(() {});
              },
              image: deblocageProvider.chambrePhoto,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImagePickerWidget(
              titel: 'Photo de signal',
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
                        deblocageProvider
                            .selectGalleryImages(context)
                            .then((value) {
                          deblocageProvider.signalPhoto = value;
                          deblocageProvider.changeState();
                        });
                      }, onCameraTap: () {
                        context.pop();
                        deblocageProvider
                            .selectCameraImages(context)
                            .then((value) {
                          deblocageProvider.signalPhoto = value;
                          deblocageProvider.changeState();
                        });
                      });
                    }).whenComplete(() {});
              },
              image: deblocageProvider.signalPhoto,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            child: ButtonDeblocageWidget(
              width: MediaQuery.of(context).size.width,
              title: 'Débloquer', affectation: affectation
            ),
          )
        ],
      ),
    );
  }
}
