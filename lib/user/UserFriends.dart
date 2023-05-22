import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookk/user/FriendProfile.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class UserFriends extends StatefulWidget {
  const UserFriends({Key? key}) : super(key: key);

  @override
  State<UserFriends> createState() => _UserFriendsState();
}

class _UserFriendsState extends State<UserFriends> {
  String nn = "Following";
  List<bool> fcount = [];
  String? uid = sharedPreference.getString("uid");

  void _load() {
    var a;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      height: double.infinity,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: size.width,
            child: Row(
              children: [
                Text(
                  "Friends",
                  style: TextStyle(fontSize: 29, fontWeight: FontWeight.w800),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                // ElevatedButton(onPressed: (){}, child: child)
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search, color: Colors.black, size: 30))
                    // ElevatedButton(onPressed: (){}, child: Icon(Icons.search,color: Colors.black,size:30),style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.white), ),)),
                    )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              color: Colors.blueAccent,
              child: Icon(
                Icons.person_add_alt_rounded,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Responds to friend requests",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 5, top: 5, right: 5),
            height: size.height - 280,
            width: size.width,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isNotEqualTo: uid)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text("No documents Occured"),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var a = snapshot.data!.docs[index];
                          List followers = a.get('followers') ?? [];
                          return Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              ListTile(
                                onTap: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FrientProfile(a.data()['uid'])));
                                },
                                leading: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                        width: 33,
                                        height: 33,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: a.get('url') != null
                                                ? Image.network(
                                                    a.get('url'),
                                                    fit: BoxFit.fill,
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                  )))),
                                title: Text(a.get('name')),
                                subtitle: Text("Kerala,India"),
                                trailing: followers.contains(uid)
                                    ? ElevatedButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(a.get('uid'))
                                              .update({
                                            "followers": FieldValue.arrayRemove(
                                                [uid.toString()]),
                                          });
                                        },
                                        child: Text("Following"))
                                    : ElevatedButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(a.get('uid'))
                                              .update({
                                            "followers": FieldValue.arrayUnion(
                                                [uid.toString()]),
                                          });
                                        },
                                        child: Text("Follow")),
                              ),
                            ],
                          );
                        });
                  }
                  return SizedBox(
                      height: 10,
                      width: 20,
                      child: CircularProgressIndicator());
                }),
          )
        ],
      ),
    );
  }
}
