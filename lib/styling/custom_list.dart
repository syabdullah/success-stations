import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    
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