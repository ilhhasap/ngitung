import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final fontWeight;
  final String buttonText;
  final String fontFamily;
  final double textSize;
  final buttonClicked, buttonPressed;

  MyButton(
      {this.color,
      this.textColor,
      this.buttonText,
      this.fontFamily,
      this.textSize,
      this.fontWeight,
      this.buttonClicked,
      this.buttonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonClicked,
      onLongPress: buttonPressed,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              color: color,
              child: Center(
                  child: Text(
                buttonText,
                style: TextStyle(
                    color: textColor,
                    fontFamily: fontFamily,
                    fontSize: textSize,
                    fontWeight: fontWeight),
              )),
            )),
      ),
    );
  }
}