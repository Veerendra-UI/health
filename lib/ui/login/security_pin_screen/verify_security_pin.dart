import 'package:YOURDRS_FlutterAPP/blocs/login/pin_validation/pin_screen_validate_bloc.dart';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/network/services/login/pin_validate_api.dart';
import 'package:YOURDRS_FlutterAPP/ui/home/home_screen.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/login_screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class VerifyPinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinScreenBloc>(
      create: (context) => PinScreenBloc(PinRepo()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // navigatorKey: navigatorKey,
        home: Scaffold(body: PinPutView()),
      ),
    );
  }
}

class PinPutView extends StatefulWidget {
  @override
  PinPutViewState createState() => PinPutViewState();
}

class PinPutViewState extends State<PinPutView> {
  var name;
  var img;

  final _formKey = GlobalKey<FormState>();
  bool visible = false;
  String validatePinput(String value) {
    Pattern pattern = r'^[0-9]*$';
    RegExp regex = new RegExp(pattern);
    print(value);

    try {
      if (value.isEmpty) {
        return 'Cannot be empty';
      } else {
        if (!regex.hasMatch(value))
          return 'Enter valid pin';
        else {
          return null;
        }
      }
    } catch (Exception) {
      print(Exception);
    }
  }

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  /// To retrieve the list of biometric types
  /// (if available).
  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    print(listOfBiometrics);
  }

  bool isAuthenticated = false;

  /// Process of authentication user using
  /// biometrics.
  Future<void> _authenticateUser() async {
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason:
            "Please authenticate to view your transaction overview",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    isAuthenticated
        ? print("user authenticated")
        : print('User is not authenticated.');

    if (isAuthenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PatientAppointment(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return _tabletDisplay();
        } else {
          return _mobileDisplay();
        }
      }),
    );
  }

  void _showSnackBar() {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            AppStrings.wrongPin,
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.redAccent,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 90,
                child: Image.asset(
                  'assets/images/finger.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Touch Id for YourDrs',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Touch/Face ID Authentication'),
                ]),
              ],
            ),
          ),
          actions: <Widget>[
            new Container(
              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Divider(
                thickness: 1,
                color: Colors.black,
                height: 40,
              ),
            ),
            Container(
              width: 400,
              height: 20,
              // color: Colors.yellowAccent,
              alignment: Alignment.center,
              child: RaisedButton(
                color: Colors.white,
                child: Text('Cancel'),
                elevation: 0,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _mobileDisplay() {
    // TODO: implement build
    final BoxDecoration pinPutDecoration = BoxDecoration(
      //color: const Color.fromRGBO(62, 136, 210, 1.0),
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    );
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ListView(children: [
      Container(
        color: CustomizedColors.PinScreenColor,
        child: BlocListener<PinScreenBloc, PinScreenState>(
          listener: (context, state) {
            setState(() {
              img = state.displayPic;
              name = state.name;
            });
            if (state.isTrue == true) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientAppointment()));
            } else {
              _showSnackBar();
              setState(() {
                visible = false;
              });
            }
          },
          child: Container(
            height: height,
            // width: width,

            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Visibility(
                        visible: false,
                        child: Container(
                          child: Center(child: CircularProgressIndicator()),
                        )),
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
                      AppStrings.enterPin,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Container(
                    width: width * 0.65,
                    // color: Colors.deepPurpleAccent,
                    child:
                        // EnterInputFields(data2: widget.data,),
                        Form(
                      key: _formKey,
                      child: GestureDetector(
                        onLongPress: () {
                          print(_formKey.currentState.validate());
                        },
                        child: PinPut(
                          validator: validatePinput,
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
                            var Verify;
                            setState(() {
                              visible = true;
                            });
                            // var MemberID =memberIdFunction();
                            // print("Verify Screen received id is $MemberID");
                            BlocProvider.of<PinScreenBloc>(context)
                                .add(PinScreenEvent(
                              pin,
                              Verify,
                            ));
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () async {
                        if (await _isBiometricAvailable()) {
                          await _getListOfBiometricTypes();
                          await _authenticateUser();
                        }
                      },
                      child: Text(
                        AppStrings.userTouchAndFaceId,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          child: CircularProgressIndicator())),
                ]),
                //_bottomAppBar,
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _tabletDisplay() {
    // TODO: implement build
    final BoxDecoration pinPutDecoration = BoxDecoration(
      //color: const Color.fromRGBO(62, 136, 210, 1.0),
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    );

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ListView(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        color: CustomizedColors.PinScreenColor,
        child: BlocListener<PinScreenBloc, PinScreenState>(
          listener: (context, state) {
            // if(state.Loading==true){
            //   return Center(child: CircularProgressIndicator());
            //
            // }
            if (state.isTrue == true) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientAppointment()));
            } else {
              _showSnackBar();
              setState(() {
                visible = false;
              });
            }
          },
          child: Container(
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
                        height: height * 0.14,
                        // width: width*0.25,
                        child: Image.asset(AppImages.pinImage)),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    child: Text(
                      AppStrings.enterPin,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Container(
                    width: width * 0.65,
                    // color: Colors.deepPurpleAccent,
                    child:
                        // EnterInputFields(data2: widget.data,),
                        Form(
                      key: _formKey,
                      child: GestureDetector(
                        onLongPress: () {
                          print(_formKey.currentState.validate());
                        },
                        child: PinPut(
                          validator: validatePinput,
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
                            var Verify;
                            setState(() {
                              visible = true;
                            });
                            // var MemberID =memberIdFunction();
                            // print("Verify Screen received id is $MemberID");
                            BlocProvider.of<PinScreenBloc>(context)
                                .add(PinScreenEvent(
                              pin,
                              Verify,
                            ));
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

                  // SizedBox(
                  //   height: height * 0.10,
                  // ),
                  Container(
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.remove('login');
                        MySharedPreferences.instance.removeValue('memberId');
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () async {
                        if (await _isBiometricAvailable()) {
                          await _getListOfBiometricTypes();
                          await _authenticateUser();
                        }
                      },
                      child: Text(
                        AppStrings.userTouchAndFaceId,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ]),
                //_bottomAppBar,
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
