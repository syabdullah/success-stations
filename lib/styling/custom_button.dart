  //Create a Stateless or Stateful Class
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  //declare Required Vairables
  final String ? buttonText;
  final VoidCallback ? onPressed;
  final bool  ? loading;

  //constructor 
  CustomButton({this.buttonText,this.onPressed,this.loading});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)),
              color: Colors.red),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  splashColor: Colors.green,
                  onTap: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(child:
                    loading==true?
                        CircularProgressIndicator(backgroundColor: Colors.white,)
                        :
                    Text( buttonText!,style: TextStyle(fontSize: 30,color: Colors.white),)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


}
