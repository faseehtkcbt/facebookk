import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookk/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:group_button/group_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

dynamic a;

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

XFile? _postimg;

class _UserProfileState extends State<UserProfile> {
  var registration_key = new GlobalKey<FormState>();
  var regfnamecontroller = new TextEditingController();
  var regsnamecontroller = new TextEditingController();
  String? uid = sharedPreference.getString("uid");
  var regphonenumber = new TextEditingController();
  var emailcontroller = new TextEditingController();
  String gender = "Male";
  DateTime? dob;
  var pswrdcontroller = new TextEditingController();
  var imgurl = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  // For pick Image
  XFile? _image;
  int h=0;
  // For accept Null:-?

  var imageurl;

  @override
  void initState() {
    uid = sharedPreference.getString("uid");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      height: double.infinity,
      width: size.width,
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where('uid', isEqualTo: uid.toString())
              .snapshots(),
          builder: (_, snapshot) {


            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No document occured"));
            } else if (snapshot.hasData) {
              int? i;
              a = snapshot.data!.docs[0];

              String g = a.get('gender');
              gender = g;
              print(g);
              if (g == "Male") {
                i = 0;
                gender = g;
              } else {
                i = 1;
              }
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 190,
                      child: Stack(
                        children: [
                          Container(
                              height: 150,
                              width: size.width,
                              child: Image.asset(
                                "asset/background.jpeg",
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            bottom: 0.0,
                            left: 15.0,
                            child: SizedBox(
                              height: 130,
                              width: 130,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: _image != null
                                    ? Image.file(
                                        File(_image!.path),
                                        fit: BoxFit.cover,
                                      )
                                    : snapshot.data!.docs[0]['url'] == null
                                        ? Image.asset("asset/model.jpeg",
                                            fit: BoxFit.cover)
                                        : Image.network(
                                            snapshot.data!.docs[0]['url'],
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 5.0,
                              left: 110.0,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      showimage(
                                          snapshot.data!.docs[0]['uid']
                                              .toString(),
                                          context);
                                    },
                                    icon: Icon(Icons.camera_alt)),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          a.get('name') ?? " ",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.w800),
                        )),
                    Container(
                      height: 40,
                      width: size.width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blueAccent)),
                                onPressed: () {},
                                child:
                                    // Text("+ Add to Story")),
                                    TextButton.icon(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10))),
                                              builder: (context) {
                                                return BottomSheet(
                                                    onClosing: () {},
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20))),
                                                    builder: (context) {
                                                      return PostImage();
                                                    });
                                              });
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                        label: Text("Create new Post",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17)))),
                          ),

                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.grey)),
                                onPressed: () {},
                                child: TextButton.icon(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: 350,
                                              width: size.width,
                                              child: Form(
                                                  key: registration_key,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                            width: 350,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  regfnamecontroller,
                                                              decoration:
                                                                  InputDecoration(
                                                                      labelText:
                                                                          a.get(
                                                                              'name'),
                                                                      prefixIcon:
                                                                          Icon(
                                                                        Icons
                                                                            .person,
                                                                      ),
                                                                      border:
                                                                          UnderlineInputBorder()),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                        .length <
                                                                    3) {
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 25,
                                                              ),
                                                              Text(
                                                                "Gender",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        19,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                width: 60,
                                                              ),
                                                              GroupButton(
                                                                controller:
                                                                    GroupButtonController(
                                                                        selectedIndex:
                                                                            i),
                                                                isRadio: true,
                                                                buttons: [
                                                                  "Male",
                                                                  "Female"
                                                                ],
                                                                onSelected: (value,
                                                                    index,
                                                                    selected) {
                                                                  gender =
                                                                      value;
                                                                  i = index;
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                            width: 350,
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .emailAddress,
                                                              controller:
                                                                  emailcontroller,
                                                              decoration:
                                                                  InputDecoration(
                                                                      labelText:
                                                                          a.get(
                                                                              'email'),
                                                                      prefixIcon:
                                                                          Icon(
                                                                        Icons
                                                                            .email,
                                                                      ),
                                                                      border:
                                                                          UnderlineInputBorder()),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'enter a valid email';
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
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            if (registration_key
                                                                    .currentState !=
                                                                null) {
                                                              if (registration_key
                                                                  .currentState!
                                                                  .validate()) {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(a.get(
                                                                        'uid'))
                                                                    .update({
                                                                      "name": regfnamecontroller
                                                                          .text,
                                                                      "gender":
                                                                          gender,
                                                                      "email":
                                                                          emailcontroller
                                                                              .text
                                                                    })
                                                                    .then((value) => ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(SnackBar(
                                                                            content: Text(
                                                                                "Successfully changed"))))
                                                                    .then((value) =>
                                                                        Navigator.pop(
                                                                            context));
                                                              }
                                                            }
                                                          },
                                                          child: Text('Change'),
                                                          style: ButtonStyle(
                                                              fixedSize:
                                                                  MaterialStateProperty
                                                                      .all(Size(
                                                                          350,
                                                                          50))),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ))),
                          ),

                          // Container(
                          //   child:IconButton(onPressed: () {  }, icon: Icon(Icons.mo),
                          //
                          //   ) ,
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      height: 30,
                      width: size.width,
                      child: Row(
                        children: [
                          Icon(
                            Icons.home_rounded,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Current city",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      height: 30,
                      width: size.width,
                      child: Row(
                        children: [
                        h==0? AnimatedContainer(duration:Duration(seconds: 3),
                          child:  Icon(
                            Icons.work,
                            color: Colors.blue,
                            size: 25,
                          ),
                          curve: Curves.linear,
                          onEnd: (){
                            setState(() {
                              h=1;

                            });
                          },):AnimatedContainer(duration:Duration(seconds: 3),
                          child:  Icon(
                            Icons.work,
                            color: Colors.black,
                            size: 25,
                          ),
                         ),
                          SizedBox(
                            width: 10,
                          ),
                         h==1? AnimatedContainer(
                            duration: Duration(seconds: 3),
                            child: Text(
                              "Work Place",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500,
                              color: Colors.blue),
                            ),
                            curve: Curves.linear,
                            onEnd: (){
                              setState(() {
                                h=0;

                              });
                            },
                          ):
                         AnimatedContainer(
                           duration: Duration(seconds: 3),
                           child: Text(
                             "Work Place",
                             style: TextStyle(
                                 fontSize: 20, fontWeight: FontWeight.w500,
                                 color: Colors.black),
                           ),


                         )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      height: 30,
                      width: size.width,
                      child: Row(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "School",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      height: 30,
                      width: size.width,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "HomeTown",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      height: 30,
                      width: size.width,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Icon(Icons.more_horiz),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "See more about yourself",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Friends",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.grey,
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 140,
                      width: size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(120),
                                    child: Image.asset(
                                      "asset/image.jpeg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Aguero",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            );
                          }),
                    ),
                    Text(
                      "Posts",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      height: 580,
                      width: size.width,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('post')
                              .where('uid', isEqualTo: uid.toString())
                              .snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text("No document occured!!"),
                              );
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var a = snapshot.data!.docs[index];
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          onTap: () {},
                                          leading: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: SizedBox(
                                                  width: 33,
                                                  height: 33,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: a.get('image') !=
                                                              null
                                                          ? Image.network(
                                                              a.get('image'),
                                                              fit: BoxFit.fill,
                                                            )
                                                          : Image.asset(
                                                              "asset/profile.jpeg",
                                                              fit: BoxFit.fill,
                                                            )))),
                                          title: Text(a.get('name')),
                                          subtitle:
                                              Text("Buenos Aires,Argentina"),
                                          trailing: ElevatedButton(
                                              onPressed: () {},
                                              child: Text("Follow")),
                                        ),
                                        AnimatedContainer(
                                            duration: Duration(seconds: 0),
                                            height: 350,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: a.get('content') !=
                                                            null
                                                        ? Text(a.get('content'))
                                                        : Text('')),
                                                a.get('url') != null
                                                    ? Center(
                                                        child: Container(
                                                        height: 200,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.network(
                                                            a.get('url'),
                                                          ),
                                                        ),
                                                      )
                                                        // Image.asset("asset/image.jpeg",fit: BoxFit.fitHeight,)

                                                        )
                                                    : Visibility(
                                                        child: Text(""))
                                              ],
                                            ))
                                      ],
                                    );
                                  });
                            }
                            return CircularProgressIndicator(
                              color: Colors.blue,
                            );
                          }),
                    )
                  ]);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  _imagefromgallery(String? id) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    String fileName = DateTime.now().toString();
    var ref = FirebaseStorage.instance.ref().child("events/$fileName");
    UploadTask uploadTask = ref.putFile(File(_image!.path));

    uploadTask.then((res) async {
      imageurl = (await ref.getDownloadURL()).toString();
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'url': imageurl}).then((value) => print("Uploaded"));
    });
  }

  _imagefromcamera(String? id) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
    String fileName = DateTime.now().toString();
    var ref = FirebaseStorage.instance.ref().child("events/$fileName");
    UploadTask uploadTask = ref.putFile(File(_image!.path));

    uploadTask.then((res) async {
      imageurl = (await ref.getDownloadURL()).toString();
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'url': imageurl}).then((value) => print("Uploaded"));
    });
  }

  showimage(String? id, BuildContext context) {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromcamera(id.toString());
                          },
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.purple,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromgallery(id.toString());
                          },
                          icon: Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

