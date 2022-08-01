import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/classroom_model.dart';
import 'package:flutter_app/Model/register_model.dart';

import 'package:flutter_app/Model/student_model.dart';
import 'package:flutter_app/Model/subject_model.dart';
import 'package:flutter_app/screen/AppProvider.dart';
import 'package:flutter_app/screen/ClassRoomScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ClassViewScreen extends StatefulWidget {
  ClassViewScreen(this.classRoomModel, this.registerModelList);
  ClassRoomModel classRoomModel = new ClassRoomModel();
  List<RegistrationModel> registerModelList = [];
  RegistrationModel registerModel = new RegistrationModel();
  @override
  ClassViewScreenState createState() => ClassViewScreenState();
}

class ClassViewScreenState extends State<ClassViewScreen> {
  List<StudentModel> studentsModelList = [];
  List<StudentModel> selectedStudentsModelList = [];
  List<RegistrationModel> allRegistrationDetailList = [];
  RegistrationModel selectedRegistrationModel = new RegistrationModel();
  bool isLoad = false;

  @override
  void initState() {
    getStudentsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF345FB4),
        body: SafeArea(
            child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.classRoomModel.layout.toString() == "classroom"
                    ? "Classroom"
                    : "Conference",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.people,
                  color: Colors.white,
                  size: 26,
                ),
                onTap: () {
                  studentDetailDialogue(studentsModelList).then((value) {
                    if (null != value) {
                      setState(() {});
                    }
                  });

                  setState(() {});
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 75),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subject  : ",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "Teacher : ",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "Credits  : ",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.classRoomModel.subjectName.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        widget.classRoomModel.teacher.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        widget.classRoomModel.credits.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Expanded(

              child: Container(
                  height: MediaQuery.of(context).size.height,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(60),
                  //       topRight: Radius.circular(60),
                  //     ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset(
                          "asset/image/noImageDp.jpg",
                          height: 60.0,
                          width: 80.0,
                          color: Color(0xFF345FB4),
                        ),
                      ),
                      widget.classRoomModel.layout.toString() == "classroom"
                          ? Expanded(
    child:GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),

                              padding: EdgeInsets.all(12),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 2),
                              ),
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.registerModelList.length,
                              itemBuilder: (context, index) {
                                return  GestureDetector(
                                  child: Column(children: [
                                    ClipRRect(
                                      child: Image.asset(
                                        "asset/image/noImageDp.jpg",
                                        height: 30.0,
                                        width: 30.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Card(
                                      elevation: 0,
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: Text(
                                          widget
                                              .registerModelList[index].student
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  onTap: () {
                                    selectedRegistrationModel =
                                        widget.registerModelList[index];
                                    deleteDialogue(
                                        context, selectedRegistrationModel);
                                    setState(() {});
                                  },
                                );
                              },
                            ))
                          : Expanded(
                        child:GridView.builder(
                              padding: EdgeInsets.all(12),
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                    childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                        (MediaQuery.of(context).size.height / 4),
                              ),
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.registerModelList.length,
                              itemBuilder: (context, index) {
                               return GestureDetector(
                                  child: Column(children: [
                                    ClipRRect(
                                      child: Image.asset(
                                        "asset/image/noImageDp.jpg",
                                        height: 30.0,
                                        width: 30.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Card(
                                      elevation: 0,
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: Text(
                                          widget
                                              .registerModelList[index].student
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  onTap: () {
                                    selectedRegistrationModel =
                                    widget.registerModelList[index];
                                    deleteDialogue(
                                        context, selectedRegistrationModel);
                                    setState(() {});
                                  },
                                );
                              },
                            ))
                    ],
                  )),
            )
          ],
        )));

    // TODO: implement build
    // throw UnimplementedError();
  }

  deleteDialogue(BuildContext context, RegistrationModel registerModel) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        deleteStudent(registerModel.id!);
        Navigator.pop(context);
        setState(() {});
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure to delete student"+ registerModel.student.toString()),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future studentDetailDialogue(List<StudentModel> studentModelList) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Register student",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const Align(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueGrey,
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                      alignment: Alignment.topRight,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: studentModelList.length,
                    itemBuilder: (ctx, position) {
                      return SimpleDialogOption(
                        child: GestureDetector(
                          child: Card(
                              color: Colors.grey[300],
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  studentModelList[position].name.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          onTap: () {
                            registerStudent(studentModelList[position],
                                widget.classRoomModel);
                            Navigator.pop(context);
                           setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                )
              ]);
        });
  }



  Future getStudentsData() async {

    String url =
        "https://hamon-interviewapi.herokuapp.com/students/?api_key=126a5";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonData = jsonDecode(responseString);
      var data = jsonData['students'];
      studentsModelList =
      List<StudentModel>.from(data.map((x) => StudentModel.fromJson(x)));
      setState(() {});
    } else {
      return false;
    }
  }

  Future registerStudent(
      StudentModel studentModel, ClassRoomModel classRoomModel) async {
    String url =
        "https://hamon-interviewapi.herokuapp.com/registration/?api_key=126a5";
    var map = new Map<String, dynamic>();
    map['student'] = studentModel.id.toString();
    map['subject'] = classRoomModel.subject.toString();

    EasyLoading.show(status: "Please wait");
    final response = await http.post(Uri.parse(url), body: map);

    String responseString = response.body.toString();
    var jsonData = jsonDecode(responseString);
    if (response.statusCode == 200) {
      var data = jsonData['registration'];

      RegistrationModel selectedRegistrationModel = new RegistrationModel();
      selectedRegistrationModel.subject = int.parse(data['subject'].toString());
      selectedRegistrationModel.id = int.parse(data['id'].toString());
      selectedRegistrationModel.student = int.parse(data['student'].toString());


      widget.registerModelList.add(selectedRegistrationModel);
      // getRegistration();
      setState(() {});

      EasyLoading.showSuccess(
        "Registration completed",
        duration: Duration(seconds: 2),
      );
    } else {
      EasyLoading.showError(jsonData['error'].toString());
    }
  }

  Future getRegistrationData() async {
    String url =
        "https://hamon-interviewapi.herokuapp.com/registration/?api_key=126a5";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonData = jsonDecode(responseString);
      var data = jsonData['registrations'];
      List<RegistrationModel> selectedRegistrationDetailList = [];
      allRegistrationDetailList = List<RegistrationModel>.from(
          data.map((x) => new RegistrationModel.fromJson(x)));
      for (int i = 0; i < allRegistrationDetailList.length; i++) {
        if (allRegistrationDetailList[i].subject ==
            widget.classRoomModel.subject) {
          selectedRegistrationDetailList.add(allRegistrationDetailList[i]);
        }
      }
      widget.registerModelList = selectedRegistrationDetailList;
      setState(() {});

      return false;
    }
  }

  Future deleteStudent(int registrationId) async {
    String url = "https://hamon-interviewapi.herokuapp.com/registration/" +
        registrationId.toString() +
        "?api_key=126a5";
    EasyLoading.show(status: "Please wait");
    final response = await http.delete(Uri.parse(url));

    String responseString = response.body.toString();
    var jsonData = jsonDecode(responseString);
    if (response.statusCode == 200) {
      getRegistrationData();
      setState(() {});

      EasyLoading.showSuccess(
        jsonData['message'],
        duration: Duration(seconds: 2),
      );
      setState(() {});
    } else {
      return false;
    }
  }
}
