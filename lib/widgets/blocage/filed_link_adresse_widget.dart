import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';

class FieldLinkAdresseWidget extends StatelessWidget {
  final String? title;
  final String? prefixText;
  final Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final double? fontSizeHint;
  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;

  const FieldLinkAdresseWidget(
      {Key? key,
      this.title,
      this.maxLength,
      this.controller,
      this.hint,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.maxLines,
      this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.prefixIcon,
      this.inputFormatters,
      this.height,
      this.textInputAction,
      this.fontSizeHint,
      this.prefixText,
      required this.readOnly})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final blocageProvider = Provider.of<BlocageProvider>(context);

    return Container(
        alignment: Alignment.center,
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
              ),
            ),
            Expanded(
              child: TextFormField(
                  // maxLength: 250,
                  readOnly: readOnly,
                  onTap: onTap,
                  textAlignVertical: TextAlignVertical.top,
                  inputFormatters: inputFormatters,
                  validator: validator,
                  onChanged: onChanged,
                  controller: controller,
                  cursorColor: const Color.fromRGBO(5, 119, 130, 1),
                  keyboardType: TextInputType.multiline,
                  // expands: true,
                  style: TextStyle(
                      decoration:
                          blocageProvider.isLinkGoogle(controller!.text) == true
                              ? TextDecoration.underline
                              : TextDecoration.none,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w400,
                      color: blocageProvider.isLinkGoogle(controller!.text) == true
                          ? Theme.of(context).primaryColor
                          : Colors.black),
                  enableSuggestions: false,
                  textInputAction: textInputAction,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      errorStyle: const TextStyle(height: 0),
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      prefixIcon: prefixIcon,
                      prefixText: prefixText,
                      prefixStyle: TextStyle(
                          fontSize: 16.0.sp, fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.all(12),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, right: 14),
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                  height: 10.h,
                                  width: 10.h,
                                  child: suffixIcon))))),
            ),
          ],
        ));
  }
}
