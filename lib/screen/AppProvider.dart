 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/Model/classroom_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
 import 'package:http/http.dart' as http;
class ClassRoomProvider extends ChangeNotifier{
  List<ClassRoomModel> selectedClassRoomModelList = [];
  ClassRoomModel classRoomModel = new ClassRoomModel();



  Future updateClassRoom(int subjectId,classRoomId)async{

    String url = "https://hamon-interviewapi.herokuapp.com/classrooms/"+classRoomId.toString()+"?api_key=126a5";
    var map = new Map<String, dynamic>();
    map['subject'] = subjectId.toString();
    EasyLoading.show(status: "Please wait");
    final response = await http.patch(Uri.parse(url), body: map);


    if (response.statusCode == 200) {
      String responseString = response.body.toString();
      var jsonData = jsonDecode(responseString)  ;

      if(null!= selectedClassRoomModelList && selectedClassRoomModelList.length>0) {
        ClassRoomModel selectedClassRoomModel = new ClassRoomModel();
        selectedClassRoomModel.id = int.parse(jsonData['id'].toString());
        final index = selectedClassRoomModelList.indexWhere((data) =>
        data.id.toString() == selectedClassRoomModel.id .toString());
        if(index> -1  ){
          selectedClassRoomModelList[index].subject = int.parse(jsonData['subject'].toString());
          selectedClassRoomModelList[index].id = int.parse(jsonData['id'].toString());
          selectedClassRoomModelList[index].name = (jsonData['name'].toString());
          selectedClassRoomModelList[index].layout = (jsonData['layout'].toString());
          selectedClassRoomModelList[index].size= int.parse (jsonData['size'].toString());
          //selectedClassRoomModelList.add(list[index]);
        }else{
          classRoomModel = new ClassRoomModel();
          classRoomModel.subject = int.parse(jsonData['subject'].toString());
          classRoomModel.id = int.parse(jsonData['id'].toString());
          classRoomModel.name = (jsonData['name'].toString());
          classRoomModel.layout = (jsonData['layout'].toString());
          classRoomModel.size= int.parse (jsonData['size'].toString());
          selectedClassRoomModelList.add(classRoomModel);
        }
      } else{
        classRoomModel = new ClassRoomModel();
        classRoomModel.subject = int.parse(jsonData['subject'].toString());
        classRoomModel.id = int.parse(jsonData['id'].toString());
        classRoomModel.name = (jsonData['name'].toString());
        classRoomModel.layout = (jsonData['layout'].toString());
        classRoomModel.size= int.parse (jsonData['size'].toString());


        selectedClassRoomModelList.add(classRoomModel);
      }
        notifyListeners();
      EasyLoading.showSuccess("Classroom updated successfully ",duration: Duration(seconds: 3),);

    } else {
      EasyLoading.showInfo("Something went wrong");
    }
  }

}
