import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldDescriptionWidget extends StatelessWidget {
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

  const FieldDescriptionWidget(
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
    return Container(
        alignment: Alignment.center,
        height: 180.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                title ?? '',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
              child: TextFormField(
                  maxLength: 250,
                  readOnly: readOnly,
                  onTap: onTap,
                  textAlignVertical: TextAlignVertical.top,
                  inputFormatters: inputFormatters,
                  validator: validator,
                  onChanged: onChanged,
                  controller: controller,
                  cursorColor: const Color.fromRGBO(5, 119, 130, 1),
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  enableSuggestions: false,
                  textInputAction: textInputAction,
                  maxLines: null,
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
