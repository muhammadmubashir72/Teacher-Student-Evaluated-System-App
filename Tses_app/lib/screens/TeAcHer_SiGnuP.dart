// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tses_app/screens/Auth_Service.dart';

import '../widgets.dart';
import 'RoUte_ScReen.dart';
import 'TeAcHer_LoGin.dart';

class TeacherSignUpScreen extends StatefulWidget {
  const TeacherSignUpScreen({super.key});

  @override
  State<TeacherSignUpScreen> createState() => _TeacherSignUpScreen();
}

class _TeacherSignUpScreen extends State<TeacherSignUpScreen> {
  final TextEditingController tusernameController = TextEditingController();
  final TextEditingController temailController = TextEditingController();
  final TextEditingController tpasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final FocusNode namelFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool obscureText = true;

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void signUp() async {
    try {
      await _authService.signUp(
        temailController.text,
        tpasswordController.text,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TeacherLoginScreen()));
      showToast(message: "Signup Successfuly");
    } catch (e) {
      showToast(message: "Signup Failed");
      print('Error during sign-up: $e');
    }
  }

  @override
  void dispose() {
    namelFocus.dispose();
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
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  IconButton(
                    icon: Image.asset("assets/icons8-left-arrow-24.png",
                        width: 25),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RouterScreen()),
                        );
                      });
                    },
                  ),
                ]),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image.asset(
                      "assets/kisspng-education-school-computer-icons-clip-art-coin-5ab83c5c058841.9864736915220235160227.png",
                      width: 50,
                      height: 50),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 5),
                  child: Text(
                    "Signup with your email",
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
                    "Please input verify email address",
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
                    controller: tusernameController,
                    focusNode: namelFocus,
                    cursorColor: const Color(0xff000000),
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: const Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Name',
                      labelStyle: GoogleFonts.lato(
                        color: const Color(0xff000000),
                        // Set the label text color
                        // Set the label font size
                        fontWeight:
                            FontWeight.bold, // Set the label font weight
                      ),
                      hintText: "Full Name",
                      hintStyle: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xff000000),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff0056A7))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff000000))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff000000))),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .grey), // Customize with your desired color
                      ),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(emailFocus);
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (value.trim().length < 4) {
                        return 'Username must be at least 4 characters in length';
                      }

                      // Return null if the entered username is valid
                      return null;
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
                        color: const Color(0xff000000),
                        // Set the label text color
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff0056A7))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff000000))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff000000))),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .grey), // Customize with your desired color
                      ),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    // onTap: () {
                    //   // Reset validation message and error border
                    //   formKey.currentState?.reset();
                    // },
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
                        color: const Color(0xff000000),
                        // Set the label text color
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0056A7)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff000000)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff000000)),
                      ),
                      disabledBorder: OutlineInputBorder(
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
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (value.trim().length < 8) {
                        return 'Password must be at least 8 characters in length';
                      }
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password';
                      }

                      // r'^ -> (?=.*[A-Z])   should contain at least one upper case
                      //  (?=.*[a-z])        should contain at least one lower case
                      //  (?=.*?[0-9])       should contain at least one digit
                      //  (?=.*?[!@#\$&*~])  should contain at least one Special character
                      //  .{8,}              Must be at least 8 characters in length  $
                      // Return null if the entered password is valid
                      return null;
                    },
                    // onTap: () {
                    //   // Reset validation message and error border
                    //   formKey.currentState?.reset();
                    // },
                  ),
                ),
                Container(
                  width: 300,
                  height: 40,
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {

                        if (formKey.currentState!.validate()) {
                          setState(() {
                            signUp();
                            formKey.currentState?.reset();
                          });
                        }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff0056A7)),
                    ),
                    child: Text(
                      "Signup",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TeacherLoginScreen()),
                        );
                      });
                    },
                    child: Text(
                      "Already have an account?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: const Color(0xff000000),
                      ),
                    ),
                  )
                ]),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
