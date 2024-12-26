import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppThemes {
  AppThemes._();

  /// Light Theme Colors
  static const Color lightPrimaryColor = Colors.white;
  static const Color lightSecondaryColor = Colors.grey; // Updated for null safety
  static const Color lightTextColor = AppConstantsColor.darkTextColor;

  /// Dark Theme Colors
  static const Color darkPrimaryColor = Colors.black87;
  static const Color darkSecondaryColor = Colors.grey; // Updated for null safety
  static const Color darkTextColor = AppConstantsColor.lightTextColor;

  /// Define light and dark mode toggle
  static bool isDarkMode = false;

  /// Utility methods to access colors based on theme
  static Color get primaryColor =>
      isDarkMode ? darkPrimaryColor : lightPrimaryColor;

  static Color get secondaryColor =>
      isDarkMode ? darkSecondaryColor : lightSecondaryColor;

  static Color get textColor => isDarkMode ? darkTextColor : lightTextColor;

  /// Home
  static TextStyle get homeAppBar => TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get homeProductName => TextStyle(
    color: secondaryColor,
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get homeProductModel => TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  static TextStyle get homeProductPrice => TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static TextStyle get homeMoreText => TextStyle(
    fontSize: 22,
    color: textColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get homeGridNewText => TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static TextStyle get homeGridNameAndModel => TextStyle(
    color: textColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get homeGridPrice => TextStyle(
    color: textColor,
    fontWeight: FontWeight.bold,
  );

  /// Details
  static TextStyle get detailsAppBar => TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );

  static TextStyle get detailsMoreText => TextStyle(
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    height: 1,
  );

  static TextStyle get detailsProductPrice => TextStyle(
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    height: 1,
  );

  static TextStyle get detailsProductDescriptions => TextStyle(
    color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
  );

  /// Bag
  static TextStyle get bagEmptyListTitle => TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get bagEmptyListSubTitle => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get bagTitle => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 35,
  );

  static TextStyle get bagTotal => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 35,
  );

  static TextStyle get bagProductModel => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  static TextStyle get bagProductPrice => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static TextStyle get bagProductNumOfShoe => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get bagTotalPrice => TextStyle(
    color: textColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static TextStyle get bagSumOfItemOnBag => TextStyle(
    color: textColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  /// Profile
  static TextStyle get profileAppBarTitle => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static TextStyle get profileRepeatedListTileTitle => TextStyle(
    fontWeight: FontWeight.bold,
    color: textColor,
    fontSize: 18,
  );

  static TextStyle get profileDevName => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
  );

  /// Button Styles
  static TextStyle get greenColorButtonStyle => TextStyle(
    color: Colors.white,          // Button text color
    fontWeight: FontWeight.bold,   // Text weight
    fontSize: 16,                 // Font size
  );
}
