import 'package:flutter_emoji/controller/emoji_controller.dart';
import 'package:get/instance_manager.dart';

class EmojiBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EmojiController>(EmojiController());
  }
}
