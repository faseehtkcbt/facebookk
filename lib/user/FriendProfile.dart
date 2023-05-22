import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookk/main.dart';
import 'package:flutter/material.dart';
String? fauid;
class FrientProfile extends StatefulWidget {
   FrientProfile( String? auid,{Key? key}) : super(key: key){
     fauid=auid;
   }

  @override
  State<FrientProfile> createState() => _FrientProfileState();
}

class _FrientProfileState extends State<FrientProfile> {
  String? uid=sharedPreference.getString('uid');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream:FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: fauid.toString()).snapshots() ,
              builder:(_,snapshot) {

                if(snapshot.hasData && snapshot.data!.docs.isEmpty){
                  return Center(
                    child: Text("No documents occured"),
                  );
                }
                else if (snapshot.hasData){
                  var a=snapshot.data!.docs;
                  String? fuid=a[0].data()['uid'];
                  List followers = a[0].get('followers') ?? [];
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
                                    child: a[0].get('url') !=
                                        null
                                        ? Image.network(
                                      a[0].get('url'),
                                      fit: BoxFit.cover,
                                    )
                                        : Image.asset(
                                      "asset/profile.jpeg",
                                      fit: BoxFit.cover,


                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              a[0].get('name') ?? " ",
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.w800),
                            )),
                        Container(
                          height: 40,
                          width: size.width,
                          child: Row(
                            children: [


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
                              Icon(
                                Icons.work,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Work Place",
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

                          height: 30,
                          width: size.width,
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Icon(Icons.more_horiz),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Friends",
                            style:
                            TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                          ),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Posts",
                            style:
                            TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                          ),
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
                                  .where('uid',isEqualTo: fauid.toString())
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
                                                          width:double.infinity,


                                                          child: Image.network(
                                                            a.get('url'),
                                                            fit: BoxFit.contain,
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
                return Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
