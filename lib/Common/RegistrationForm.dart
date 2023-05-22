import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookk/Common/LoginPage.dart';
import 'package:facebookk/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  var registration_key = new GlobalKey<FormState>();
  var regfnamecontroller = new TextEditingController();
  var regsnamecontroller = new TextEditingController();

  var regphonenumber = new TextEditingController();
  var emailcontroller = new TextEditingController();

  DateTime? dob;
  var pswrdcontroller = new TextEditingController();
  var cnfpswrdcontroller = new TextEditingController();
  var dobcontroller = new TextEditingController();

  var pswrdcheck;
  String gender = "Male";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Registration Form",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: Form(
          key: registration_key,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 300,
                        child: TextFormField(
                          controller: regfnamecontroller,
                          decoration: InputDecoration(
                              labelText: ' First Name',
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                              border: UnderlineInputBorder()),
                          validator: (value) {
                            if (value!.length < 3) {
                              return 'enter a valid name';
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 300,
                        child: TextFormField(
                          controller: regsnamecontroller,
                          decoration: InputDecoration(
                              labelText: ' Second Name',
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                              border: UnderlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter a valid name';
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          Radio(
                              value: "Male",
                              groupValue: gender,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  gender = value!;
                                });
                              }),
                          Text(
                            "Male",
                            style: TextStyle(
                              color: Colors.grey,
                              // fontWeight: FontWeight.w500
                            ),
                          ),
                          Radio(
                              value: "Female",
                              groupValue: gender,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  gender = value!;
                                });
                              }),
                          Text(
                            "Female",
                            style: TextStyle(
                              // fontSize: 19,
                              color: Colors.grey,
                              // fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 300,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                              border: UnderlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter a valid email';
                            }
                          },
                        )),
                    Container(
                        width: 300,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: pswrdcontroller,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.length < 8) {
                              return 'enter a valid password';
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 300,
                        child: TextFormField(
                          controller: cnfpswrdcontroller,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              border: UnderlineInputBorder()),
                          validator: (value) {
                            if (value != pswrdcontroller.text) {
                              return 'Password doesnot match';
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (registration_key.currentState!.validate()) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailcontroller.text.toString(),
                                  password: pswrdcontroller.text.toString())
                              .then((value) => FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(value.user!.uid)
                                      .set({
                                    "uid": value.user!.uid,
                                    "name": regfnamecontroller.text +
                                        " " +
                                        regsnamecontroller.text,
                                    "gender": gender,
                                    "email": emailcontroller.text,
                                    "password": pswrdcontroller.text,
                                    "followers": null,
                                    "url": null,
                                    "datetime": DateTime.now(),
                                  }))
                              .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content:
                                          Text("successfully registered"))))
                              .then((value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false));
                        }
                      },
                      child: Text('Register'),
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(250, 50))),
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
