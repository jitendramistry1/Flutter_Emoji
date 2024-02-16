import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Keyboard {
  // to hide the keyboard
  Future hide() async {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScopeNode currentFocus = FocusScope.of(Get.context!);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
