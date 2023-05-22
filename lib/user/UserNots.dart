import 'package:flutter/material.dart';

class UserNots extends StatefulWidget {
  const UserNots({Key? key}) : super(key: key);

  @override
  State<UserNots> createState() => _UserNotsState();
}

class _UserNotsState extends State<UserNots> {
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
                  "Notifications",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
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
          Container(
            padding: EdgeInsets.only(left: 5, top: 5, right: 5),
            height: size.height - 210,
            width: size.width,
            child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                          onTap: () {},
                          leading: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        "asset/model2.jpeg",
                                        fit: BoxFit.fill,
                                      )))),
                          title: Text("Sharaf k posted 2 new posts"),
                          subtitle: Text("Tuesday at 11.30 AM"),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.black,
                              ))),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
