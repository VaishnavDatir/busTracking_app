import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';
import '../components/customTextInputField.dart';
import 'signup_viewmodel.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: kLargeSpace),
            child: Column(
              children: [
                Text(
                  "Let's get started!",
                  style: appTheme.primaryTextTheme.headline2
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: kSmallSpace,
                ),
                Text(
                  model.isDriver
                      ? "Create an account to share live bus locations"
                      : "Create an account to get live bus locations",
                  style: appTheme.textTheme.caption.copyWith(color: kTextGrey),
                ),
                SizedBox(height: kXLSpace),
                CustomTextInputField(
                  hintText: "Name",
                  focusNode: model.nameTextFN,
                  keyboardType: TextInputType.name,
                  controller: model.nameTextController,
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: Icon(Icons.person),
                  onSubmit: (value) =>
                      FocusScope.of(context).requestFocus(model.emailFN),
                ),
                SizedBox(height: kLargeSpace),
                CustomTextInputField(
                  controller: model.emailTC,
                  focusNode: model.emailFN,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email_sharp),
                  hintText: 'Email',
                  onSubmit: (value) =>
                      FocusScope.of(context).requestFocus(model.passwordFN),
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
                    onPressed: () => model.handleSignUpTap(context),
                    child: Text(
                      "Sign up",
                      style: appTheme.textTheme.button.copyWith(color: kWhite),
                    ),
                  ),
                ),
                Spacer(),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: appTheme.textTheme.bodyText2,
                        children: <TextSpan>[
                          TextSpan(
                            text: model.isDriver
                                ? "Are you a passenger?\n"
                                : "Are you a driver?\n",
                          ),
                          TextSpan(
                              style: appTheme.textTheme.bodyText2.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                              text: model.isDriver
                                  ? "Sign up as a passenger"
                                  : "Sign up as Driver",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => model.changeSignUpType())
                        ])),
                SizedBox(
                  height: kLargeSpace,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
