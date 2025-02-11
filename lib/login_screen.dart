import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // Background image with adjustable size and position
          Positioned(
            top: 60, // Change this value to move the widget vertically
            left: 0, // Change this value to move the widget horizontally
            width: 400, // Width of the image
            height:300, // Height of the image
            child: Image.asset(
              'assets/logo3.png',
              fit: BoxFit.cover,
            ),
          ),



          // White container with multiple children
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
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF353333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Lets Help you make the purchase you need:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF353333),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email field
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xFFE8101B), width: 2.0),
                        ),
                        floatingLabelStyle:
                        const TextStyle(color: Color(0xFFE8101B)),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Password field
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xFFDE6E4B), width: 2.0),
                        ),
                        floatingLabelStyle:
                        const TextStyle(color: Color(0xFFDE6E4B)),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6CA5BD),
                              ),
                            ),
                            Positioned(
                              bottom: 0, // Position the underline below the text
                              child: Container(
                                width: 118, // Match this to the text width
                                height: 1, // Line thickness
                                color: const Color(0xFF6CA5BD),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the HomeScreen when the button is pressed
                          Navigator.of(context).pushNamed('/navscreen');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBC5D5D),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 100),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFDE6E4B),
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    RichText(
                      text: const TextSpan(
                        text: 'You can ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF353333),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'continue as a guest',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFDE6E4B),
                            ),
                          ),
                          TextSpan(
                            text: ' if you don\'t want to log in.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF353333),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBC5D5D),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 100),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 60,
          //   left: 25,
          //   child: Image.asset(
          //     'assets/logo.png',
          //     height: 80,
          //   ),
          // ),
        ],
      ),
    );
  }
}
