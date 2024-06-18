import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods{

  Future addEmployeeDetails(Map<String,dynamic> employeeInfoMap, String id) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).set(employeeInfoMap);
  }


  Future<Stream<QuerySnapshot>> getEmployeeInfo()async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  } 

  Future updateEmployeeDetails(String id,Map<String,dynamic> updateInfo)async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).update(updateInfo);
  }

   Future deleteEmployeeDetails(String id)async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }

}