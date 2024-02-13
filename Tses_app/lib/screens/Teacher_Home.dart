import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tses_app/screens/token.dart';

import '../Database_handler.dart';
import '../models/tiles.Tses.dart';
import 'Course_Screen.dart';
import 'TeAcHer_LoGin.dart';
import 'User_profile.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  List<Tses> _tseslist = [];
  String? tname;
  String? tid;
  String? coursename;
  String? classname;

  void _addlist(String tname, String tid, String classname, String coursename) {
    DatabaseHelper().insertTeacherInfo(tname, tid, classname, coursename);
    setState(() {
      _tseslist.add(
        Tses(
          name: tname,
          id: tid,
          classno: classname,
          course: coursename,
          tsesTime: DateTime.now(),
        ),
      );
    });
  }

  final FocusNode tnameFocus = FocusNode();
  final FocusNode tidFocus = FocusNode();
  final FocusNode courseFocus = FocusNode();
  final FocusNode classFocus = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    tnameFocus.dispose();
    tidFocus.dispose();
    courseFocus.dispose();
    classFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        drawer: Drawer(
          child: ListView(
            // padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff0056A7),
                ),
                child: Text(
                  'Teacher Evalute System',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.supervised_user_circle, color: Color(0xff0056A7)),
                title: Text('Profile'),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
              ListTile(
                leading:  Icon(Icons.info, color: Color(0xff0056A7)),
                title: Text('Get Token'),
                onTap: () {
                  // Add navigation to the page where users can report a lost item
                  Navigator.push(context,MaterialPageRoute(builder: (context) => TokenScreen()));
                },
              ),
              ListTile(
                leading:  Icon(Icons.logout, color: Color(0xff0056A7)),
                title: Text('Sign Out'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TeacherLoginScreen()));
                },
              ),
              // Add more items to the drawer as needed
            ],
          ),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Color(0xff0056A7)),
                iconSize: 30,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          backgroundColor: Colors.white,
          // iconTheme: IconThemeData(color: Color(0xff0056A7)),
          title: Image.asset(
            "assets/kisspng-education-school-computer-icons-clip-art-coin-5ab83c5c058841.9864736915220235160227.png",
            width: 40,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // FirebaseAuth.instance.signOut();
                // Navigator.pop(context);
                // print("Sign out your id");
                // // showToast(message: "Successfully is signed out.");
              },
              icon: Icon(Icons.logout, color: Color(0xff0056A7)),
              iconSize: 30,
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      // Image.asset("assets/icons8-teacher-64.png",
                      //     width:40),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          width: double.maxFinite,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            // Set border radius here
                            color: const Color(0xff0056A7),
                            // Set/ background color here
                            border: Border.all(
                              color: const Color(
                                  0xff000000), // Set border color here
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:30),
                                child: Row(
                                  children: [
                                    Text(
                                      "Enter your class details",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25,
                                        color: const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      "Press arrow button",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return showlist();
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_circle_right_outlined,
                                      color: Color(0xffFFFFFFF),
                                      size: 35, // Adjust the size as needed
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: double.maxFinite,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            // Set border radius here
                            color: const Color(0xff0056A7),
                            // Set background color here
                            border: Border.all(
                              color: const Color(
                                  0xff000000), // Set border color here
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tick S Attandance ",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25,
                                        color: const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      "Press arrow button",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                     setState(() {
                                       Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                               builder: (context) =>  CourseScreen()));
                                     });

                                    },
                                    icon: const Icon(
                                      Icons.arrow_circle_right_outlined,
                                      color: Color(0xffFFFFFFF),
                                      size: 35, // Adjust the size as needed
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: double.maxFinite,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            // Set border radius here
                            color: const Color(0xff0056A7),
                            // Set background color here
                            border: Border.all(
                              color: const Color(
                                  0xff000000), // Set border color here
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Enroll your class course",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25,
                                        color: const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      "Press arrow button",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  CourseScreen()));
                                    },
                                    icon: const Icon(
                                      Icons.arrow_circle_right_outlined,
                                      color: Color(0xffFFFFFFF),
                                      size: 35, // Adjust the size as needed
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(height: 20, width: double.infinity, color: const Color(0xff0056A7) ,child:Text(
                    "Teacher Evaluate System",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                  ),
                ],
              ),
            )));
  }

  Widget showlist() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Color(0xffFFFFFF),
      ),
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Put Your Class Details",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: const Color(0xff000000),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: tnameFocus,
                cursorColor: const Color(0xff000000),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: const Color(0xff000000),
                ),

                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.keyboard),
                  labelText: 'Name',
                  labelStyle: GoogleFonts.lato(
                    color: const Color(0xff000000), // Set the label text color
                    // Set the label font size
                    fontWeight: FontWeight.bold, // Set the label font weight
                  ),
                  hintText: "Enter your name",
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
                ),
                onFieldSubmitted: (value){
                  tname = value;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(tidFocus);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }

                  return null;
                },
                onTap: () {
                  // Reset validation message and error border
                  formKey.currentState?.reset();
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                focusNode: tidFocus,
                cursorColor: const Color(0xff000000),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: const Color(0xff000000),
                ),

                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.keyboard),
                  labelText: 'Id',
                  labelStyle: GoogleFonts.lato(
                    color: const Color(0xff000000), // Set the label text color
                    // Set the label font size
                    fontWeight: FontWeight.bold, // Set the label font weight
                  ),
                  hintText: "Enter your id",
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
                ),
                onFieldSubmitted: (value){
                  tid = value;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(courseFocus);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your id';
                  }

                  return null;
                },

              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: courseFocus,
                cursorColor: const Color(0xff000000),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: const Color(0xff000000),
                ),

                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.keyboard),
                  labelText: 'Course',
                  labelStyle: GoogleFonts.lato(
                    color: const Color(0xff000000), // Set the label text color
                    // Set the label font size
                    fontWeight: FontWeight.bold, // Set the label font weight
                  ),
                  hintText: "Enter your course",
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
                ),
                onFieldSubmitted: (value){
                  coursename = value;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(courseFocus);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your course';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: classFocus,
                cursorColor: const Color(0xff000000),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: const Color(0xff000000),
                ),

                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.keyboard),
                  labelText: 'ClassNo',
                  labelStyle: GoogleFonts.lato(
                    color: const Color(0xff000000), // Set the label text color
                    // Set the label font size
                    fontWeight: FontWeight.bold, // Set the label font weight
                  ),
                  hintText: "Enter your classno",
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
                ),
                onFieldSubmitted: (value){
                  classname = value;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(tidFocus);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your classno';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {

                      },
                      icon: ImageIcon(
                          AssetImage("assets/icons8-appointment-64.png")),
                      iconSize: 30),

                  IconButton(
                      onPressed: () {
                        if (tname != null &&
                            tid != null &&
                            coursename != null &&
                            classname != null) {
                          _addlist(tname!, tid!, coursename!, classname!);
                          Navigator.pop(context);
                        }
                      },
                      icon: ImageIcon(AssetImage("assets/icons8-done-48.png")),
                      iconSize: 30),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
