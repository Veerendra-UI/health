import 'dart:async';
import 'package:YOURDRS_FlutterAPP/network/models/login/user_class.dart';
import 'package:YOURDRS_FlutterAPP/network/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/network/services/login/user_service.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<FormScreenEvent, FormScreenState> {
  ApiServices services;

  /// creating object of service class.
  LoginBloc(this.services) : super(FormScreenState(isTrue: true));

  ///Receiving service class instance from main.dart
  @override
  Stream<FormScreenState> mapEventToState(
    FormScreenEvent event,) async* {
    try {
      if (event is FormScreenEvent) {
        AuthenticateUser authenticateUser =
            await services.postApiMethod(event.email, event.password);

        ///requesting api for data
        print("My Email is ${event.email}");
        print(authenticateUser);
        bool isPinAvailable;

        /// check if the status value is 200 in response body.
        if (authenticateUser.header.statusCode == "200") {
          var MemberId = authenticateUser.memberRole[0].memberId.toString();
          var displayyName = authenticateUser.displayName;
          var profilePic = authenticateUser.profilePhoto;
          print(displayyName);
          print(profilePic);

          ///storing member id in variable
          print('Member Id is....$MemberId');
          print('Authenticated Successful');
          var result = await MySharedPreferences.instance
              .setStringValue(Keys.memberId, MemberId);

          ///storing member id in shared preference
          print('memberID result $result');
          var ProfilePic = await MySharedPreferences.instance
              .setStringValue(Keys.displayPic, profilePic);
          print("Profile Pic is $ProfilePic");
          var displayName = await MySharedPreferences.instance
              .setStringValue(Keys.displayName, displayyName);
          print("display name is  $displayName");

          if (authenticateUser.memberPin == "") {
            ///here we are checking if user is having member pin or not based on that we are returning true/false value to Bloc listner.
            yield FormScreenState(
              isTrue: true,
              memberId: MemberId,
              isPinAvailable: isPinAvailable = false,
              // displayName: displayyName.toString(),
              // profileImg: profilePic.toString()
            );
          } else {
            yield FormScreenState(
              isTrue: true,
              memberId: MemberId,
              isPinAvailable: isPinAvailable = true,
              // displayName: displayyName.toString(),
              // profileImg: profilePic.toString()
            );
          }

          /// if the status value is not true return as false
        } else {
          print('Authentication Failed');
          yield FormScreenState(isTrue: false);
        }
      }
    } catch (Exception) {
      print("Exception Error");
    }
  }
}
