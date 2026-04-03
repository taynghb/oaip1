import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:characters/characters.dart';
import 'package:pr3/pr3.dart' as pr3;

void main(List<String> arguments) {
  final random = Random();
  var list = ["\u{1F619}", "\u{1F618}","\u{1F60E}", "\u{1F92F}", "\u{1F636}",  
  "\u{1F623}","\u{1F92C}","\u{1F62E}\u{200D}\u{1F4A8}","\u{1F635}\u{200D}\u{1F4AB}","\u{1F643}",  
  "\u{1F921}","\u{1F47D}","\u{1F479}","\u{1F437}","\u{1F441}\u{FE0F}","\u{1F9DE}\u{200D}\u{2642}\u{FE0F}", 
  "\u{1F9AD}","\u{1F388}", "\u{1F4CE}"];
  var randomEmoji = list[random.nextInt(list.length)];
  var moods = Mood.values;
  var randomMood = moods[random.nextInt(moods.length)];
  var randomEnergy = random.nextInt(10) +1;
  stdout.write("введите ваше имя: ");
  String name = stdin.readLineSync(encoding: utf8)!;
  print("Генерируем случайное настроение...");
  print("привет, $name!  Твое настроение: $randomEmoji ${randomMood.get()}, твоя энергия: $randomEnergy/10");
  print("\nЮникод эмодзи: ${unicodePoint(randomEmoji)}");

  stdout.write("хотите просмотреть сложные эмодзи? (да/нет): ");
  String choice = stdin.readLineSync(encoding: utf8)!;

  switch(choice){
    case "да":
    stdout.write("Введите комбинацию эмодзи: ");
    String choiceEmoji = stdin.readLineSync(encoding: utf8)!;
    print("Анализ строки: $choiceEmoji");
    print("16-битных единиц: ${choiceEmoji.length}");
    print("Кодовых точек: ${choiceEmoji.runes.length}");
    print("Реальных символов: ${(choiceEmoji.characters.length)}");
    printEmoji(choiceEmoji);
    break;
    case "нет":
    break;
  }

  print("Спасибо, приходите снова!");
}
enum Mood {
  happy,
  sad,
  angry,
  tired,
  doubtful,
  worried,
  confident,
  surprised,
  calm;

  String get() {
    switch (this) { 
      case Mood.happy:
        return "счастливый";
      case Mood.sad:
        return "грустный";
      case Mood.angry:
        return "злой";
      case Mood.tired:
        return "уставший";
      case Mood.doubtful:
        return "сомневающийся";
      case Mood.worried:
        return "взволнованный";
      case Mood.confident:
        return "уверенный";
      case Mood.surprised:
        return "удивленный";
      case Mood.calm:
        return "спокойный";
    }
  }
}

  String unicodePoint(String emoji) {
    int codePoint = emoji.runes.first;
    return 'U+${codePoint.toRadixString(16)}';
}
 void printEmoji(emoji){
  print("Подробный вывод юникода:");
  int index = 1;
  for (int rune in emoji.runes) {
    String one = rune.toRadixString(16);
      print("Символ $index: - U+$one");
    index++;
}
}