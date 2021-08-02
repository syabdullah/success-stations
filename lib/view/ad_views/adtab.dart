import 'package:flutter/material.dart';
import 'package:success_stations/styling/images.dart';

class AdListTab extends StatefulWidget {
  const AdListTab({ Key? key }) : super(key: key);

  @override
  _AdListTabState createState() => _AdListTabState();
}

class _AdListTabState extends State<AdListTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:adList()
    );
  }
}

Widget adList() {
    return ListView.builder(
      itemCount: 10,
      // ignore: non_constant_identifier_names
      itemBuilder: (BuildContext,index) {
        return Card(
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        child: Padding(
                          padding:
                          const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                AppImages.profileBg
                              ),
                            ),
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title number 1',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight:FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 7),
                          Row(
                            children: [
                              Image.asset(AppImages.location, height:15),
                              Text("Jaddah",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(AppImages.location, height:15),
                                Text(
                                  "Al-Hajri",
                                  style: TextStyle(
                                    color: Colors.grey[300]
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: 
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.person)
                        ) 
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right:5),
                          child: Image.asset(AppImages.blueHeart, height: 20)
                        ),
                        Image.asset(AppImages.call, height: 20),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          );
        },
    );
  }