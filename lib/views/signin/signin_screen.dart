import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../components/customTextInputField.dart';
import 'signin_viewmodel.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<SignInViewModel>.nonReactive(
      viewModelBuilder: () => SignInViewModel(),
      onModelReady: (model) => model.initializeScreen(),
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          body: Container(
            height: screenHeight,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: kPrimaryColor,
                    child: Center(
                      child: Text(model.screenText,
                          textAlign: TextAlign.center,
                          style: appTheme.primaryTextTheme.headline4.copyWith(
                              fontSize: kLargeSpace * 2, color: kWhite)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(model.scaffoldKey.currentContext).unfocus();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: kLargeSpace),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: kLargeSpace,
                          ),
                          Text(
                            "Welcome back!",
                            style: appTheme.primaryTextTheme.headline4.copyWith(
                              color: kBlack,
                              fontSize: kXLSpace,
                            ),
                          ),
                          SizedBox(
                            height: kLargeSpace,
                          ),
                          CustomTextInputField(
                            controller: model.emailTC,
                            focusNode: model.emailFN,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.email_sharp),
                            hintText: 'Email',
                            onSubmit: (value) {
                              FocusScope.of(model.scaffoldKey.currentContext)
                                  .requestFocus(model.passwordFN);
                            },
                            textInputAction: TextInputAction.go,
                          ),
                          SizedBox(height: kLargeSpace),
                          CustomTextInputField(
                              controller: model.passwordTC,
                              focusNode: model.passwordFN,
                              keyboardType: TextInputType.text,
                              obscureText: model.isObscureText,
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(model.isObscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () => model.changeObsecureValue(),
                              )),
                          SizedBox(
                            height: kMediumSpace,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              onPressed: () => model.handleSignInTap(context),
                              child: Text(
                                "Sign in",
                                style: appTheme.textTheme.button
                                    .copyWith(color: kWhite),
                              ),
                            ),
                          ),
                          SizedBox(height: kXLSpace),
                          RichText(
                              text: TextSpan(
                                  style: appTheme.textTheme.bodyText2,
                                  children: <TextSpan>[
                                TextSpan(
                                  text: "Don't have an account ? ",
                                ),
                                TextSpan(
                                    style: appTheme.textTheme.bodyText2
                                        .copyWith(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold),
                                    text: "Sign up",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => model.gotoSignUpScreen())
                              ])),
                          SizedBox(height: kLargeSpace),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
