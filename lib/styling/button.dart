
import 'package:flutter/material.dart';
import 'package:success_stations/styling/responsive.dart';
import 'package:success_stations/styling/string.dart';

class AppButton extends StatelessWidget {
  final  buttonText;
  final  callback;
  final  bgcolor;
  final image;
  final  textColor;
  final  fontFamily;
  final fontSize;
  final  width;
  final  fontStyle;
  final  height;
  final  borderRadius;
  final borderColor;
  final fontWeight;
  const AppButton(
      {
        key,
        this.buttonText,
        this.callback,
        this.bgcolor,
        this.image,
        this.textColor,
        this.width,
        this.fontStyle,
        this.fontFamily,
        required this.fontSize,
        this.fontWeight,
        this.height,
        this.borderColor,
        this.borderRadius = 8.0})

      : super(key: key
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: callback,
        child: Container(
            alignment: Alignment.center,
            width: width ?? ResponsizeSize.sizeWidth(context) * 0.9,
            height: height ?? 56,
            decoration: BoxDecoration(
                color: bgcolor ?? Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                border: Border.all(
                    color:borderColor ?? Colors.white
                )
            ),
            child:
            //  buttonText == AppString.signIn ?
            buttonText != AppString.facebook ?
            Container(
              margin:EdgeInsets.only(left:10),
              child: Text(
                buttonText,
                style: fontStyle ??TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize,
                  fontWeight : fontWeight,
                  fontFamily: fontFamily ?? 'SF Pro Text',
                ),
              ),
            )
                : Container(
                child: Image.asset(image,fit: BoxFit.contain,)
            )
        ),
      ),
    );
  }
}
class AppButton2 extends StatelessWidget {
  final  buttonText;
  final  callback;
  final  bgcolor;
  final image;
  final  textColor;
  final  fontFamily;
  final fontSize;
  final  width;
  final  fontStyle;
  final  height;
  final  borderRadius;
  final borderColor;
  final fontWeight;
  const AppButton2(
      {
        key,
        this.buttonText,
        this.callback,
        this.bgcolor,
        this.image,
        this.textColor,
        this.width,
        this.fontStyle,
        this.fontFamily,
        required this.fontSize,
        this.fontWeight,
        this.height,
        this.borderColor,
        this.borderRadius = 15.0})

      : super(key: key
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: callback,
        child: Container(
            alignment: Alignment.center,
            width: width ?? ResponsizeSize.sizeWidth(context) * 0.63,
            height: height ?? 52,
            decoration: BoxDecoration(
                color: bgcolor ?? Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                border: Border.all(
                    color:borderColor ?? Colors.white
                )
            ),
            child:
            //  buttonText == AppString.signIn ?
            buttonText != AppString.facebook ?
            Container(
              margin:EdgeInsets.only(left:10),
              child: Text(
                buttonText,
                style: fontStyle ??TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize,
                  fontWeight : fontWeight,
                  fontFamily: fontFamily ?? 'andada',
                ),
              ),
            )
                : Container(
                child: Image.asset(image,fit: BoxFit.contain,)
            )
        ),
      ),
    );
  }
}