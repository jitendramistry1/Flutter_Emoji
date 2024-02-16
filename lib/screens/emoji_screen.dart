import 'package:flutter/material.dart';
import 'package:flutter_emoji/controller/emoji_controller.dart';
import 'package:flutter_emoji/models/emoji_model.dart';
import 'package:flutter_emoji/utils/colors_utils.dart';
import 'package:flutter_emoji/utils/font_utils.dart';
import 'package:flutter_emoji/widgets/custom_button.dart';
import 'package:get/get.dart';

class EmojiScreen extends GetView {
  const EmojiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<EmojiController>(builder: (controller) {
          if (controller.isLoading.value == true) {
            return const CircularProgressIndicator();
          } else {
            return _body(controller);
          }
        }),
      ),
    );
  }

  Widget _body(EmojiController controller) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Wrap(
              children: List.generate(
                controller.selectedEmoji.length,
                (index) {
                  return Text(controller.selectedEmoji[index].emoji ?? "");
                },
              ),
            ),
          ),
          _button(controller),
        ],
      );
    });
  }

  Widget _button(EmojiController controller) {
    if (controller.selectedEmoji.isEmpty) {
      return CustomButton(
        width: 200,
        btnName: 'Select emojis',
        bgColor: AppColors.primaryColor,
        textColor: AppColors.white,
        height: 48,
        fontsize: 16,
        callback: () async {
          await controller.loadRecentEmojis();
          await controller.getEmojis();

          if (controller.emojiModel.length > 1) {
            _bottomSheet(controller);
          }
        },
      );
    } else {
      return CustomButton(
        width: 200,
        btnName: 'Clear emojis',
        bgColor: AppColors.primaryColor,
        textColor: AppColors.white,
        height: 48,
        fontsize: 16,
        callback: () => controller.selectedEmoji.clear(),
      );
    }
  }

  void _bottomSheet(EmojiController controller) async {
    await Get.bottomSheet(
        isScrollControlled: true,
        Container(
            height: MediaQuery.of(Get.context!).size.height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: items(controller)));
  }

  Widget items(EmojiController controller) {
    return Obx(
      () => DefaultTabController(
        length: controller.emojiModel.length,
        animationDuration: const Duration(seconds: 0),
        child: Column(
          children: [
            _tabs(controller),
            _pageView(controller),
          ],
        ),
      ),
    );
  }

  Widget _tabs(EmojiController controller) {
    return Container(
      color: AppColors.lightGrey,
      child: TabBar(
        indicatorColor: AppColors.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.zero,
        isScrollable: true,
        controller: controller.tabController,
        labelColor: AppColors.black,
        unselectedLabelColor: AppColors.grey,
        tabs: controller.emojiModel
            .map((category) => Tab(
                  text: category.emojiItems.isEmpty
                      ? "?"
                      : category.emojiItems[0].emoji,
                ))
            .toList(),
      ),
    );
  }

  Widget _pageView(EmojiController controller) {
    return Expanded(
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.emojiModel.length,
        onPageChanged: (index) {
          controller.tabController.animateTo(index);
        },
        itemBuilder: (context, index) {
          final category = controller.emojiModel[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  category.categoryName,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: Fonts.bold,
                  ),
                ),
              ),
              Expanded(child: _subItems(controller, category))
            ],
          );
        },
      ),
    );
  }

  Widget _subItems(EmojiController controller, EmojiCategory category) {
    if (category.emojiItems.isEmpty) {
      return const Center(child: Text("No data found."));
    } else {
      return Scrollbar(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            childAspectRatio: 1,
          ),
          itemCount: category.emojiItems.length,
          itemBuilder: (context, idx) {
            final emoji = category.emojiItems[idx];
            return IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  controller.selectedEmoji.add(emoji);
                  controller.addRecentEmoji(emoji.emoji ?? "");
                },
                icon: Text(
                  emoji.emoji ?? "",
                  style: const TextStyle(fontSize: 20),
                ));
          },
        ),
      );
    }
  }
}
