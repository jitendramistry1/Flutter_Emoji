import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/helper/json_converter_helper.dart';
import 'package:flutter_emoji/main.dart';
import 'package:flutter_emoji/models/emoji_model.dart';
import 'package:flutter_emoji/utils/assets_utils.dart';
import 'package:flutter_emoji/utils/sharedpreferences_utils.dart';
// import 'package:flutter_emoji/widgets/custom_snackbar_widget.dart';
// import 'package:flutter_emoji/services/emoji_service.dart';
import 'package:get/get.dart';

class EmojiController extends GetxController with GetTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  final emojiModel = <EmojiCategory>[].obs;
  late PageController pageController;
  late TabController tabController;
  final selectedEmoji = <EmojiItem>[].obs;
  final recentEmojiList = <String>[].obs;

  @override
  void onInit() async {
    pageController = PageController();
    tabController = TabController(length: 0, vsync: this);
    tabController.addListener(handleTabSelection);

    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void handleTabSelection() {
    if (!tabController.indexIsChanging) {
      pageController.animateToPage(
        tabController.index,
        duration: const Duration(milliseconds: 1),
        curve: Curves.bounceIn,
      );
    }
  }

  void handlePageSelection(int index) {
    if (index != tabController.index) {
      tabController.animateTo(index);
      refresh();
    }
  }

//Get Recenly used emojies from sharedPreferences
  Future<void> loadRecentEmojis() async {
    emojiModel.clear();
    recentEmojiList.clear();
    final List<String>? recentEmojis =
        prefs?.getStringList(Local.recentEmojiKey);
    if (recentEmojis != null) {
      recentEmojiList.addAll(recentEmojis.toSet().toList());
    }

    emojiModel.add(
      EmojiCategory(
        categoryName: "Frequently Used",
        emojiItems: recentEmojiList.isEmpty
            ? []
            : recentEmojiList
                .map((String? element) => EmojiItem(
                      description: "",
                      emoji: element,
                      index: "",
                      unicode: "",
                    ))
                .toList(),
      ),
    );
  }

//Function to add recently used imojies to sharedPreferences
  void addRecentEmoji(String emoji) async {
    if (recentEmojiList.contains(emoji)) {
      recentEmojiList.remove(emoji);
    } else if (recentEmojiList.length >= 10) {
      recentEmojiList.removeLast();
    }
    recentEmojiList.insert(0, emoji);
    await prefs?.setStringList(
      Local.recentEmojiKey,
      recentEmojiList.toList(),
    );
  }

//Function to get Emojies from server
  // Future<void> getEmojis() async {
  //   isLoading = true.obs;

  //   dynamic jsonList;

  //   update();

  //   try {
  //     final response = await EmojiService().getEmojis();
  //     if (response.ok) {
  //       jsonList = json.decode(response.data);
  //       await Future.delayed(const Duration(seconds: 1));
  //       await handleResponse(jsonList);
  //     } else {
  //       CustomSnackbar().error(response.message, 2);
  //     }

  //     isLoading = false.obs;
  //     update();
  //   } catch (e) {
  //     CustomSnackbar().error(e.toString(), 2);
  //     isLoading = false.obs;
  //     update();
  //   }
  // }

  Future<void> getEmojis() async {
    //Load json from asset
    final jsonString = await JsonConverterHelper().loadJson(Assets.emojiJson);
    final jsonList = jsonDecode(jsonString);
    await handleResponse(jsonList);
  }

//Convert json into categories based on the response in the JSON
  Future<void> handleResponse(jsonList) async {
    String? currentCategoryName;

    for (int i = 0; i < jsonList.length; i++) {
      if (jsonList[i].length == 1 && jsonList[i + 1].length == 1) {
        // Category found
        currentCategoryName = jsonList[i][0];
      } else if (currentCategoryName != null && jsonList[i].length > 1) {
        // Emoji item found
        if (emojiModel.isEmpty ||
            emojiModel.last.categoryName != currentCategoryName) {
          emojiModel.add(EmojiCategory.fromJson([
            [currentCategoryName]
          ]));
        }
        emojiModel.last.emojiItems.add(EmojiItem.fromJson(jsonList[i]));
      }
    }
    tabController = TabController(length: emojiModel.length, vsync: this);
    tabController.addListener(handleTabSelection);
  }
}
