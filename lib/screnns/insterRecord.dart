import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlemplyee/modelClass/employeeModel.dart';
import '../helperClass/db_helper.dart';
import 'dart:async';
import 'dart:io';
class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  String? name;
  String? lastName;
  String? designation;
  String? companyName;
  String? twitterId;
  String? whatsAppNumber;
  Image? picker;
  Uint8List? img;
  File? image;
  XFile? photo;
  var value;
  final ImagePicker _picker = ImagePicker();
  late Future<List<Employee>> fetchdata;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController twitterIdController = TextEditingController();
  TextEditingController whatsAppNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Insert Employee"),
        centerTitle: true,
      ),
      body:Form(
        key: globalKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              InkWell(
                child: img == null
                    ? const CircleAvatar(
                        radius: 60,
                        child: Text("Add Image"),
                      )
                    : ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48), // Image radius
                          child: Image.memory(
                            img!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                onTap: () async {
                  Get.bottomSheet(
                    Container(
                        height: 150,
                        color: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  photo = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  image = File(photo!.path);
                                  img = await image?.readAsBytes();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("open Camera")),
                            ElevatedButton(
                                onPressed: () async {
                                  photo = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  image = File(photo!.path);
                                  img = await image?.readAsBytes();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("open Gallery"))
                          ],
                        )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  );
                },
              ),
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your Name",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Name";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    name = val!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),TextFormField(
                controller: lastNameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your lastName",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter lastName";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    lastName = val!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: designationController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your designation",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter designation";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    designation = val!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),TextFormField(
                controller: companyNameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your companyName",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter companyName";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    companyName = val!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: twitterIdController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your twitterId",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter twitterId";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    twitterId = val!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),TextFormField(
                controller: whatsAppNumberController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your whatsAppNumber",
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter whatsAppNumber";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    whatsAppNumber = val!;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      nameController.clear();
                      lastNameController.clear();
                      designationController.clear();
                      companyNameController.clear();
                      twitterIdController.clear();
                      whatsAppNumberController.clear();
                      setState(() {
                        name = "";
                        lastName = "";
                        designation = "";
                        companyName="";
                        twitterId="";
                        whatsAppNumber="";
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: ()async{
                      if (globalKey.currentState!.validate()) {
                        (globalKey.currentState!.save());
                        Map<String, dynamic> data = {
                          'name': name,
                          'lastName':lastName,
                          'designation':designation,
                          'companyName':companyName,
                          'twitterId':twitterId,
                          'whatsAppNumber':whatsAppNumber,
                        };
                        Employee emp=Employee.formSql(data);
                        int idno = await DBHelper.dbHelper.insert(emp);
                        print("Id=>$idno");
                        setState(() {
                          DBHelper.dbHelper.fetchAllData();
                        });
                        Get.snackbar(
                          "GeeksforGeeks",
                          "Record Successful Insert $idno",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        nameController.clear();
                        lastNameController.clear();
                        designationController.clear();
                        companyNameController.clear();
                        twitterIdController.clear();
                        whatsAppNumberController.clear();
                        setState(() {
                          fetchdata = DBHelper.dbHelper.fetchAllData();
                          name = "";
                          lastName = "";
                          designation = "";
                          companyName="";
                          twitterId="";
                          whatsAppNumber="";
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Done"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
