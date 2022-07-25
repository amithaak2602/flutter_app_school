import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/Model/student_model.dart';
import 'package:flutter_app/Model/subject_model.dart';
import 'package:flutter_app/screen/ClassRoomScreen.dart';
import 'package:http/http.dart' as http;

class SubjectsScreen extends StatefulWidget {
  @override
  SubjectsScreenState createState() => SubjectsScreenState();
}

class SubjectsScreenState extends State<SubjectsScreen> {
  List<SubjectsModel> subjectsModelList = [];
  bool isLoad = false;
  @override
  void initState() {
    getSubjects();
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
                "Subjects",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
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
                      : null != subjectsModelList &&
                              subjectsModelList.length > 0
                          ? ListView.builder(
                              itemCount: subjectsModelList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: EdgeInsets.all(13),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                            elevation: 2,
                                            child: Container(
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                child:  Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Name: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Credits : ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Teacher: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            subjectsModelList[
                                                                    index]
                                                                .name!,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            subjectsModelList[
                                                                    index]
                                                                .credits
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            subjectsModelList[
                                                                    index]
                                                                .teacher!,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )))
                                      ],
                                    ));
                              })
                          : Center(
                              child: Text("No students found"),
                            )),
            )
          ],
        )));

    // TODO: implement build
    // throw UnimplementedError();
  }

  Future getSubjects() async {
    isLoad = true;
    String url =
        "https://hamon-interviewapi.herokuapp.com/subjects/?api_key=126a5";
    var response = await http.get(Uri.parse(url));
    isLoad = false;
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
