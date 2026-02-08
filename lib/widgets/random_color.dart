import 'dart:math';
import 'dart:ui';

class RandomColor {
 static const List<Color> taskColors = [
    Color(0xFF81C784), // أخضر (مثل Language Study)
    Color(0xFFFFB74D), // برتقالي (مثل Yoga Lesson)
    Color(0xFF64B5F6), // أزرق (مثل App Design)
    Color(0xFFBA68C8), // بنفسجي
    Color(0xFFF06292), // وردي
  ];
static Color getRandomColor() {
    return taskColors[Random().nextInt(taskColors.length)];
  }
}