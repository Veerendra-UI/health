import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/login_screen/loginscreen.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin_screen/confirm_pin.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class CreatePinScreen extends StatelessWidget {
  CreatePinScreen({Key key, this.data}) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: PinPutView(
        data1: data,
      )),
    );
  }
}

class PinPutView extends StatefulWidget {
  PinPutView({
    Key key,
    this.data1,
  }) : super(key: key);
  final String data1;

  @override
  PinPutViewState createState() => PinPutViewState();
}

class PinPutViewState extends State<PinPutView> {
//  final LocalAuthenticationService _localAuth = locator<LocalAuthenticationService>();

  @override
  Widget build(BuildContext context) {
    var StorePin;
    var MemberId = int.parse(widget.data1);
    // TODO: implement build
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    );

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget _smallDisplay() {
      return Container(
        color: CustomizedColors.PinScreenColor,
        child: Container(
          //  height: height,
          // width: width,

          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    //color: Colors.yellowAccent,
                    child: Text(
                      AppStrings.yourDrs,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Image.asset(AppImages.doctorImg),
                  )
                ]),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Container(
                      height: height * 0.13,
                      //width: width*0.25,
                      child: Image.asset(AppImages.pinImage)),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  child: Text(
                    AppStrings.createPin,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  //color: Colors.red,
                  height: height * 0.06,
                  width: width * 0.65,
                  //color: Colors.deepPurpleAccent,
                  child: Form(
                    key: _formKey,
                    child: GestureDetector(
                      onLongPress: () {
                        print(_formKey.currentState.validate());
                      },
                      child: PinPut(
                        validator: (s) {
                          if (s.contains('2')) return null;
                          return '';
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        withCursor: true,
                        fieldsCount: 4,
                        fieldsAlignment: MainAxisAlignment.spaceAround,
                        textStyle: const TextStyle(
                            fontSize: 25.0, color: Colors.black),
                        eachFieldMargin: EdgeInsets.all(0),
                        eachFieldWidth: 20.0,
                        eachFieldHeight: 25.0,
                        onSubmit: (String pin) {
                          //StorePin = pin;
                          print('Saved Value is $pin');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(

                                  ///here we are sending our Member id and Pin to confirmation Screen.
                                  builder: (context) => ConfirmPinScreen(
                                        data1: pin,
                                        data2: MemberId.toString(),
                                      )));
                        },
                        submittedFieldDecoration: pinPutDecoration,
                        selectedFieldDecoration: pinPutDecoration.copyWith(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(160, 215, 220, 1),
                          ),
                        ),
                        followingFieldDecoration: pinPutDecoration,
                        pinAnimationType: PinAnimationType.scale,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.10,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () async {
                      print('Shared Preference Cleared');
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.remove('login');
                      MySharedPreferences.instance.removeValue('memberId');
                      MySharedPreferences.instance.removeValue('displayName');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      AppStrings.loginWithDiffAcc,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: height * 0.02,
                // ),
                // Container(
                //   child: GestureDetector(
                //     //onTap: _localAuth.authenticate,
                //     //   () => Navigator.of(context).push(
                //     // MaterialPageRoute(builder: (context) => FingerprintPage(),),),
                //     child: Text(
                //       AppStrings.userTouchAndFaceId,
                //       style: TextStyle(color: Colors.white, fontSize: 20),
                //     ),
                //   ),
                // ),
              ]),
              //_bottomAppBar,
            ],
          ),
        ),
      );
    }

    Widget _bigDisplay() {
      return buildSingleChildScrollView(
          height, width, StorePin, context, pinPutDecoration);
    }

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return _bigDisplay();
        } else {
          return _smallDisplay();
        }
      }),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(double height, double width,
      StorePin, BuildContext context, BoxDecoration pinPutDecoration) {
    return SingleChildScrollView(
      child: Container(
        color: CustomizedColors.PinScreenColor,
        child: Container(
          height: height,
          // width: width,

          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    //color: Colors.yellowAccent,
                    child: Text(
                      AppStrings.yourDrs,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Image.asset(AppImages.doctorImg),
                  )
                ]),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Container(
                      height: height * 0.13,
                      //width: width*0.25,
                      child: Image.asset(AppImages.pinImage)),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  child: Text(
                    AppStrings.createPin,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  //color: Colors.red,
                  height: height * 0.13,
                  width: width * 0.65,
                  //color: Colors.deepPurpleAccent,
                  child: Form(
                    key: _formKey,
                    child: GestureDetector(
                      onLongPress: () {
                        print(_formKey.currentState.validate());
                      },
                      child: PinPut(
                        validator: (s) {
                          if (s.contains('2')) return null;
                          return '';
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        withCursor: true,
                        fieldsCount: 4,
                        fieldsAlignment: MainAxisAlignment.spaceAround,
                        textStyle: const TextStyle(
                            fontSize: 25.0, color: Colors.black),
                        eachFieldMargin: EdgeInsets.all(0),
                        eachFieldWidth: 20.0,
                        eachFieldHeight: 25.0,
                        onSubmit: (String pin) {
                          //StorePin = pin;
                          print('Saved Value is $pin');
                          var MemberId = int.parse(widget.data1);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(

                                  ///here we are sending our Member id and Pin to confirmation Screen.
                                  builder: (context) => ConfirmPinScreen(
                                        data1: pin,
                                        data2: MemberId.toString(),
                                      )));
                        },
                        submittedFieldDecoration: pinPutDecoration,
                        selectedFieldDecoration: pinPutDecoration.copyWith(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(160, 215, 220, 1),
                          ),
                        ),
                        followingFieldDecoration: pinPutDecoration,
                        pinAnimationType: PinAnimationType.scale,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.10,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () async {
                      print('Shared Preference Cleared');
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.remove('login');
                      MySharedPreferences.instance.removeValue('memberId');
                      MySharedPreferences.instance.removeValue('displayName');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      AppStrings.loginWithDiffAcc,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: height * 0.02,
                // ),
                // Container(
                //   child: GestureDetector(
                //   //  onTap: _localAuth.authenticate,
                //     //   () => Navigator.of(context).push(
                //     // MaterialPageRoute(builder: (context) => FingerprintPage(),),),
                //     child: Text(
                //       AppStrings.userTouchAndFaceId,
                //       style: TextStyle(color: Colors.white, fontSize: 20),
                //     ),
                //   ),
                // ),
              ]),
              //_bottomAppBar,
            ],
          ),
        ),
      ),
    );
  }
}
