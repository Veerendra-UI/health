part of 'login_bloc.dart';

class FormScreenState {
  // boolean value to check true or false
  bool isTrue;
  var memberId;
  bool isLoading;
  bool isPinAvailable;
  var displayName;
  var profileImg;

  FormScreenState(
      {this.isTrue,
      this.memberId,
      this.isLoading,
      this.isPinAvailable,
      this.displayName,
      this.profileImg});
}
