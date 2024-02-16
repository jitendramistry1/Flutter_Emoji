import 'package:flutter_emoji/screens/emoji_screen.dart';
import 'package:flutter_emoji/utils/binding_utils.dart';
import 'package:get/get.dart';

class Routes {
  static const String emojiScreen = '/emojiScreen';
}

final getPages = [
  GetPage(
    name: Routes.emojiScreen,
    page: () => const EmojiScreen(),
    binding: EmojiBinding(),
    transition: Transition.fade,
  ),
];
