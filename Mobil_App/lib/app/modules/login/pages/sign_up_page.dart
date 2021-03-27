import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kandostum2/app/modules/home/pages/home_page.dart';
import 'package:kandostum2/app/modules/login/controllers/account_controller.dart';
import 'package:kandostum2/app/modules/login/pages/sign_in_page.dart';
import 'package:kandostum2/app/shared/widgets/forms/custom_input_field.dart';
import 'package:kandostum2/app/modules/login/widgets/logotipo.dart';
import 'package:kandostum2/app/modules/login/widgets/password_input_field.dart';
import 'package:kandostum2/app/modules/login/widgets/text_button.dart';
import 'package:kandostum2/app/shared/helpers/snackbar_helper.dart';
import 'package:kandostum2/app/shared/helpers/validator.dart';
import 'package:kandostum2/app/shared/widgets/forms/submit_button.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  AccountController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= Provider.of<AccountController>(context);
  }

  navigatorToLoginPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInPage()));
  }

  signUpWithCredentials() {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      _controller.signUpWithCredentials(
        onSuccess: onSignUpSuccess,
        onError: onSignUpError,
      );
    }
  }

  onSignUpError(error) {
    SnackBarHelper.showFailureMessage(context, title: 'Error', message: error);
  }

  onSignUpSuccess() {
    SnackBarHelper.showSuccessMessage(
      context,
      title: 'Success',
      message: 'Your Registration Has Been Successfully Completed.',
    );

    _controller.signInWithCredentials(
      onSuccess: navigatorToHomePage,
      onError: onSignInError,
    );
  }

  onSignInError(error) {
    navigatorToLoginPage();
  }

  navigatorToHomePage() {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Container(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 2, child: SizedBox()),
                Logotipo(
                  color: Theme.of(context).accentColor,
                ),
                Expanded(child: SizedBox()),
                Observer(builder: (_) {
                  return CustomInputField(
                    label: 'User Name',
                    busy: _controller.busy,
                    textInputType: TextInputType.text,
                    validator: Validator.isValidateName,
                    onSaved: _controller.setName,
                  );
                }),
                SizedBox(height: 10),
                Observer(builder: (_) {
                  return CustomInputField(
                    label: 'Email',
                    busy: _controller.busy,
                    textInputType: TextInputType.emailAddress,
                    validator: Validator.isValidEmail,
                    onSaved: _controller.setEmail,
                  );
                }),
                SizedBox(height: 10),
                Observer(builder: (_) {
                  return PasswordInputField(
                    forgetPassword: false,
                    busy: _controller.busy,
                    textInputType: TextInputType.text,
                    validator: Validator.isValidatePassword,
                    onSaved: _controller.setPassword,
                  );
                }),
                SizedBox(height: 20),
                Observer(builder: (_) {
                  return SubmitButton(
                    label: 'Register',
                    busy: _controller.busy,
                    firstColor: Theme.of(context).accentColor,
                    secondColor: Theme.of(context).primaryColor,
                    onTap: signUpWithCredentials,
                  );
                }),
                Expanded(child: SizedBox()),
                     MetinButton(
                  question: 'Do you have an account?',
                  label: 'Login',
                  onTap: navigatorToLoginPage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
