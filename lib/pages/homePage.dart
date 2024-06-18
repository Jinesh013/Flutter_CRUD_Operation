import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/pages/employeePage.dart';
import 'package:firebaseapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final CollectionReference = FirebaseFirestore.instance.collection("CRUDitems");

  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locatoincontroller = TextEditingController();

  Stream? EmployeeStream;

  getontheload() async {
    EmployeeStream = await DatabaseMethods().getEmployeeInfo();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshots) {
        return snapshots.hasData
            ? ListView.builder(
                itemCount: snapshots.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshots.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name : " + ds['name'],
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    editEmployeeDetails(ds['id']);
                                    namecontroller.text = ds['name'];
                                    agecontroller.text = ds['age'];
                                    locatoincontroller.text = ds['location'];
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: ()async {
                                      await DatabaseMethods().deleteEmployeeDetails(ds['id']);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.orange,
                                    )),
                              ],
                            ),
                            Text(
                              "Age : " + ds['age'],
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Location : " + ds['location'],
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Container();
      },
      stream: EmployeeStream,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.orange,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              " Firebase",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Column(
          children: [Expanded(child: allEmployeeDetails())],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Emplyee()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future editEmployeeDetails(String Id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel)),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.orange,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        " Details",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                    SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Age",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: agecontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                    SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Location",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: locatoincontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> updateInfo = {
                          "name": namecontroller.text,
                          "age": agecontroller.text,
                          "location": locatoincontroller.text,
                          "id": Id
                        };
                        await DatabaseMethods()
                            .updateEmployeeDetails(Id, updateInfo)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Update"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
