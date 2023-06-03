import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import '/backend/controllers/registration_controller.dart';
import 'package:counselaicompanion/frontend/screens/counsel_cases.dart';
import 'dart:ui';
import '/frontend/utils/validator.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _focusEmail = FocusNode();
  final _focusOTP = FocusNode();
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'assets/images/background_picture.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 14,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .15,
                                      bottom: size.width * .1,
                                    ),
                                    child: SizedBox(
                                      height: size.height * 0.15,
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  component(Icons.account_circle_outlined,
                                      'Enter Your Email Address', true),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      registrationController.handleSubmit();
                                      HapticFeedback.lightImpact();
                                      Fluttertoast.showToast(
                                        msg: 'Email Address Button Is Pressed',
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow.withOpacity(1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Get OTP',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  component(Icons.email_outlined,
                                      'Enter Your OTP', false),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      // registrationController.handleOTP();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
                                      HapticFeedback.lightImpact();
                                      Fluttertoast.showToast(
                                        msg: 'Sign Up Button Is Pressed',
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow.withOpacity(1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component(IconData icon, String hintText, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 5,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: <Widget>[
        TextFormField(
          focusNode: isEmail ? _focusEmail : _focusOTP,
          controller: isEmail
              ? registrationController.emailController
              : registrationController.otpController,
          validator: (value) => isEmail
              ? Validator.validateEmail(
                  email: value,
                )
              : null,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(.9),
          ),
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.white.withOpacity(.8),
            ),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(.5),
            ),
          ),
        ),
      ]),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
