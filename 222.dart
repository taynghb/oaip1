import 'dart:io';

void main(List<String> arguments) {
  List<String> students_list = ["Стецко Таня", "Михеева Мария", "Косаревская Настя", "Каврус Алина", "Кабанов Миша",
"Гусаков Дима"];

  List<String> subjects_list = ["опбд", "оаип", "тестирование", "бжд"];
  Map<String, Map<String, int>> grade_journal = {
    "Стецко Таня": {
      subjects_list[0]: 5,
      subjects_list[1]: 5,
      subjects_list[2]: 5,
      subjects_list[3]: 5
    },
    "Косаревская Настя": {
      subjects_list[0]: 3,
      subjects_list[1]: 4,
      subjects_list[2]: 3,
      subjects_list[3]: 5
    },
    "Каврус Алина": {
      subjects_list[0]: 4,
      subjects_list[1]: 5,
      subjects_list[2]: 5,
      subjects_list[3]: 5
    },
    "Михеева Мария": {
      subjects_list[0]: 5,
      subjects_list[1]: 5,
      subjects_list[2]: 5,
      subjects_list[3]: 5
    },
    "Кабанов Миша": {
      subjects_list[0]: 3,
      subjects_list[1]: 4,
      subjects_list[2]: 3,
      subjects_list[3]: 4
    },
    "Гусаков Дима": {
      subjects_list[0]: 2,
      subjects_list[1]: 4,
      subjects_list[2]: 2,
      subjects_list[3]: 3
    }
  };

  Map<String, double> student_averages = {};

  for (String student in students_list) {
    Map<String, int> student_grades = grade_journal[student]!;
    int sum = 0;
    for (String subject in subjects_list) {
      sum += student_grades[subject]!;
    }
    student_averages[student] = sum / subjects_list.length;
  }

  int choice;

  do {
    print("1. Категории студентов по среднему баллу");
    print("2. Статистика оценок (сколько раз встречается каждая оценка)");
    print("3. Студенты с оценкой 5 по каждому предмету");
    print("4. Предметы без двоек");
    print("5. Предмет с наибольшим количеством двоек");
    print("6. Студенты с наибольшим количеством пятерок");
    print("7. Предметы с оценкой ниже 4 для каждого студента");
    print("8. Все пары студент-предмет с оценкой 5");
    print("0. Выход");
    stdout.write("Выберите пункт: ");

    choice = int.parse(stdin.readLineSync()!);
    print("");

    switch (choice) {
      case 1:
        show_categories(students_list, student_averages);
        break;
      case 2:
        show_grade_statistics(students_list, subjects_list, grade_journal);
        break;
      case 3:
        show_students_with_fives(students_list, subjects_list, grade_journal);
        break;
      case 4:
        show_subjects_without_twos(students_list, subjects_list, grade_journal);
        break;
      case 5:
        show_subject_with_most_twos(students_list, subjects_list, grade_journal);
        break;
      case 6:
        show_students_with_most_fives(students_list, subjects_list, grade_journal);
        break;
      case 7:
        show_subjects_below_four(students_list, subjects_list, grade_journal);
        break;
      case 8:
        show_all_five_pairs(students_list, subjects_list, grade_journal);
        break;
      case 0:
        print("Выход из программы...");
        break;
      default:
        print("Неверный выбор. Попробуйте снова.");
    }

    if (choice != 0) {
      print("\nНажмите Enter для продолжения...");
      stdin.readLineSync();
    }

  } while (choice != 0);
}

void show_categories(List<String> students_list, Map<String, double> student_averages) {

  List<String> excellent = [];
  List<String> good = [];
  List<String> other = [];

  for (String student in students_list) {
    double avg = student_averages[student]!;

    if (avg >= 4.5) {
      excellent.add(student);
    } else if (avg >= 3.5) {
      good.add(student);
    } else {
      other.add(student);
    }
  }

  print("отличники: ");
  if (excellent.isEmpty) {
    print("  Нет");
  } else {
    excellent.forEach((s) => print("  $s (${student_averages[s]!.toStringAsFixed(2)})"));
  }

  print("\nхорошисты:");
  if (good.isEmpty) {
    print("  Нет");
  } else {
    good.forEach((s) => print("  $s (${student_averages[s]!.toStringAsFixed(2)})"));
  }

  print("\nнеучи:");
  if (other.isEmpty) {
    print("  Нет");
  } else {
    other.forEach((s) => print("  $s (${student_averages[s]!.toStringAsFixed(2)})"));
  }
}

