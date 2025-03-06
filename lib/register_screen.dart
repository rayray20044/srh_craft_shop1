import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'package:srhcraftshop/services/auth_service.dart';
import 'package:srhcraftshop/nav_screen.dart';
import 'package:srhcraftshop/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //controllers used to manage the text input fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // state variables
  String? errorMessage;
  bool isLoading = false;

  void register() async {
    setState(() {
      isLoading = true; // show loading
      errorMessage = null; // clear error
    });

    // get input values and remove spaces
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // check if any field is empty
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "All fields are required!"; // show error
        isLoading = false; // stop loading
      });
      return;
    }

    // call auth service to register user
    final token = await AuthService.registerUser(username, email, password);

    if (token != null) {
      await AuthStorage.saveToken(token); // save token
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavScreen()), // go to home screen
      );
    } else {
      setState(() {
        errorMessage = "Registration failed!"; // show error
        isLoading = false; // stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // app logo at the top
          Positioned(
            top: 60,
            left: 0,
            width: 400,
            height: 300,
            child: Image.asset('assets/logo3.png', fit: BoxFit.cover),
          ),
          // registration form
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 180,
            left: MediaQuery.of(context).size.width / 2 - 200,
            width: 400,
            height: 620,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD5D5D5), // gray background
                borderRadius: BorderRadius.circular(40), // rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title and subtitle
                    const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300, color: Color(0xFF353333)),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Join us to discover amazing craft products:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xFF353333)),
                    ),
                    const SizedBox(height: 20),

                    // input fields
                    CustomTextField(controller: usernameController, label: 'Username', icon: Icons.person),
                    const SizedBox(height: 16),
                    CustomTextField(controller: emailController, label: 'Email', icon: Icons.email),
                    const SizedBox(height: 16),
                    CustomTextField(controller: passwordController, label: 'Password', icon: Icons.lock, isPassword: true),

                    const SizedBox(height: 30),

                    // sign up button or loading
                    isLoading
                        ? const Center(child: CircularProgressIndicator()) // show loading
                        : CustomButton(text: 'Sign Up', onPressed: register), // show button

                    // error message if exists
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

                    // login button
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()), // go to login screen
                          );
                        },
                        child: const Text(
                          "Already have an account? Log In",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
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


