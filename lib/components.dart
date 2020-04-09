import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String label;
  final dynamic value;

  TextOutput(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 5, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(this.value),
        ],
      ),
    );
  }
}
