import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class ShowModal {
  showLoading(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingIndicator();
        });
  }
}
