import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  String? uid=sharedPreference.getString("uid");
   // List Followers=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: size.height - 128,
            width: size.width,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('post').snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text("No document occured!!"),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var a = snapshot.data!.docs[index];
                         List Followers=[];

                         FirebaseFirestore.instance.collection("users").doc(a.data()['uid']).get().then((value) => Followers=value.data()!['followers']);

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {},
                                leading: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                        width: 33,
                                        height: 33,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: a.get('image') != null
                                                ? Image.network(
                                                    a.get('image'),
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    "asset/profile.jpeg",
                                                    fit: BoxFit.fill,
                                                  )))),
                                title: Text(a.get('name')),
                                subtitle: Text("Buenos Aires,Argentina"),
                               ),
                              AnimatedContainer(
                                  duration: Duration(seconds: 0),
                                  height: 350,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: a.get('content') != null
                                              ? Text(a.get('content'))
                                              : Text('')),
                                      a.get('url') != null
                                          ? Center(
                                              child: Container(
                                              width: double.infinity,
                                              child: Image.network(
                                                a.get('url'),
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                              // Image.asset("asset/image.jpeg",fit: BoxFit.fitHeight,)

                                              )
                                          : Visibility(child: Text(""))
                                    ],
                                  ))
                            ],
                          );
                        });
                  }
                  return Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
