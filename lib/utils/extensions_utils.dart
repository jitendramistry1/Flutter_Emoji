//

extension ConvertValues on String {
  //08:00 to 08:00
  String formatTime() {
    DateTime dateTime = DateTime.parse(this);
    String formattedDateTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedDateTime;
  }
}
