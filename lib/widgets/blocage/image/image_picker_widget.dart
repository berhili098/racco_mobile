import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/widgets/validation/option_image_widget.dart';

class ImagePickerBlocageWidget extends StatefulWidget {
  final String titel;
  final String imageTitle;
  const ImagePickerBlocageWidget({Key? key, required this.titel, required this.imageTitle}) : super(key: key);

  @override
  State<ImagePickerBlocageWidget> createState() =>
      _ImagePickerBlocageWidgetState();
}

class _ImagePickerBlocageWidgetState extends State<ImagePickerBlocageWidget> {
  Uint8List image = Uint8List(0);

  @override
  Widget build(BuildContext context) {
    final blocageProvider = Provider.of<BlocageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
              padding: const  EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            "${widget.titel} :",
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),          ),
        ),

        
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          // width: MediaQuery.of(context).size.width,
          height: 180.w,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200),
          alignment: Alignment.center,
          child: image.isNotEmpty
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(image),
                        )),
                    InkWell(
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
                                blocageProvider
                                    .selectGaleryImages(context, widget.imageTitle)
                                    .whenComplete(() {
                                  image = blocageProvider.image;

                                  blocageProvider.changeState();
                                });
                              }, onCameraTap: () {
                                context.pop();

                                blocageProvider
                                    .selectCameraImages(context, widget.imageTitle)
                                    .whenComplete(() {
                                  image = blocageProvider.image;

                                  blocageProvider.changeState();
                                });
                              });
                            }).whenComplete(() {});
                      },
                      child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0XFF6171ba),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    )
                  ],
                )
              : InkWell(
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
                            blocageProvider
                                .selectGaleryImages(context, widget.imageTitle)
                                .whenComplete(() {
                              image = blocageProvider.image;

                              blocageProvider.changeState();
                            });
                          }, onCameraTap: () {
                            context.pop();

                            blocageProvider
                                .selectCameraImages(context, widget.imageTitle)
                                .whenComplete(() {
                              image = blocageProvider.image;

                              blocageProvider.changeState();
                            });
                          });
                        }).whenComplete(() {});
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/blocage/Mask group (9).png',
                          color: const Color(0XFF6171ba)),
                      Text(
                        widget.titel,
                        style: const TextStyle(
                          color: Color(0XFF6171ba),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
