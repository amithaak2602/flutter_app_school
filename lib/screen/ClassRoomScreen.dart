import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/classroom_model.dart';

import 'package:flutter_app/Model/student_model.dart';
import 'package:flutter_app/Model/subject_model.dart';
import 'package:http/http.dart' as http;

class ClassRoomScreen extends StatefulWidget {
  ClassRoomScreen(this.subjectsModel);
  SubjectsModel subjectsModel = new SubjectsModel();
  @override
  ClassRoomScreenState createState() => ClassRoomScreenState();
}

class ClassRoomScreenState extends State<ClassRoomScreen> {
  List<ClassRoomModel> classRoomModelList = [];
  bool isLoad = false;
  int currentClassRoomIndex = -1;
  @override
  void initState() {
    getClassRoomData();
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
                  "Classroom",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Container(
                    width: 95,
                    height: 40,
                    // color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.book_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                        Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 26,
                        ),
                      ],
                    ))),
            SizedBox(
              height: 35,
            ),
            Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                      color: Colors.white),
                  child: isLoad
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : null != classRoomModelList &&
                              classRoomModelList.length > 0
                          ? ListView.builder(
                              itemCount: classRoomModelList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: Padding(
                                      padding: EdgeInsets.all(13),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                              color:
                                                  currentClassRoomIndex == index
                                                      ? Colors.grey.shade300
                                                      : Colors.white,
                                              elevation: 2,
                                              child: Container(
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        currentClassRoomIndex ==
                                                                index
                                                            ? Colors
                                                                .grey.shade300
                                                            : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 20,),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [

                                                            Text(
                                                              "Name:  ",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Text(
                                                              classRoomModelList[
                                                                      index]
                                                                  .name!,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          classRoomModelList[
                                                                  index]
                                                              .layout
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ))),
                                        ],
                                      )),
                                  onTap: () {},
                                );
                              })
                          : Center(
                              child: Text("No classrooms found"),
                            )),
            )
          ],
        )));

    // TODO: implement build
    // throw UnimplementedError();
  }

  Future classRoomDetailDialogue(SubjectsModel subjectsModel) async {
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
                        "Classroom Details",
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Column(
                            // mainAxisAlignment:
                            // MainAxisAlignment
                            //     .spaceEvenly,
                            // crossAxisAlignment:
                            // CrossAxisAlignment
                            //     .start,
                            children: [
                              Text(
                                "Subject    : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Teacher   : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                null != subjectsModel.name!
                                    ? subjectsModel.name!
                                    : "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                null != subjectsModel.teacher.toString()
                                    ? subjectsModel.teacher.toString()
                                    : "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              // Text(
                              //   studentsModelList[
                              //   index]
                              //       .email!,
                              //   style: TextStyle(
                              //     fontWeight:
                              //     FontWeight
                              //         .bold,
                              //     fontSize: 16,
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "View Class ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF345FB4),
                        ),
                      ),
                    )
                  ],
                )
              ]);
        });
  }

  Future getClassRoomData() async {
    isLoad = true;
    String url =
        "https://hamon-interviewapi.herokuapp.com/classrooms/?api_key=126a5";
    var response = await http.get(Uri.parse(url));
    isLoad = false;
    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonData = jsonDecode(responseString);
      var data = jsonData['classrooms'];
      classRoomModelList = List<ClassRoomModel>.from(
          data.map((x) => ClassRoomModel.fromJson(x)));
      setState(() {});
    } else {
      return false;
    }
  }
}
