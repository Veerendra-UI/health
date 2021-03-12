import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';

class AppStrings {
  static const welcome = 'Welcome';
  static const signIn = "Signin";
  static const tryAgain = "tryAgain";
  static const notNow = "notNow";
  static const dictationJson = "assets/json/appointment.json";
  // team 1 Login Related
  static const your = "Your";
  static const doctors = "Doctors";
  static const welcome_text = 'Welcome!';
  static const your_doctor_text =
      'YourDoctors - Your Practice, Your Patients, Your Peace Of Mind.';
  static const email_text_field_hint = 'Enter your email address ';
  static const password_text_field_hint = 'Password';
  static const sign_in = 'Sign In';
  static const enter_email = 'Please enter your email  ';
  static const wrong_email = 'Enter the correct Email';
  static const enter_password = 'Please enter your password';
  static const wrong_password = 'Enter the correct password';
  static const wrong_password_email = 'Enter the correct Email and Password';

  ///pin screen
  static const yourDrs = "YOURDRS";
  static const loginWithDiffAcc = "Login with different account";
  static const userTouchAndFaceId = 'Use Touch or Face ID';
  static const enterPin = "Enter PIN";
  static const confirmPin = "Confirm PIN";
  static const createPin = "Create PIN";
  static const wrongPin = "WrongPin";
  static const pinNotMatched = "Pin Not Matched";
}

class ApiUrlConstants {
  // for getting Locations//
  static const getLocation =
      AppConstants.dioBaseUrl + "api/Schedule/GetMemberLocations";
  // for getting Provider
  static const getProviders =
      AppConstants.dioBaseUrl + "api/Schedule/GetAssociatedProvider";
  //for getting Schedules
  static const getSchedules =
      AppConstants.dioBaseUrl + "api/Schedule/GetSchedules";
  static const getUser =
      AppConstants.dioBaseUrl + "api/Account/AuthenticateUser";
  static const getUserValidate =
      AppConstants.dioBaseUrl + "api/Account/ValidatePin";
  static const generatePin =
      AppConstants.dioBaseUrl + "api/Account/GenerateMemberPin";
}
