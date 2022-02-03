import 'package:flutter/material.dart';
import 'package:success_stations/styling/colors.dart';

class CustomTextFiled extends StatefulWidget {
  final String hintText;
  final hintStyle;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final ValueChanged onFieldSubmitted;
  final FormFieldSetter<String> onSaved;
  final ValueChanged onChanged;
  final bool autoFocus;
  final validator;
  final contentPadding;
  Color? color = AppColors.inputColor2;
  final keyboardType;
  final maxLine;
  final obscureText;
  CustomTextFiled({
    this.hintText = '',
    required this.errorText,
    required this.isObscure,
    required this.textController,
    this.isIcon = true,
    this.padding = const EdgeInsets.only(left: 0),
    this.hintColor = Colors.black,
    this.iconColor = Colors.black,
    required this.onFieldSubmitted,
    required this.onChanged,
    this.autoFocus = true,
    required this.validator,
    required this.onSaved,
    this.hintStyle,
    this.contentPadding,
    this.obscureText,
    this.keyboardType,
    this.maxLine,
    this.color,
  });
  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Padding(
            padding: widget.padding,
            child: TextFormField(
              obscureText: widget.isObscure,
              maxLines: widget.maxLine,
              keyboardType: widget.keyboardType,
              style: TextStyle(color: AppColors.inputTextColor),
              focusNode: FocusNode(),
              controller: widget.textController,
              onFieldSubmitted: widget.onFieldSubmitted,
              onChanged: widget.onChanged,
              validator: widget.validator,
              // obscureText: widget.obscureText,
              onSaved: widget.onSaved,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: widget.contentPadding,
                  fillColor: widget.color,
                  filled: true,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: AppColors.outline,width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(color: AppColors.outline,width: 1.5),
                  ),
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle),
            ),
          ),
        ),
      ],
    );
  }
}
