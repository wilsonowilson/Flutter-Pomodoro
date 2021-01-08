class TimeValidator {
  static bool isValid(String time) {
    return time.isNotEmpty && time.length <= 2 && int.tryParse(time) != 0;
  }
}
