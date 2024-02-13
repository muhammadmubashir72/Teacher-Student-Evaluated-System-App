import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets.dart';

class Course {
  final String id;
  final String name;

  Course({required this.id, required this.name});
}

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<Course> selectedCourses = [];
  late User currentUser;

  List<Course> courses = [
    Course(id: 'dbm', name: 'Data Base Management'),
    Course(id: 'dm', name: 'Digital Marketing'),
    Course(id: 'la', name: 'Linear Algebra'),
    Course(id: 'os', name: 'Operating System'),
    Course(id: 'cs204', name: 'Software Engineering'),
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
        centerTitle: true,
        title: Text(
          'Enrolled Courses',
          style: GoogleFonts.lato(
            color: const Color(0xff0056A7),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedCourses.isNotEmpty) {
                      setState(() {
                        selectedCourses.clear();
                      });
                    } else {}
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff0056A7),
                    ),
                  ),
                  child: Text(
                    "Refresh Selection Box",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelStyle: GoogleFonts.lato(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.bold,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0056A7)),
                ),
              ),
              controller: TextEditingController(
                text: selectedCourses.map((course) => course.name).join(', '),
              ),
              readOnly: true,
              onTap: () {
                _showDropdown(context);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedCourses.isNotEmpty) {
                  _enrollUserInCourses(selectedCourses);
                } else {}
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xff0056A7),
                ),
              ),
              child: Text(
                "Enroll",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: const Color(0xffFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('enrollments')
                  .doc(currentUser.uid)
                  .collection('courses')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No enrolled courses');
                } else {
                  List<String> enrolledCourses = snapshot.data!.docs
                      .map((doc) => doc['courseName'] as String)
                      .toList();

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Enrolled Courses:',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: const Color(0xff000000),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '\n\nCourse Name : ${enrolledCourses.join('\n\nCourse Name : ')}',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: const Color(0xffFFFFFF) ,
          title: Text(
            'Select Courses',
            style: GoogleFonts.lato(
              color: const Color(0xff0056A7),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              children: courses.map((Course course) {
                return CheckboxListTile(
                  activeColor: const Color(0xff0056A7),
                  checkColor: const Color(0xff0056A7),
                  selected: true,
                  title: Text(
                    course.name,
                    style: GoogleFonts.lato(
                      color: const Color(0xff0056A7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: selectedCourses.contains(course),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        if (value) {
                          selectedCourses.add(course);
                        } else {
                          selectedCourses.remove(course);
                        }
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff0056A7)),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.lato(
                  color: const Color(0xffFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _enrollUserInCourses(List<Course> courses) async {
    try {
      for (Course course in courses) {
        await FirebaseFirestore.instance
            .collection('enrollments')
            .doc(currentUser.uid)
            .collection('courses')
            .doc(course.id)
            .set({
          'userId': currentUser.uid,
          'courseId': course.id,
          'courseName': course.name,
          // Add other relevant data
        });
      }
      showToast(message: "Enroll Successful");
      print('Enrollment successful!');
    } catch (error) {
      print('Error enrolling user: $error');
      // Handle the error
    }
  }
}
