import 'package:flutter/material.dart';
import 'package:success_stations/styling/images.dart';
import 'package:success_stations/styling/string.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({ Key? key }) : super(key: key);

  @override
  _AboutTabState createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          detail(),
          Container(
            height:100,
            child: lastAds()),
          SizedBox(height: 20,),
          Container(
            height: 100,
            child: lastAds2()),
       ],
       ),
    );
  }
}

Widget detail(){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
        child: Card(
          child:Container(
            margin: EdgeInsets.all(20),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${AppString.details}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
              SizedBox(height:5),
              Text("AppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.detailsAppString.details",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.black),)
            ],
        ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 3),
        child: Card(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text("${AppString.namec}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("Ted library",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                    Text("${AppString.mobilec}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("+96-6xx-0061395",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                ],
              ),
              // SizedBox(width: 10,)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text("${AppString.emailc}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("admin@tedlibrary.net",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 15),
                  Text("${AppString.adress}:",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color: Colors.grey),),
                  SizedBox(height: 7),
                  Text("Jeddah,KSA",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  SizedBox(height: 10),
                  
                ],
               ),
              ],
            )
          ),
        ),
    ],
  );
}
Widget lastAds2(){
return ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: 6,
itemBuilder: (context, i) {
  return Container(
    margin: EdgeInsets.all(7),
    child:  ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight:  Radius.circular(20.0)),
      child: Column(
        children: [
         Expanded (child: Image.asset(AppImages.topImage,height: 100,)),
          Text("Junaid",style: TextStyle(color: Colors.red),),
        ],
      )
      ,
    ),
  );
 },
);
}

Widget lastAds(){
return ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: 6,
itemBuilder: (context, i) {
  return Column(
    children: [
      Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      )
    ],
  );
//   return Container(
//     margin: EdgeInsets.all(7),
//     child:  ClipRRect(
//       borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight:  Radius.circular(20.0)),
//       child: Column(
//         children: [
//          Expanded (child: Image.asset(AppImages.topImage,height: 100,)),
//           Text("Junaid",style: TextStyle(color: Colors.red),),
//         ],
//       )
//       ,
//     ),
//   );
//  },
});
}