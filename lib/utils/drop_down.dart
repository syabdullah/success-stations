
// import 'package:flutter/material.dart';

// class DropDownWidget extends StatefulWidget {
//   final data;
//   final Widget textWidget;
//   final List list;
//   final String hint;
//   final  ValueChanged onChanged;

//   DropDownWidget(
//     { 
//       required this.data, 
//       required this.textWidget,
//       required this.list, 
//       required this.hint,
//       required this.onChanged
//     }
//   );
//   @override
//   _CustomDropDown createState() => _CustomDropDown();
// }
//     @override
//     class _CustomDropDown extends State<DropDownWidget>{


//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8.0),
//           child: textWidget
//         ),
//         Container(
//           height: 40,
//           padding: EdgeInsets.only(left: 8),
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               width: 1, color: Colors.grey
//             )
//           ),
//            child: ValueListenableBuilder(
//             valueListenable: data,
//              builder: (ctx, value, child) => 
//              DropdownButtonHideUnderline(
//                 child: DropdownButton(
//                    items: list.map((val) {
//                      return new DropdownMenuItem(
//                       value: val.toString(),
//                       child: new Text(
//                         val,
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     );

//                    }).toList(),
//                     hint: Text(
//                       hint,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400
//                       ),
//                   ),
//                   onChanged: onChanged,

//                 )

//              )
//           )
//         )

//       ],
      
//     );

//     }
//   }
  

