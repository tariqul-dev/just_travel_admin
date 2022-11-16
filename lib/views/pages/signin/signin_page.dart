import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../utils/helper_functions.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/loading_widget.dart';
import '../launcher_page.dart';
import 'components/auth_button.dart';
import 'components/error_message_text.dart';

class SignInPage extends StatelessWidget {
  static const String routeName = '/sign_in';
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  SignInPage({Key? key}) : super(key: key);

  void setAuthentication(BuildContext context) {
    // set email
    context.read<AuthProvider>().setEmail(emailTextEditingController.text);
    //set password
    context
        .read<AuthProvider>()
        .setPassword(passwordTextEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    'Just Travel',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Your Dream Our Efforts',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //  text form fields
                  CustomFormField(
                    controller: emailTextEditingController,
                    icon: Icons.email,
                    labelText: 'Email',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    controller: passwordTextEditingController,
                    icon: Icons.lock,
                    labelText: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       forgotPasswordDialog(context: context);
                  //     },
                  //     child: Text('Forgot Password?'),
                  //   ),
                  // ),

                  const SizedBox(
                    height: 25,
                  ),

                  /*
                  * Sign In button*/
                  AuthButton(
                    buttonName: 'SIGN IN',
                    onPressed: () {
                      // setting authentication info
                      setAuthentication(context);

                      // authenticating user
                      if (formKey.currentState!.validate()) {
                        showLoadingDialog(context);
                        context.read<AuthProvider>().authenticate().then(
                          (value) {
                            print('Login success');
                            Navigator.pushNamedAndRemoveUntil(context,
                                LauncherPage.routeName, (route) => false);
                          },
                        ).onError(
                          (error, stackTrace) {
                            print('error: $error');
                            Navigator.pop(context);
                            showMsg(context, error.toString());
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // showing error message
                  const ErrorMessageText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
