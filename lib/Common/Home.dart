import 'package:facebookk/main.dart';
import 'package:facebookk/user/UserHome.dart';
import 'package:facebookk/user/UserNots.dart';
import 'package:facebookk/user/UserFriends.dart';
import 'package:facebookk/user/UserProfile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? name = sharedPreference.getString("name");
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ],
            title: Text(
              "facebook",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 27,
                  fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.home,
                )),
                Tab(icon: Icon(Icons.group)),
                Tab(icon: Icon(Icons.notifications)),
                Tab(
                  icon: Icon(Icons.person),
                )
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          body: TabBarView(
              children: [UserHome(), UserFriends(), UserNots(), UserProfile()]),
        ));
  }
}
