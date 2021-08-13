import 'package:flutter/material.dart';

class CustomListTiles extends StatelessWidget {
  const CustomListTiles({
    
    required this.title,
    this.tralling,
  });
  final Widget title;
  final tralling;
  @override
  Widget build(BuildContext context){
    return ListTile(
      title: title,
      trailing: tralling,
    );
  }
}