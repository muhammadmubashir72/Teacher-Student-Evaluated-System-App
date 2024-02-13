// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tses_app/screens/Teacher_Signup.dart';

import 'Student_Signup.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  @override
  State<RouterScreen> createState() => _RouterScreen();
}

class _RouterScreen extends State<RouterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                //  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(

                    margin:const EdgeInsets.only(top:140),
                    child: Image.asset("assets/kisspng-education-school-computer-icons-clip-art-coin-5ab83c5c058841.9864736915220235160227.png",
                    width:150,
                    height:150),
                  ),
                  Container(
                    margin:const EdgeInsets.only(top:20),
                    child:Text("Stay on top of your record with us.",
                    textAlign: TextAlign.center,
                     style: GoogleFonts.lato(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: const Color(0xff000000),
                  ),
                    ),
                  ),
                  Container(
                          width: 300,
                          height: 40,
                          margin: const EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TeacherSignUpScreen()));

                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff0056A7)),
                            ),
                            child: Text(
                              "Teacher",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: const Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                             Container(
                          width: 300,
                          height: 40,
                          margin: const EdgeInsets.only(top:10),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StudentSignUpScreen()));

                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff0056A7)),
                            ),
                            child: Text(
                              "Student",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: const Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                ]
               ),
          ),
        ),
      ),
    );
  }
}
