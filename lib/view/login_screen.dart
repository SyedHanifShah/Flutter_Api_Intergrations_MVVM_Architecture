import 'package:flutter/material.dart';
import 'package:mvvm_pattren/res/components/round_button.dart';
import 'package:mvvm_pattren/utils/Utils.dart';
import 'package:mvvm_pattren/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: emailFocus,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(context, emailFocus, passwordFocus);
              },
              decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.alternate_email_outlined)),
            ),
            TextFormField(
              controller: _passwordController,
              focusNode: passwordFocus,
              obscureText: true,
              obscuringCharacter: "*",
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password_outlined)),
            ),
            SizedBox(
              height: height * .1,
            ),
            RoundButton(
              title: "Login",
              loading: authProvider.loading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please enter email", context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please password email", context);
                } else if (_passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      "Please enter 6 digit password", context);
                } else {
                  Map data = {
                    'email': _emailController.text,
                    'password': _emailController.text
                  };
                  authProvider.loginApi(data, context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
