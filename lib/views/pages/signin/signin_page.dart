import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/loading_widget.dart';
import '../launcher_page.dart';

class SignInPage extends StatelessWidget {
  static const String routeName = '/signin';
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
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Your Dream Our Efforts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                // CircleAvatar(
                //   radius: 40,
                //   child: Text(
                //     '',
                //     style: Theme.of(context).textTheme.displaySmall?.copyWith(
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 35,
                // ),

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
                  height: 15,
                ),

                /*
                * Sign In button*/
                ElevatedButton(
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
                        },
                      );
                    }
                  },
                  child: const Text('Sign In'),
                ),
                const SizedBox(
                  height: 15,
                ),
                // showing error message
                Center(
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) => Text(
                      authProvider.errorMessage,
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
