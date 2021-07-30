import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:success_stations/styling/colors.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';
import 'package:success_stations/styling/text_style.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({ Key? key }) : super(key: key);

  @override
  _LocationTabState createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          filter(),
          locationList(),
        ],
      )
      ),
    );
  }
}

Widget filter(){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.grey[300],
    ),
    width: Get.width/5,
    
    margin: EdgeInsets.only(left:10),
    padding: const EdgeInsets.all(8.0),
    child: Row(
     children: [ 
       Image.asset(AppImages.filter,height: 15,),
       SizedBox(width: 5),
       Text(AppString.filter,
         style: AppTextStyles.appTextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color:AppColors.darkgrey
        ) 
       )
       ],
    ),
  );
}
// Widget locationList(){
//   return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: 10,
//       // ignore: non_constant_identifier_names
//       itemBuilder: (BuildContext,index) {
//         return Container();
//   },
//   );
// }

Widget locationList() {
    return Container(
      height: Get.height,
      child: ListView.builder(
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
                                 borderRadius: BorderRadius.all(Radius.circular(10)),
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
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 15,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                Text(
                                  '(567)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight:FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Text("Zealot Utopia",
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                              
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:20),
                  PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (int item) => handleClick(item),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(value: 0, child: Text('Logout')),
                      PopupMenuItem<int>(value: 1, child: Text('Settings')),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: 
                  //       CircleAvatar(
                  //         backgroundColor: Colors.grey[200],
                  //         child: Icon(Icons.person)
                  //         ) 
                  //     ),
                  //     Row(
                  //       children: [
                  //         Container(
                  //           padding: EdgeInsets.only(right:5),
                  //           child: Image.asset(AppImages.blueHeart, height: 20)
                  //         ),
                  //         Image.asset(AppImages.call, height: 20),
                  //       ],
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
            );
          },
      ),
    );
  }
  void handleClick(int item) {
  switch (item) {
    case 0:
      break;
    case 1:
      break;
  }
}