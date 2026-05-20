import 'package:flutter/material.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  bool validateForm(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }
}
