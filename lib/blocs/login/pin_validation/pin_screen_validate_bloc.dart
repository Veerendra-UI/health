import 'dart:async';
import 'package:YOURDRS_FlutterAPP/network/models/login/pin_validate_model.dart';
import 'package:YOURDRS_FlutterAPP/network/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/network/services/login/pin_validate_api.dart';
import 'package:bloc/bloc.dart';
part 'pin_screen_validate_event.dart';
part 'pin_screen_validate_state.dart';

class PinScreenBloc extends Bloc<PinScreenEvent, PinScreenState> {
  PinRepo pinRepo;

  ///creating object of model class for pin generation
  PinScreenBloc(this.pinRepo) : super(PinScreenState(isTrue: true));

  @override
  Stream<PinScreenState> mapEventToState(
    PinScreenEvent event,
  ) async* {
    try {
      // TODO: implement mapEventToState
      if (event is PinScreenEvent) {
        var memberId =
            await MySharedPreferences.instance.getStringValue(Keys.memberId);

        ///here we are accessing shared preference.
        print('memberID $memberId');

        PinResponse pinResponse =
            await pinRepo.postApiMethod(memberId.toString(), event.pin);

        ///passing member id and pin as request to API.
        print('Triggered////////////////////////////////');
        var displayName = pinResponse.displayName;
        var profilePic = pinResponse.profilePhoto;
        print(profilePic);
        print(pinResponse);

        if (pinResponse.header.statusCode == "200") {
          ///if response code is 200 user will be navigated to next screen.
          var username = pinResponse.userName;
          print('HomeScreen user is $username');
          yield PinScreenState(
              isTrue: true,
              name: username,
              displayName: displayName,
              displayPic: profilePic.toString());
        } else if (pinResponse.header.statusCode == "401") {
          print('ShowSnackbar');
          yield PinScreenState(isTrue: false);
        } else {
          print('Unknown Error');
        }
      }
    } catch (exception) {
      print('Event not fond:Error!!! => $exception');
    }
  }
}
