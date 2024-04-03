// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';

//firebase
import 'package:firebase_auth/firebase_auth.dart';

//locals
import '../Components/MyButtons.dart';
import '../Components/MyTextfields.dart';
import '../Components/SquareTile.dart';
import '../Constants/AppColors.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  //sign user up methode
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //wrong message popup
    void showErrorMessage(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.cyanAccent,
            title: Center(
                child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
          );
        },
      );
    }

    //try create the user
    try {
      //chock if password is confirmed
      if (passwordController.text == ConfirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
      } else {
        //show error message, password dont match
        showErrorMessage('Password Don\'t match!');
      }
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(
          '             this is ecode:${e.code}                  000000000000000000000000000');
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                Image.asset(
                  'lib/images/LOGO.png',
                  height: 180,
                  width: 180,
                ),//Logo
                //let's create an account for you!
                Text(
                  'let\'s create an account for you!',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //username textfield
                MyTextfields(
                  controller: usernameController,
                  hintText: 'username',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                //password textfield
                MyTextfields(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                // confirm password textfield
                MyTextfields(
                  controller: ConfirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                //sign in button
                MyButtons(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),
                const SizedBox(
                  height: 50,
                ),
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: AppColors.expended,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: AppColors.expended,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(imagePath: 'lib/images/GoogleLogo.png'),
                    SizedBox(
                      width: 25,
                    ),
                    //apple button
                    SquareTile(imagePath: 'lib/images/AppleLogo.png'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //not a member? register now!
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account?',
                      style: TextStyle(
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
