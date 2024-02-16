class EmojiCategory {
  final String categoryName;
  final List<EmojiItem> emojiItems;

  EmojiCategory({
    required this.categoryName,
    required this.emojiItems,
  });

  factory EmojiCategory.fromJson(List<dynamic> json) {
    final categoryName = json[0][0];
    final emojiItems = <EmojiItem>[];
    for (int i = 1; i < json.length; i++) {
      if (json[i].length == 4) {
        emojiItems.add(EmojiItem.fromJson(json[i]));
      }
    }
    return EmojiCategory(categoryName: categoryName, emojiItems: emojiItems);
  }
}

class EmojiItem {
  final String? index;
  final String? unicode;
  final String? emoji;
  final String? description;

  EmojiItem({
    required this.index,
    required this.unicode,
    required this.emoji,
    required this.description,
  });

  factory EmojiItem.fromJson(List<dynamic> json) {
    return EmojiItem(
      index: json[0],
      unicode: json[1],
      emoji: json[2],
      description: json[3],
    );
  }
}
