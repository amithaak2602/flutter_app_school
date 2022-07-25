import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/Model/classroom_model.dart';

import 'package:flutter_app/Model/student_model.dart';
import 'package:flutter_app/Model/subject_model.dart';
import 'package:flutter_app/screen/AppProvider.dart';
import 'package:flutter_app/screen/ClassViewScreen.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ClassRoomScreen extends StatefulWidget {

  @override
  ClassRoomScreenState createState() => ClassRoomScreenState();
}

class ClassRoomScreenState extends State<ClassRoomScreen>
    with SingleTickerProviderStateMixin {
  List<ClassRoomModel> classRoomModelList = [];
  List<SubjectsModel> subjectsModelList = [];
  SubjectsModel subjectsModel = new SubjectsModel();
  ClassRoomModel classRoomModel = new ClassRoomModel();
  TabController? tabController;
  bool isLoad = false;
  bool isLoadUpdateClassRoomList = false;
  int currentClassRoomIndex = -1;
  @override
  void initState() {
    getClassRoomData();
    getSubjects();
    tabController = new TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      setState(() {});
    });
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
                trailing: GestureDetector(
                          child: Icon(
                            Icons.book_outlined,
                            color: Colors.white,
                            size: 26,
                          ),
                          onTap: () {
                            SubjectDetailDialogue(subjectsModelList)
                                .then((value) {
                              if (null != value) {
                                subjectsModel = value!;
                                setState(() {});
                              }
                            });

                            setState(() {});
                          },
                        ),


                    ),
            SizedBox(
              height: 35,
            ),
            TabBar(controller: tabController, tabs: [
              Tab(
                text: "Class",
              ),
              Tab(
                text: "View",
              ),
            ]),
            Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(60),
                        //   topRight: Radius.circular(60),
                        // ),
                        color: Colors.white),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        isLoad
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
                                                        currentClassRoomIndex ==
                                                                index
                                                            ? Colors
                                                                .grey.shade300
                                                            : Colors.white,
                                                    elevation: 2,
                                                    child: Container(
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              currentClassRoomIndex ==
                                                                      index
                                                                  ? Colors.grey
                                                                      .shade300
                                                                  : Colors
                                                                      .white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 20,
                                                              ),
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
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    classRoomModelList[
                                                                            index]
                                                                        .name!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ))),
                                              ],
                                            )),
                                        onTap: () {
                                          if (subjectsModel.name == null) {
                                            EasyLoading.showToast(
                                                "Select a subject",
                                                duration: Duration(seconds: 3),
                                                toastPosition:
                                                    EasyLoadingToastPosition
                                                        .bottom);
                                          } else {
                                            classRoomAlertDialogue(
                                                subjectsModel,
                                                classRoomModelList[index].id!);
                                            setState(() {});
                                          }
                                        },
                                      );
                                    })
                                : Center(
                                    child: Text("No classrooms found"),
                                  ),
                        Consumer<ClassRoomProvider>(
                            builder: (context, classRoomProvider, child) {
                          return null !=
                                      classRoomProvider
                                          .selectedClassRoomModelList &&
                                  classRoomProvider
                                          .selectedClassRoomModelList.length >
                                      0
                              ? ListView.builder(
                                  itemCount: classRoomProvider
                                      .selectedClassRoomModelList.length,
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
                                                      currentClassRoomIndex ==
                                                              index
                                                          ? Colors.grey.shade300
                                                          : Colors.white,
                                                  elevation: 2,
                                                  child: Container(
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                        color: currentClassRoomIndex ==
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
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
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  classRoomProvider
                                                                      .selectedClassRoomModelList[
                                                                          index]
                                                                      .name!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Subject :  ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  classRoomProvider
                                                                      .selectedClassRoomModelList[
                                                                          index]
                                                                      .subject
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              classRoomProvider
                                                                  .selectedClassRoomModelList[
                                                                      index]
                                                                  .layout
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))),
                                            ],
                                          )),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ClassViewScreen(classRoomProvider
                                                        .selectedClassRoomModelList[
                                                    index])));
                                      },
                                    );
                                  })
                              : Center(
                                  child: Text("No data found"),
                                );
                        }),
                      ],
                    )))
          ],
        )));

    // TODO: implement build
    // throw UnimplementedError();
  }

  Future SubjectDetailDialogue(
      List<SubjectsModel> selectedSubjectModelList) async {
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
                        "Select a subject",
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
                    itemCount: selectedSubjectModelList.length,
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
                                  selectedSubjectModelList[position]
                                      .name
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          onTap: () {
                            Navigator.of(context)
                                .pop(selectedSubjectModelList[position]);
                          },
                        ),
                      );
                    },
                  ),
                )
              ]);
        });
  }

  Future classRoomAlertDialogue(
      SubjectsModel subjectsModel, int classRoomId) async {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                null != subjectsModel.name!.toString()
                                    ? subjectsModel.name!.toString()
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
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF345FB4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      onPressed: () {
                        Provider.of<ClassRoomProvider>(context, listen: false)
                            .updateClassRoom(subjectsModel.id!, classRoomId);
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text(
                        "Add subject",
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

  Future getSubjects() async {
    String url =
        "https://hamon-interviewapi.herokuapp.com/subjects/?api_key=126a5";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonData = jsonDecode(responseString);
      var data = jsonData['subjects'];
      subjectsModelList =
          List<SubjectsModel>.from(data.map((x) => SubjectsModel.fromJson(x)));
      setState(() {});
    } else {
      return false;
    }
  }
}