void show_grade_statistics(List<String> students_list, List<String> subjects_list, 
 Map<String, Map<String, int>> grade_journal) {

  Map<int, int> grade_count = {2: 0, 3: 0, 4: 0, 5: 0};

  for (String student in students_list) {
    Map<String, int> student_grades = grade_journal[student]!;
    for (String subject in subjects_list) {
      int grade = student_grades[subject]!;
      grade_count[grade] = grade_count[grade]! + 1;
    }
  }

  print("Оценка 2: ${grade_count[2]} раз(а)");
  print("Оценка 3: ${grade_count[3]} раз(а)");
  print("Оценка 4: ${grade_count[4]} раз(а)");
  print("Оценка 5: ${grade_count[5]} раз(а)");

  int total = grade_count[2]! + grade_count[3]! + grade_count[4]! + grade_count[5]!;
  print("Всего оценок: $total");
}

void show_students_with_fives(List<String> students_list, List<String> subjects_list, 
Map<String, Map<String, int>> grade_journal) {

  for (String subject in subjects_list) {
    List<String> students_with_five = [];

    for (String student in students_list) {
      if (grade_journal[student]![subject] == 5) {
        students_with_five.add(student);
      }
    }

    print("$subject (${students_with_five.length} чел.):");
    if (students_with_five.isEmpty) {
      print("  Нет студентов с оценкой 5");
    } else {
      students_with_five.forEach((s) => print("  $s"));
    }
    print("");
  }
}

void show_subjects_without_twos(List<String> students_list, List<String> subjects_list, 
Map<String, Map<String, int>> grade_journal) {


  List<String> subjects_without_twos = [];

  for (String subject in subjects_list) {
    bool has_two = false;

    for (String student in students_list) {
      if (grade_journal[student]![subject] == 2) {
        has_two = true;
        break;
      }
    }

    if (!has_two) {
      subjects_without_twos.add(subject);
    }
  }

  if (subjects_without_twos.isEmpty) {
    print("Нет предметов без двоек");
  } else {
    print("Предметы без двоек:");
    subjects_without_twos.forEach((s) => print("  $s"));
  }
}

void show_subject_with_most_twos(List<String> students_list, List<String> subjects_list, 
Map<String, Map<String, int>> grade_journal) {


  Map<String, int> twos_count = {};

  for (String subject in subjects_list) {
    int count = 0;
    for (String student in students_list) {
      if (grade_journal[student]![subject] == 2) {
        count++;
      }
    }
    twos_count[subject] = count;
  }

  String worst_subject = '';
  int max_twos = 0;

  twos_count.forEach((subject, count) {
    if (count > max_twos) {
      max_twos = count;
      worst_subject = subject;
    }
  });

  if (max_twos == 0) {
    print("Двоек нет ни по одному предмету");
  } else {
    print("$worst_subject — $max_twos двоек");
  }
}

void show_students_with_most_fives(List<String> students_list, List<String> subjects_list, 
Map<String, Map<String, int>> grade_journal) {

  Map<String, int> fives_count = {};
  int max_fives = 0;

  for (String student in students_list) {
    int count = 0;
    Map<String, int> student_grades = grade_journal[student]!;

    for (String subject in subjects_list) {
      if (student_grades[subject] == 5) {
        count++;
      }
    }

    fives_count[student] = count;
    if (count > max_fives) {
      max_fives = count;
    }
  }

  if (max_fives == 0) {
    print("Нет студентов с пятерками");
  } else {
    print("Максимальное количество пятерок: $max_fives");
    print("Студенты:");

    fives_count.forEach((student, count) {
      if (count == max_fives) {
        print("  $student — $count пятерок");
      }
    });
  }
}

void show_subjects_below_four(List<String> students_list, List<String> subjects_list, 
 Map<String, Map<String, int>> grade_journal) {

  for (String student in students_list) {
    Map<String, int> student_grades = grade_journal[student]!;
    List<String> bad_subjects = [];

    for (String subject in subjects_list) {
      if (student_grades[subject]! < 4) {
        bad_subjects.add("$subject (${student_grades[subject]})");
      }
    }

    print("$student:");
    if (bad_subjects.isEmpty) {
      print("  Нет предметов с оценкой ниже 4");
    } else {
      print("  Количество: ${bad_subjects.length}");
      print("  Список: ${bad_subjects.join(', ')}");
    }
    print("");
  }
}

void show_all_five_pairs(List<String> students_list, List<String> subjects_list, 
  Map<String, Map<String, int>> grade_journal) {

  List<String> pairs = [];

  for (String student in students_list) {
    Map<String, int> student_grades = grade_journal[student]!;
    for (String subject in subjects_list) {
      if (student_grades[subject] == 5) {
        pairs.add("$student — $subject");
      }
    }
  }

  if (pairs.isEmpty) {
    print("Нет пятерок");
  } else {
    print("Всего пятерок: ${pairs.length}");
    pairs.forEach((pair) => print(pair));
  }
}