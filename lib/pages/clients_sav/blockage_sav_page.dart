import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/declaration_sav_provider.dart';
import 'package:tracking_user/widgets/appBar/appbar_widget.dart';

import '../../widgets/deblocage/image_picker_widget.dart';
import '../../widgets/validation/option_image_widget.dart';

class BlockageSavPage extends StatefulWidget {
  final String affectation;
  String type;

  BlockageSavPage({super.key, required this.type, required this.affectation});

  @override
  State<BlockageSavPage> createState() => _BlockageSavPageState();
}

class _BlockageSavPageState extends State<BlockageSavPage> {
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
                    declarationProvider.submitBlockage(
                        context, widget.affectation, widget.type);
                  },
                  child: const Text('Envoyer'),
                ),
              )),
          appBar: AppBarWidget(
            title: "Blocage Sav \nclient",
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ImagePickerWidget(
                  titel: 'Photo Blocage',
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
                              declarationProvider.imageBlockage = value;
                              declarationProvider.changeState();
                            });
                          }, onCameraTap: () {
                            context.pop();

                            declarationProvider
                                .selectCameraImages(context)
                                .then((value) {
                              declarationProvider.imageBlockage = value;
                              declarationProvider.changeState();
                            });
                          });
                        }).whenComplete(() {});
                  },
                  image: declarationProvider.imageBlockage,
                ),
              ),
            ],
          ),
        ));
  }
}
