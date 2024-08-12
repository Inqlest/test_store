import 'package:flutter/material.dart';
import 'package:test_store/res/constants/color_constants.dart';
import 'package:test_store/res/constants/font_constants.dart';

final mainTheme = ThemeData(
  elevatedButtonTheme: elevatedButtonThemeData(),
  inputDecorationTheme: inputDecorationTheme(),
  textSelectionTheme: textSelectionThemeData(),
  progressIndicatorTheme: progressIndicatorTheme(),
  snackBarTheme: snackBarThemeData(),
  scaffoldBackgroundColor: kBackgroundColor,
  primaryColor: kPrimaryColor,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: kTextColor,
    ),
  ),
  useMaterial3: true,
);

SnackBarThemeData snackBarThemeData() {
  return SnackBarThemeData(
    backgroundColor: kGreyColor3,
    contentTextStyle: snackBarTextStyle,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    ),
  );
}

ProgressIndicatorThemeData progressIndicatorTheme() {
  return const ProgressIndicatorThemeData(
    color: kPrimaryColor,
  );
}

TextSelectionThemeData textSelectionThemeData() {
  return const TextSelectionThemeData(
    cursorColor: kPrimaryColor,
    selectionColor: kPrimaryColor,
    selectionHandleColor: kPrimaryColor,
  );
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
      style: ButtonStyle(
    textStyle: WidgetStatePropertyAll(elevateButtonStyle),
    foregroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.white;
      }
      return Colors.black;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.black;
      }
      return Colors.white;
    }),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.black, width: 1),
      ),
    ),
    fixedSize: const WidgetStatePropertyAll(Size(237, 44)),
    elevation: const WidgetStatePropertyAll(0),
    animationDuration: Duration.zero,
  ));
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 48),
    filled: true,
    fillColor: kGreyColor3,
    errorStyle: inputFieldTextStyle.copyWith(color: kErrorColor),
    labelStyle: inputFieldTextStyle.copyWith(color: kGreyColor1),
    disabledBorder: standartOutlineInputBorder(),
    enabledBorder: standartOutlineInputBorder(),
    focusedBorder: activeOutlineInputBorder(),
    errorBorder: errorOutlineInputBorder(),
    focusedErrorBorder: errorOutlineInputBorder(),
  );
}

OutlineInputBorder standartOutlineInputBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    borderSide: BorderSide.none,
  );
}

OutlineInputBorder activeOutlineInputBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    borderSide: BorderSide(color: kPrimaryColor),
  );
}

OutlineInputBorder errorOutlineInputBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    borderSide: BorderSide(color: kErrorColor),
  );
}
