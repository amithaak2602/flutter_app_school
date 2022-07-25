import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/classroom_model.dart';

import 'package:flutter_app/Model/student_model.dart';
import 'package:flutter_app/Model/subject_model.dart';
import 'package:flutter_app/screen/ClassRoomScreen.dart';
import 'package:http/http.dart' as http;

class ClassViewScreen extends StatefulWidget {
  ClassViewScreen(this.classRoomModel);
  ClassRoomModel classRoomModel = new ClassRoomModel();

  @override
  ClassViewScreenState createState() => ClassViewScreenState();
}

class ClassViewScreenState extends State<ClassViewScreen> {
  List<StudentModel> studentsModelList = [];
  List<StudentModel> selectedStudentsModelList = [];

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
                    "Classroom view",
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
                      studentDetailDialogue(studentsModelList)
                          .then((value) {
                        if (null != value) {

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
                Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(60),
                      //       topRight: Radius.circular(60),
                      //     ),
                      color: Colors.white,
                    child:Column(
                      children: [
                        SizedBox(height: 10,),
                        Text("Subject: "+widget.classRoomModel.subject.toString(), style: TextStyle(
                          fontWeight:
                          FontWeight
                              .bold,
                          fontSize: 16,
                        ),),
                        widget.classRoomModel.layout.toString() =="classroom" ?GridView.builder(
                          padding: EdgeInsets.all(12),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 4,
                          ),
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: selectedStudentsModelList.length,
                          itemBuilder: (context, index) {
                            return Card(
                                elevation: 0,
                                color: Colors.grey[200],
                                child: Center(
                                  child: Text(
                                    selectedStudentsModelList[index].name.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),


                            );
                          },
                        ):GridView.builder(
                          padding: EdgeInsets.all(12),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                  ),
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedStudentsModelList.length,
                  itemBuilder: (context, index) {
                  return Card(
                        elevation: 0,
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            selectedStudentsModelList[index].name.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),


                    );
                  },
                )
                      ],
                    )

    ),
                )
              ],
            )));

    // TODO: implement build
    // throw UnimplementedError();
  }

  Future studentDetailDialogue(
      List<StudentModel> studentModelList) async {
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
                        "Select a student",
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
                                  studentModelList[position]
                                      .name
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          onTap: () {
                            Navigator.of(context)
                                .pop(studentModelList[position]);
                            selectedStudentsModelList.add(studentModelList[position]);
                            setState(() {

                            });
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


}
