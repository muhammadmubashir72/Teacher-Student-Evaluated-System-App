// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tses_app/screens/Teacher_Home.dart';

import '../widgets.dart';
import 'Teacher_Signup.dart';
import 'auth_service.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final TextEditingController temailController = TextEditingController();
  final TextEditingController tpasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  final formKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  // Future<void> resetPassword() async {
  //   try {
  //     await _authService.resetPassword(temailController.text);
  //     // Show a success message or navigate to a success screen
  //     print('Password reset email sent successfully');
  //   } catch (e) {
  //     // Handle error, show an error message, etc.
  //     print('Error sending password reset email: $e');
  //   }
  // }
  bool obscureText = true;

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void login() async {
    try {
      await _authService.signIn(
        temailController.text,
        tpasswordController.text,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TeacherHomeScreen()));
      showToast(message: "Login Successfuly");
    } catch (e) {
      showToast(message: "Login Failed");
      print('Error during login: $e');
    }
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(children: [
                Container(
                margin: const EdgeInsets.only(top: 120),
                child: Image.asset(
                    "assets/kisspng-education-school-computer-icons-clip-art-coin-5ab83c5c058841.9864736915220235160227.png",
                    width: 50,
                    height: 50),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 5),
                child: Text(
                  "Login with your account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Text(
                  "Please input valid email address",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: temailController,
                  focusNode: emailFocus,
                  cursorColor: const Color(0xff000000),
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email',
                    labelStyle: GoogleFonts.lato(
                      color:
                      const Color(0xff000000), // Set the label text color
                      // Set the label font size
                      fontWeight:
                      FontWeight.bold, // Set the label font weight
                    ),
                    hintText: "Email Address",
                    hintStyle: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: const Color(0xff000000),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0056A7))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff000000))),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff000000))),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Customize with your desired color
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                  onTap: () {
                    // Reset validation message and error border
                    formKey.currentState?.reset();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: tpasswordController,
                  focusNode: passwordFocus,
                  obscureText: obscureText,
                  cursorColor: const Color(0xff000000),
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Password',
                    labelStyle: GoogleFonts.lato(
                      color:
                      const Color(0xff000000), // Set the label text color
                      // Set the label font size
                      fontWeight:
                      FontWeight.bold, // Set the label font weight
                    ),
                    hintText: "One Word Capital,Small,Special & Number",
                    hintStyle: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: const Color(0xff000000),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0056A7)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff000000)),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: IconButton( onPressed: toggle,icon: Icon(
                  obscureText
                  ? Icons.visibility_off
                      : Icons.visibility,
                    color: const Color(0xff000000),
                  ),
                    ),
                ),
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'This field is required';
                  }
                  if (value
                      .trim()
                      .length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  RegExp regex = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                  if (!regex.hasMatch(value)) {
                    return 'Enter valid password';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              InkWell(
                onTap: () {
                  setState(() {
                    // resetPassword();
                  });
                },
                child: Text(
                  "Forgotton Password?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: const Color(0xff000000),
                  ),
                ),
              )
            ]),
            Container(
              width: 300,
              height: 40,
              margin: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    login();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff0056A7)),
                ),
                child: Text(
                  "Login",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color(0xffFFFFFF),
                  ),
                ),
              ),
            ),
            ]),
      ),
    ),)
    ,
    )
    ,
    );
  }
}
