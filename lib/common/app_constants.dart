import 'package:YOURDRS_FlutterAPP/common/app_log_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConstants {
  static bool enableCrashlytics = true;

  static const emailPattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?){1,253}$";
  static const phonePattern = r"(^(?:[+0]9)?[0-9]{10,12}$)";
  static const phoneCCPattern = r"(^(?:[+0]9)?[0-9]{1,4}$)";
  static const numberRegExp = r"^[0-9]*$";

  /// 300ms
  static const inputFieldValidateDelay = 300;

  static const pinLength = 4;

  AppConstants._();

  // Locale
  static const supportedLocales = [Locale('en', 'US')];

  // Network
  static const apiTimeout = 30 * 1000; // 30 sec
  static const dioBaseUrl = "https://ydrsdevapi.yourdrs.com/";
  static const dioConnectTimeout = 30 * 1000; // 30 sec
  static const dioReceiveTimeout = 30 * 1000; // 30 sec

  static String authToken;

  // UI
  static const splashScreenTimeout = 2 * 1000; // 2sec

  static String enumToString(Object o) => o.toString().split('.').last;

  static T enumFromString<T>(String key, List<T> values) =>
      values.firstWhere((v) => key == enumToString(v), orElse: () => null);

  static const hhmmaMMMddyyyy = "hh:mm aa MMM dd, yyyy";
  static const hhmmssaMMMddyyyy = "hh:mm:ss aa MMM dd, yyyy";
  static const EEEddMMMM = "EEE, dd MMMM";
  static const ddMMMMyyyy = "dd MMMM yyyy";
  static const yyyyMMdd = "yyyy-MM-dd";
  static const MMMddhhmmaa = "MMM dd hh:mm aa";
  static const ddMMMhhmmaa = "dd MMM hh:mm aa";
  static const ddMMM = "dd MMM";
  static const ddMMMyyyy = "dd MMM yyyy";
  static const MMMyyyy = "MMM, yyyy";
  static const MMM = "MMM";
  static const yyyy = "yyyy";
  static const hhaa = "hh aa";
  static const MMDDYYYY = "yyyy-MM-dd'T'HH:mm:ss'Z'";
  static const MMMddyyyy = "MMM dd, yyyy";
  static String parseDate(int time, String pattern, {DateTime dateTime}) {
    if ((time == null || time < 1) && dateTime == null) {
      return "";
    }
    var date;
    if (dateTime == null) {
      date = DateTime.fromMillisecondsSinceEpoch(time);
    } else {
      date = dateTime;
    }
    try {
      return DateFormat(pattern).format(date);
    } catch (e, s) {
      AppLogHelper.printLogs("AppConstants", e, s);
      return date?.toString() ?? "";
    }
  }

  static String parseDatePattern(String inputPattern, String outPattern) {
    try {
      return DateFormat(outPattern).format(DateTime.parse(inputPattern));
    } catch (e, s) {
      AppLogHelper.printLogs("parseDatePattern", e, s);
      return "";
    }
  }

  static String parseDateWith(int time, DateFormat dateFormatter,
      {DateTime dateTime}) {
    if ((time == null || time < 1) && dateTime == null) {
      return "-";
    }
    var date;
    if (dateTime == null) {
      date = DateTime.fromMillisecondsSinceEpoch(time);
    } else {
      date = dateTime;
    }
    try {
      return dateFormatter.format(date);
    } catch (e, s) {
      AppLogHelper.printLogs("AppConstants", e, s);
      return date?.toString() ?? "-";
    }
  }

  static DateTime timeNow() {
    return DateTime.now();
  }

  static isPhoneNumberValid(String data) {
    return RegExp(phonePattern).hasMatch(data);
  }

  static isPhoneCCValid(String data) {
    return RegExp(phoneCCPattern).hasMatch(data);
  }

  static bool containsUppercase(String input) {
    print("containsUppercase input $input");
    if (input == null || input.isEmpty) {
      return false;
    }
    return input.contains(new RegExp(r'[A-Z]'));
  }

  static bool isPasswordCompliant(String password, [int minLength = 6]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

  static bool isEmailValid(String data) {
    return RegExp(AppConstants.emailPattern).hasMatch(data);
  }

  static bool isNumberValid(String value) {
    return RegExp(numberRegExp).hasMatch(value);
  }

  static bool isOtpValid(String otpValue) {
    bool isOnlyNum = AppConstants.isNumberValid(otpValue);
    bool isLengthOk = (otpValue.length == AppConstants.pinLength);
    return (isOnlyNum && isLengthOk);
  }
}
