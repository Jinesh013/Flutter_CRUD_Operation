import 'package:firebaseapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Emplyee extends StatefulWidget {
  const Emplyee({super.key});

  @override
  State<Emplyee> createState() => _EmplyeeState();
}

class _EmplyeeState extends State<Emplyee> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locatoincontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Employee Details",
          style: TextStyle(
              fontSize: 22,
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _addEmployeeField(),
    );
  }

  Container _addEmployeeField() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Name",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: namecontroller,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Age",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: agecontroller,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Location",
            style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: locatoincontroller,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                String Id = randomAlphaNumeric(10);
                Map<String, dynamic> employeeInfoMap = {
                  "name": namecontroller.text,
                  "age": agecontroller.text,
                  "id" : Id,
                  "location": locatoincontroller.text
                };
                await DatabaseMethods()
                    .addEmployeeDetails(employeeInfoMap, Id)
                    .then((value) {
                  Fluttertoast.showToast(
                      msg: "Employee details has been added suceesfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
              child: const Text(
                "Add",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
