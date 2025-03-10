import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'package:srhcraftshop/register_screen.dart';
import 'package:srhcraftshop/services/auth_service.dart';
import 'package:srhcraftshop/nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controllers used to manage the text input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // state variables
  String? errorMessage;
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true; // show loading
      errorMessage = null; // clear error
    });

    // get input values and remove spaces
    final identifier = emailController.text.trim();
    final password = passwordController.text.trim();

    // check if user left feild  empty
    if (identifier.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Email and password are required!"; // show error
        isLoading = false; // stop loading
      });
      return;
    }

    // call auth service to login user
    final token = await AuthService.loginUser(identifier, password);

    if (token != null && token != "Login failed") {
      await AuthStorage.saveToken(token); // save token
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavScreen()), // go to main screen
      );
    } else {
      setState(() {
        errorMessage = "Invalid email or password"; // show error
        isLoading = false; // stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // app screenshot figma import
          Positioned(
            top: 60,
            left: 0,
            width: 400,
            height: 300,
            child: Image.asset('assets/logo3.png', fit: BoxFit.cover),
          ),
          // login form
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 180,
            left: MediaQuery.of(context).size.width / 2 - 200,
            width: 400,
            height: 620,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD5D5D5),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title and subtitle
                    const Text(
                      'Welcome!',
                      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300, color: Color(0xFF353333)),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Let’s help you make the purchase you need:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xFF353333)),
                    ),
                    const SizedBox(height: 20),

                    // input fields
                    CustomTextField(controller: emailController, label: 'Email', icon: Icons.email),
                    const SizedBox(height: 16),
                    CustomTextField(controller: passwordController, label: 'Password', icon: Icons.lock, isPassword: true),

                    // forgot password button (does not work)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?', style: TextStyle(fontSize: 13, color: Color(0xFF6CA5BD))),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // login button or loading
                    isLoading
                        ? const Center(child: CircularProgressIndicator()) // show loading
                        : CustomButton(text: 'Log In', onPressed: login), // show button

                    // error message
                    if (errorMessage != null)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: 16)),
                        ),
                      ),

                    const SizedBox(height: 20),

                    // divider with "or"
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('Or', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFFDE6E4B))),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // sign-up button to take back to the sign up page if user forgot
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()), // go to sign-up screen
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
