import 'package:facebookk/Common/Home.dart';
import 'package:facebookk/Common/RegistrationForm.dart';
import 'package:facebookk/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var reg_key = new GlobalKey<FormState>();
  var regpassword = new TextEditingController();
  var regemailcontroller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
                key: reg_key,
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: size.width,
                    ),
                    Text(
                      "facebook",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 100,
                      width: size.width,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        height: 140,
                        width: size.width - 100,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                minLines: null,
                                keyboardType: TextInputType.emailAddress,
                                controller: regemailcontroller,
                                decoration: InputDecoration(
                                    labelText: 'User Email',
                                    prefixIcon: Icon(
                                      Icons.email_rounded,
                                    ),
                                    border: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                validator: (value) {
                                  if (!(value!.contains("@"))) {
                                    return 'enter a valid email';
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: regpassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: ' Password',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                    ),
                                    border: UnderlineInputBorder()),
                                validator: (value) {
                                  if (!(value!.length <= 8)) {
                                    return 'enter a valid PASSWORD';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (reg_key.currentState!.validate()) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: regemailcontroller.text.trim(),
                                  password: regpassword.text.trim())
                              .then((value) => FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(value.user!.uid)
                                      .get()
                                      .then((value) {
                                    sharedPreference.setString(
                                        "uid", value.data()!['uid']);
                                    sharedPreference.setString(
                                        "name", value.data()!['name']);
                                    sharedPreference.setString(
                                        "gender", value.data()!['gender']);
                                    sharedPreference.setString(
                                        "email", value.data()!['email']);
                                    sharedPreference.setBool("log", true);
                                    // sharedPreference.setStringList("followers", value.data()!['followers']);
                                    //  sharedPreference.setString("url", value.data()!['url']);
                                  }))
                              .then((value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                  (route) => false));
                        }
                      },
                      child: Text("Login",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(250, 50))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationForm()),
                            (route) => false);
                      },
                      child: Text("Sign Up",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    )
                  ],
                ))),
      ),
    );
  }
}
