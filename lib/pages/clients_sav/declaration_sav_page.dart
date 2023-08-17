import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/sav_ticket.dart';
import 'package:tracking_user/services/providers/declaration_sav_provider.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';
import 'package:tracking_user/widgets/declaration/field_declaration_widget.dart';

import '../../widgets/deblocage/image_picker_widget.dart';
import '../../widgets/validation/option_image_widget.dart';

class DeclarationSavPage extends StatefulWidget {
  final SavTicket affectation;

  const DeclarationSavPage({super.key, required this.affectation});

  @override
  State<DeclarationSavPage> createState() => _DeclarationSavPageState();
}

class _DeclarationSavPageState extends State<DeclarationSavPage> {


  @override
  Widget build(BuildContext context) {
    final declarationProvider = Provider.of<DeclarationSavProvider>(context);

    return LoadingOverlay(
        isLoading: declarationProvider.loading,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                width: double.infinity,
                height: 45.h,
                child: ElevatedButton(
                  onPressed: () {
                    declarationProvider.submit(context, widget.affectation.id.toString());
                  },
                  child: const Text('Declarer'),
                ),
              )),
          appBar: AppBarWidget(
            title: "Déclaration Sav \nclient",
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ImagePickerWidget(
                  titel: 'Photo Test Signal',
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
                              declarationProvider.imageTestSignal = value;
                              declarationProvider.changeState();
                            });
                          }, onCameraTap: () {
                            context.pop();

                            declarationProvider
                                .selectCameraImages(context)
                                .then((value) {
                              declarationProvider.imageTestSignal = value;
                              declarationProvider.changeState();
                            });
                          });
                        }).whenComplete(() {});
                  },
                  image: declarationProvider.imageTestSignal,
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ImagePickerWidget(
                  titel: 'Photo Facultatif',
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
                              declarationProvider.imageFacultatif = value;
                              declarationProvider.changeState();
                            });
                          }, onCameraTap: () {
                            context.pop();

                            declarationProvider
                                .selectCameraImages(context)
                                .then((value) {
                              declarationProvider.imageFacultatif = value;
                              declarationProvider.changeState();
                            });
                          });
                        }).whenComplete(() {});
                  },
                  image: declarationProvider.imageFacultatif,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: FieldDeclarationWidget(
                  maxLines: 10,
                  validator: (val) {
                    return null;
                  },
                  controller: declarationProvider.descriptionController,
                  readOnly: false,
                  //  onTap: (){
                  //   context.push(routeOptionPage);
                  //  },
                  title: 'Description',
                  // This sets the keyboard to numeric
                ),
              ),
            ],
          ),
        ));
  }
}
