import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/Model/student_model.dart';
import 'package:http/http.dart' as http;

class StudentsScreen extends StatefulWidget {
  @override
  StudentsScreenState createState() => StudentsScreenState();
}

class StudentsScreenState extends State<StudentsScreen> {
  List<StudentModel> studentsModelList = [];
  bool isLoadStudent = false;
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
                "Students",
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
                  child: isLoadStudent
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : null != studentsModelList &&
                              studentsModelList.length > 0
                          ? ListView.builder(
                              itemCount: studentsModelList.length,
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
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Row(
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
                                                            "Age   : ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Email: ",
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
                                                            studentsModelList[
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
                                                            studentsModelList[
                                                                    index]
                                                                .age
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            studentsModelList[
                                                                    index]
                                                                .email!,
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

  Future getStudentsData() async {
    isLoadStudent = true;
    String url =
        "https://hamon-interviewapi.herokuapp.com/students/?api_key=126a5";
    var response = await http.get(Uri.parse(url));
    isLoadStudent = false;
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
