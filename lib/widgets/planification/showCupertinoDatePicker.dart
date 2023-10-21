import 'dart:ui' show ImageFilter;
export 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart'
    show
        Alignment,
        Border,
        BorderSide,
        BoxDecoration,
        BuildContext,
        Color,
        Column,
        Container,
        CrossAxisAlignment,
        CupertinoButton,
        CupertinoDatePicker,
        CupertinoDatePickerMode,
        CupertinoIcons,
        CupertinoTheme,
        EdgeInsets,
        Expanded,
        FontWeight,
        Icon,
        Key,
        MainAxisAlignment,
        Navigator,
        required,
        Row,
        SizedBox,
        Text,
        Widget,
        showCupertinoModalPopup;

import 'package:flutter/material.dart' show Color, Colors;
import 'package:go_router/go_router.dart';
export 'package:flutter/material.dart' show Color, Colors;

void showCupertinoDatePicker(
  BuildContext context, {
  Key? key,
  CupertinoDatePickerMode mode = CupertinoDatePickerMode.dateAndTime,
  required Function(DateTime value) onDateTimeChanged,
  required DateTime initialDateTime,
  DateTime? minimumDate,
  DateTime? maximumDate,
  void Function()? action,
  int minimumYear = 1,
  int? maximumYear,
  int minuteInterval = 1,
  bool use24hFormat = false,
  Color? backgroundColor,
  ImageFilter? filter,
  bool useRootNavigator = true,
  bool? semanticsDismissible,
  Widget? cancelText,
  Widget? doneText,
  bool useText = false,
  bool leftHanded = false,
}) {
  // Default to right now.

  if (!useText) {
    cancelText = const Icon(CupertinoIcons.clear_circled);
  } else {
    cancelText ??= Text(
      'Cancel',
      style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
    );
  }

  if (!useText) {
    doneText = const Icon(CupertinoIcons.check_mark_circled);
  } else {
    action;
    doneText ??= Text(
      'Save',
      style: CupertinoTheme.of(context)
          .textTheme
          .actionTextStyle
          .copyWith(fontWeight: FontWeight.w600),
    );
  }

  var cancelButton = CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: cancelText,
    onPressed: () {
      context.pop();
      onDateTimeChanged(DateTime(0000, 01, 01, 0, 0, 0, 0, 0));
    },
  );

  var doneButton = CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: doneText,
      onPressed: () {
        action!();
      });

  //
  showCupertinoModalPopup(
    context: context,
    builder: (context) => SizedBox(
      height: 240.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(249, 249, 247, 1.0),
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.black38),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                leftHanded ? doneButton : cancelButton,
                leftHanded ? cancelButton : doneButton,
              ],
            ),
          ),
          Expanded(
              child: CupertinoDatePicker(
            key: key,
            mode: mode,
            onDateTimeChanged: (DateTime value) {
              if (onDateTimeChanged == null) return;
              if (mode == CupertinoDatePickerMode.time) {
                onDateTimeChanged(
                    DateTime(0000, 01, 01, value.hour, value.minute));
              } else {
                onDateTimeChanged(value);
              }
            },
            initialDateTime: initialDateTime,
            minimumDate: initialDateTime,
            maximumDate: maximumDate,
            minimumYear: initialDateTime.year,
            maximumYear: maximumYear,
            minuteInterval: minuteInterval,
            use24hFormat: use24hFormat,
            backgroundColor: backgroundColor,
          )),
        ],
      ),
    ),
    filter: filter,
    useRootNavigator: useRootNavigator,
    semanticsDismissible: true,
  ).whenComplete(() {
    context.pop();
  });
}
