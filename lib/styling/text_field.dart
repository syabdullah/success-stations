import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomTextFiled extends StatefulWidget {
  final Widget icon;
  final String hintText;
  // final String label;
  final hintStyle;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  // final TextInputType inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  // final double price;
  final Color hintColor;
  final Color iconColor;
  // final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final FormFieldSetter<String> onSaved;
  final ValueChanged onChanged;
  final bool autoFocus;
  // final TextInputAction inputAction;
  final FormFieldValidator validator;
  // final TextStyle style;
  final InputDecoration decoration;
  CustomTextFiled(
    {
      required this.icon,
      this.hintText ='',
      // required this.label,
      required this.errorText,
      required this.isObscure ,
      // required this.inputType,
      required this.textController,
      this.isIcon = true,
      this.padding = const EdgeInsets.all(0),
      this.hintColor = Colors.black,
      this.iconColor = Colors.black  ,
      // required this.focusNode,
      required this.onFieldSubmitted,
      required this.onChanged,
      this.autoFocus = false,
      // required this.inputAction,
      required this.validator,
      // this.style,
      // this.price,
      required this.decoration,
      required this.onSaved,
      this.hintStyle
    }
  );
  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
         padding: widget.padding,
          child: TextFormField(
            controller: widget.textController,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            validator: widget.validator,
            // style: widget.style,
            obscureText: widget.isObscure,
            onSaved: widget.onSaved,
            decoration: InputDecoration(
              
              // labelText: widget.label, 
              // suffixIcon: widget.icon,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle
            ),
          ),
        )
      ],
    );
  }
}