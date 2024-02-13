// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'RoUte_ScReen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void switchRouterLoginpage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const RouterScreen()));
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), switchRouterLoginpage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body:  Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Spacer(),
              Image.asset(
                "assets/kisspng-education-school-computer-icons-clip-art-coin-5ab83c5c058841.9864736915220235160227.png",
                fit: BoxFit.fill,
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left:5),
                child: Text(
                  "Tse System",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: const Color(0xff0056A7),
                  ),
                ),
              )
              // Spacer(),
            ],
          ),
      ),
    );
  }
}
