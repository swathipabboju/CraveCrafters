import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/ReusableWidgets/TextButton.dart';
import '../../utils/ReusableWidgets/button.dart';
import '../../utils/ReusableWidgets/phone_textformfield.dart';
import '../../utils/Routes/appRoutes.dart';
import '../../viewModel/loginViewModel.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProviderForLogin = Provider.of<LoginViewModel>(context);
    TextEditingController _mobile = TextEditingController();
    FocusScopeNode _node = FocusScopeNode();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhoneTextformfield(
              controller: _mobile,
              hintText: 'Mobile Number',
              TextLength: 10,
              keyboardInputType: TextInputType.phone,
              obscureText: false,
              node: _node,
              onEditingComplete: () {
                _node.nextFocus();
              },
              action: TextInputAction.next,
              errorMessage: 'Please Enter Mobile Number',
            ),
            ReusableButton(
              ButtonText: "Login",
              onPressed: () {
                ProviderForLogin.Login(_mobile.text, context);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  ReusableTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signupScreen);
                    },
                    ButtonText: "SignUp here",
                    decoration: TextDecoration.underline,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}