var posturl;
final ImagePicker _postpicker = ImagePicker();

class PostImage extends StatefulWidget {
  const PostImage({Key? key}) : super(key: key);

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  var posttext = new TextEditingController();
  showpostimage(BuildContext context) {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            print("k");
                            _imagepostfromcamera();
                          },
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.purple,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            print("k");
                            _imagepostfromgallery();
                          },
                          icon: Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imagepostfromgallery() async {
    final XFile? image =
        await _postpicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _postimg = image;
      print("hello");
    });
    String fileName = DateTime.now().toString();
    var ref = FirebaseStorage.instance.ref().child("events/$fileName");
    UploadTask uploadTask = ref.putFile(File(_postimg!.path));
    // print((await ref.getDownloadURL()).toString());
    uploadTask
        .then((res) async => print((await ref.getDownloadURL()).toString()));

    setState(() {
      uploadTask.then((res) async {
        posturl = (await ref.getDownloadURL()).toString();
      }).then((value) => print("uploaded"));
    });
  }

  _imagepostfromcamera() async {
    final XFile? photo =
        await _postpicker.pickImage(source: ImageSource.camera);
    setState(() {
      _postimg = photo;
    });
    String fileName = DateTime.now().toString();
    var ref = FirebaseStorage.instance.ref().child("events/$fileName");
    UploadTask uploadTask = ref.putFile(File(_postimg!.path));

    uploadTask.then((res) async {
      posturl = (await ref.getDownloadURL()).toString();
    }).then((value) => value == null ? print("hh") : print("hkkk"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 500,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Create Yourown Post ",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                )),
          ),
          Container(
            height: 290,
            width: size.width,
            child: SingleChildScrollView(
              child: Container(
                height: 250,
                width: size.width,
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        minLines: null,
                        maxLines: null,
                        expands: true,
                        controller: posttext,
                        decoration: InputDecoration(
                            hintText: "Whats on your mind??",
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 200,
                      child: InkWell(
                          onTap: () {
                            showpostimage(context);
                          },
                          child: _postimg != null
                              ? Image.file(
                                  File(_postimg!.path),
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Icon(Icons.camera),
                                )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('post')
                    .doc(DateTime.now().toString())
                    .set({
                  "uid": a.get('uid'),
                  "name": a.get('name'),
                  "image": a.get('url'),
                  "content": posttext.text.trim(),
                  "url": posturl,
                  "date": DateTime.now()
                });
                print("Uploaded");
              },
              child: Text("Add Post",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(size.width, 50))),
            ),
          ),
        ],
      ),
      // color: Colors.black,
    );
  }
}
