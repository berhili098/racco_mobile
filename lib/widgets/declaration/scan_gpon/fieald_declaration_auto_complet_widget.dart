import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:image/image.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/widgets/declaration/scan_gpon/scan_bar_code_widget.dart';

class FiealdDeclarationAutoCompletWidget extends StatefulWidget {
  final String? title;
  final String? prefixText;
  final Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final double? fontSizeHint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final int? maxLength;
  final int? maxLines;
  final double? fontSize;
  const FiealdDeclarationAutoCompletWidget(
      {super.key,
      this.title,
      this.prefixText,
      this.onTap,
      this.suffixIcon,
      this.prefixIcon,
      this.height,
      this.fontSizeHint,
      this.controller,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.keyboardType,
      this.inputFormatters,
      this.hint,
      this.maxLength,
      this.maxLines,
      this.fontSize});

  @override
  State<FiealdDeclarationAutoCompletWidget> createState() =>
      _FiealdDeclarationAutoCompletWidgetState();
}

class _FiealdDeclarationAutoCompletWidgetState
    extends State<FiealdDeclarationAutoCompletWidget> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String currentText = "";
    final declarationProvider = Provider.of<DeclarationProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            widget.title ?? '',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SimpleAutoCompleteTextField(
                  key: key,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      errorStyle: const TextStyle(height: 0),
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      prefixIcon: widget.prefixIcon,
                      prefixText: widget.prefixText,
                      prefixStyle: TextStyle(
                          fontSize: 16.0.sp, fontWeight: FontWeight.w400),
                      contentPadding: EdgeInsets.only(
                          bottom: 1.h, top: 1.h, left: 10, right: 10),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, right: 14),
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                  height: 10.h,
                                  width: 10.h,
                                  child: widget.suffixIcon)))),
                  controller: widget.controller,
                  suggestions: declarationProvider.routeurList
                      .map((e) => e.snGpon!)
                      .toList(),
                  textChanged: (value) {},
                  clearOnSubmit: false,
                  textSubmitted: (text) {
                    declarationProvider.setRouteturGponController(text);
                  }),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0))),
                    context: context,
                    builder: (context) {
                      return const ScanBarCodePage();
                    }).whenComplete(() {});
              },
              child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(IconlyLight.scan)),
            )
          ],
        ),
        Visibility(
          visible: declarationProvider.checkGponValidationText.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              declarationProvider.checkGponValidationText,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
