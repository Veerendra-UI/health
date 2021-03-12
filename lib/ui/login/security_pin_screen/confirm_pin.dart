import 'package:YOURDRS_FlutterAPP/blocs/login/pin_generation/pin_screen_generate_bloc.dart';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/network/services/login/pin_generation_api.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/login_screen/loginscreen.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin_screen/create_security_pin.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin_screen/verify_security_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPinScreen extends StatelessWidget {
  ConfirmPinScreen({Key key, this.data1, this.data2}) : super(key: key);
  final String data1;
  final String data2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinScreenGenerateBloc>(
      create: (context) => PinScreenGenerateBloc(PinGenerateResponse()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: PinPutView(
          data1: data1,
          data2: data2,
        )),
      ),
    );
  }
}

class PinPutView extends StatefulWidget {
  PinPutView({Key key, this.data1, this.data2}) : super(key: key);
  final String data1;
  final String data2;

  @override
  PinPutViewState createState() => PinPutViewState();
}

class PinPutViewState extends State<PinPutView> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    //final dataBloc = BlocProvider.of<DataBloc>(context);
    //
    var StoredPin = widget.data1;
    var MemberId = widget.data2;
    // var StoredPin = '3434';
    // var MemberId = '1';

    void _showSnackBar(String msg) {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        content: Container(
          height: 80.0,
          child: Center(
            child: Text(
              msg,
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

    // TODO: implement build
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    );

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Widget _portrait() {
      return BlocListener<PinScreenGenerateBloc, PinGenerateScreenState>(
        listener: (context, state) {
          if (state.isTrue == true) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VerifyPinScreen()));
          } else {
            setState(() {
              visible = false;
            });
            _showSnackBar('Latest PIN should not be same as last three pin.');

            // Navigator.pop(context);
          }
        },
        child: buildListView(
            height, width, StoredPin, context, /* MemberId,*/ pinPutDecoration),
      );
    }

    Widget _landScape() {
      return BlocListener<PinScreenGenerateBloc, PinGenerateScreenState>(
        listener: (context, state) {
          if (state.isTrue == true) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VerifyPinScreen()));
          } else {
            setState(() {
              visible = false;
            });
            _showSnackBar('Latest PIN should not be same as last three pin.');

            // Navigator.pop(context);
          }
        },
        child:
            buildListView(height, width, StoredPin, context, pinPutDecoration),
      );
    }

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _portrait();
          } else {
            return _landScape();
          }
        },
      ),
    );
  }

  ListView buildListView(double height, double width, String StoredPin,
      BuildContext context, BoxDecoration pinPutDecoration) {
    return ListView(children: [
      Stack(children: [
        // isLoading?Container(                        ///it will show loading screen on press
        //   color: Colors.black.withOpacity(0.5),
        //   child: Center(
        //     child: CircularProgressIndicator(),
        //   ),
        // ) :
        Container(
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
                      AppStrings.confirmPin,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Container(
                    height: height * 0.10,
                    width: width * 0.65,
                    //color: Colors.deepPurpleAccent,
                    child:
                        // EnterInputFields(data2: widget.data,),
                        Form(
                      key: _formKey,
                      child: GestureDetector(
                        onLongPress: () {
                          print(_formKey.currentState.validate());
                        },
                        child: PinPut(
                          validator: (s) {
                            if (s.contains('1')) return null;
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
                            //isLoading=true;
                            setState(() {
                              visible = true;
                            });
                            if (pin == StoredPin) {
                              var Generate;
                              print("Successful $StoredPin");
                              BlocProvider.of<PinScreenGenerateBloc>(context)
                                  .add(PinGenerateScreenEvent(
                                      pin, Generate, int.parse(widget.data2)));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));

                            } else {
                              // _showSnackBar('Pin Not Matched!!');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreatePinScreen(
                                            data: widget.data2,
                                          )));
                              print('Pin Not Matched');
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePinScreen()));
                            }
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
                  //   child: Text(
                  //     AppStrings.userTouchAndFaceId,
                  //     style: TextStyle(color: Colors.white, fontSize: 20),
                  //   ),
                  // ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(top: 30, bottom: 0),
                          child: CircularProgressIndicator())),
                ]),
                //_bottomAppBar,
              ],
            ),
          ),
        ),
      ]),
    ]);
  }
}
