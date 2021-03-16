import 'package:YOURDRS_FlutterAPP/blocs/login/login/login_bloc.dart';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin_screen/create_security_pin.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin_screen/verify_security_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  /// Declaring global variable
  bool _passwordvisible;
  final _formKey = GlobalKey<FormState>();
  var memberID;
  bool visible = false;

  /// Text editing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Shared Preference
  SharedPreferences logindata;
  SharedPreferences MemberIdData;
  bool newuser;

  /// Check if the user data is already exist or not
  // ignore: non_constant_identifier_names
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => VerifyPinScreen()));
    }
  }

  /// DialogBox to show the popup message if user credentials are wrong
  void _dialogBox() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Text(AppStrings.wrong_password_email,
                style: TextStyle(
                  fontSize: 15,
                ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
    _passwordvisible = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocListener<LoginBloc, FormScreenState>(
      listener: (context, state) {
        /// if the status code is true it execute the statement else go to next statement
        if (state.isTrue == true) {
          if (state.isPinAvailable == true) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PatientAppointment()));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatePinScreen(
                          data: state.memberId,
                        )));
          }
        } else {
          setState(() {
            visible = false;
          });
          _dialogBox();
        }
      },
      child: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _text(),
                  _welcome_text(),
                  _youroctors_text(),
                  _circular_progres(),
                  _form_field(),
                  _Signin_button(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Container for your doctor text with image
  @override
  Widget _text() {
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        // which add Row properties at the center
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.your,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: CustomizedColors.your_text_color),
          ),
          Text(
            AppStrings.doctors,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: CustomizedColors.doctor_text_color),
          ),
          Image.asset(
            AppImages.doctorImg,
            // I added asset image
            height: 60,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: height * 0.1),
    );
  }

  /// Container for welcome screen Text
  @override
  Widget _welcome_text() {
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Text(
        AppStrings.welcome_text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
      ),
      margin: EdgeInsets.only(bottom: height * 0.04),
    );
  }

  /// Container for your_doctors quote text
  @override
  Widget _youroctors_text() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height * 0.2,
          maxWidth: width * 0.9,
        ),
        child: Text(
          AppStrings.your_doctor_text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: CustomizedColors.your_doctors_text_color),
        ),
      ),
      margin: EdgeInsets.only(bottom: height * 0.02),
    );
  }

  /// Circular progress indicator to show that data is loading
  @override
  Widget _circular_progres() {
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: visible,
        child: Container(child: CircularProgressIndicator()),
      ),
      margin: EdgeInsets.only(bottom: height * 0.02),
    );
  }

  /// Two Form field to which validate the user input
  @override
  _form_field() {
    var height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomizedColors.text_field_background,
              borderRadius: BorderRadius.circular(10),
            ),

            /// TextFormField for Email
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.enter_email;
                }
                return null;
              },
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                border: InputBorder.none,
                hintText: AppStrings.email_text_field_hint,
              ),
            ),
            margin: EdgeInsets.only(
                left: height * 0.04,
                right: height * 0.04,
                top: height * 0.06,
                bottom: height * 0.05),
          ),
          Container(
            decoration: BoxDecoration(
              color: CustomizedColors.text_field_background,
              borderRadius: BorderRadius.circular(10),
            ),

            /// TextFormField for password
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.enter_password;
                }
                return null;
              },
              controller: passwordController,
              obscureText: !_passwordvisible,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 15),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordvisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordvisible = !_passwordvisible;
                    });
                  },
                ),
                hintText: AppStrings.password_text_field_hint,
              ),
            ),

            margin: EdgeInsets.only(
                left: height * 0.04,
                right: height * 0.04,
                bottom: height * 0.05),
          ),
        ],
      ),
    );
  }

  /// Onclick of sign in  Button user validated and navigated to next screen
  @override
  Widget _Signin_button() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: CustomizedColors.text_field_background,
        borderRadius: BorderRadius.circular(10),
      ),
      width: width,
      height: height * 0.06,
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print('Successful');
              setState(() {
                visible = true;
              });
              logindata.setBool('login', false);
              logindata.setString('username', emailController.text);
              print("This is Email ${emailController.text}");
              BlocProvider.of<LoginBloc>(context).add(FormScreenEvent(
                  emailController.text, passwordController.text));
            }
          },
          color: CustomizedColors.signInButtonColor,
          child: Text(
            AppStrings.sign_in,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: CustomizedColors.sign_in_text_color),
          )),
      margin: EdgeInsets.only(
          left: height * 0.04, right: height * 0.04, top: height * 0.05),
    );
  }
}

