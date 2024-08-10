import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  //create loading indicator compinent
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.transparent,
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
