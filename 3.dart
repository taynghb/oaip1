import 'dart:io';

void main(List<String> arguments) {
  // Данные о группе
  List<String> students_list = [
    "Стецко Таня",
    "Михеева Мария",
    "Косаревская Настя",
    "Каврус Алина",
    "Кабанов Миша",
    "Гусаков Дима"
  ];

  List<String> subjects_list = ["опбд", "оаип", "тестирование", "бжд"];

  // Журнал оценок
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

  // Вычисляем средние баллы студентов
  Map<String, double> student_averages = {};

  for (String student in students_list) {
    Map<String, int> student_grades = grade_journal[student]!;
    int sum = 0;
    for (String subject in subjects_list) {
      sum += student_grades[subject]!;
    }
    student_averages[student] = sum / subjects_list.length;
  }

  // Вычисляем средние баллы по предметам
  Map<String, double> subject_averages = {};

  for (String subject in subjects_list) {
    int sum = 0;
    for (String student in students_list) {
      sum += grade_journal[student]![subject]!;
    }
    subject_averages[subject] = sum / students_list.length;
  }

  int choice;

  do {
    print("1. Сводная таблица успеваемости");
    print("2. Поиск студента по фамилии/имени");
    print("3. Список уникальных оценок");
    print("4. Максимальные и минимальные оценки по предметам");
    print("5. Студенты с ровно одной двойкой");
    print("6. Предметы выше общего среднего");
    print("7. Количество студентов в каждой категории");
    print("8. Выход");
    stdout.write("Выберите пункт: ");

    choice = int.parse(stdin.readLineSync()!);
    print("");
    switch (choice) {
      case 1:
        show_summary_table(students_list, subjects_list, grade_journal, student_averages, subject_averages);
        break;
      case 2:
        search_student(students_list, subjects_list, grade_journal, student_averages);
        break;
      case 3:
        show_unique_grades(students_list, subjects_list, grade_journal);
        break;
      case 4:
        show_min_max_grades(students_list, subjects_list, grade_journal);
        break;
      case 5:
        show_students_with_one_two(students_list, subjects_list, grade_journal);
        break;
      case 6:
        show_subjects_above_average(students_list, subjects_list, subject_averages, student_averages);
        break;
      case 7:
        show_category_count(students_list, student_averages);
        break;
      case 8:
        print("Выход");
        break;
      default:
        print("Неверный выбор");
    }

    if (choice != 0) {
      print("\nНажмите Enter для продолжения");
      stdin.readLineSync();
    }

  } while (choice != 0);
}

void show_summary_table(List<String> students_list, List<String> subjects_list,
Map<String, Map<String, int>> grade_journal,
Map<String, double> student_averages,
  Map<String, double> subject_averages) {

  stdout.write("Студент".padRight(20));
  for (String subject in subjects_list) {
    stdout.write(subject.padRight(10));
  }
  stdout.write("Средний".padRight(10));
  print("");

  print("-" * (20 + 10 * subjects_list.length + 10));

  for (String student in students_list) {
    stdout.write(student.padRight(20));

    Map<String, int> student_grades = grade_journal[student]!;
    for (String subject in subjects_list) {
      stdout.write(student_grades[subject].toString().padRight(10));
    }

    stdout.write(student_averages[student]!.toStringAsFixed(2).padRight(10));
    print("");
  }

  print("-" * (20 + 10 * subjects_list.length + 10));

  stdout.write("Средний по предмету".padRight(20));
  for (String subject in subjects_list) {
    stdout.write(subject_averages[subject]!.toStringAsFixed(2).padRight(10));
  }
  print("");
}

void search_student(List<String> students_list, List<String> subjects_list,
                    Map<String, Map<String, int>> grade_journal,
                    Map<String, double> student_averages) {
  stdout.write("Введите имя или фамилию для поиска: ");
  String query = stdin.readLineSync()!.toLowerCase();
  List<String> found_students = [];

  for (String student in students_list) {
    if (student.toLowerCase().contains(query)) {
      found_students.add(student);
    }
  }

  if (found_students.isEmpty) {
    print("Студенты не найдены");
  } else if (found_students.length > 1) {
    print("Найдено несколько студентов:");
    found_students.forEach((s) => print("  $s"));
    print("Уточните запрос");
  } else {
    // Нашли одного студента
    String student = found_students.first;
    print("\n" + "информация о студенте: $student");
    print("-" * 40);

    // Оценки по предметам
    print("оценки:");
    Map<String, int> student_grades = grade_journal[student]!;
    for (String subject in subjects_list) {
      print("  $subject: ${student_grades[subject]}");
    }

    double avg = student_averages[student]!;
    print("\nсредний балл: ${avg.toStringAsFixed(2)}");

    String category;
    if (avg >= 4.5) {
      category = "отличник";
    } else if (avg >= 3.5) {
      category = "хорошист";
    } else {
      category = "неучи";
    }

    print("категория: $category");
  }
}

void show_unique_grades(List<String> students_list, List<String> subjects_list,
 Map<String, Map<String, int>> grade_journal) {

  Set<int> unique_grades = {};

  for (String student in students_list) {
    Map<String, int> student_grades = grade_journal[student]!;
    for (String subject in subjects_list) {
      unique_grades.add(student_grades[subject]!);
    }
  }

  List<int> sorted_grades = unique_grades.toList()..sort();
  print("В журнале есть оценки: ${sorted_grades.join(', ')}");
}

void show_min_max_grades(List<String> students_list, List<String> subjects_list,
Map<String, Map<String, int>> grade_journal) {


  for (String subject in subjects_list) {
    int max_grade = 0;
    int min_grade = 5;
    List<String> students_with_max = [];
    List<String> students_with_min = [];

    for (String student in students_list) {
      int grade = grade_journal[student]![subject]!;

      if (grade > max_grade) {
        max_grade = grade;
        students_with_max = [student];
      } else if (grade == max_grade) {
        students_with_max.add(student);
      }

      if (grade < min_grade) {
        min_grade = grade;
        students_with_min = [student];
      } else if (grade == min_grade) {
        students_with_min.add(student);
      }
    }

    print("$subject:");
    print("  Максимальная оценка: $max_grade (${students_with_max.join(', ')})");
    print("  Минимальная оценка: $min_grade (${students_with_min.join(', ')})");
    print("");
  }
}

void show_students_with_one_two(List<String> students_list, List<String> subjects_list,
Map<String, Map<String, int>> grade_journal) {
  bool found = false;

  for (String student in students_list) {
    Map<String, int> student_grades = grade_journal[student]!;
    int twos_count = 0;
    String? subject_with_two;

    for (String subject in subjects_list) {
      if (student_grades[subject] == 2) {
        twos_count++;
        subject_with_two = subject;
      }
    }

    if (twos_count == 1) {
      found = true;
      print("$student — $subject_with_two");
    }
  }

  if (!found) {
    print("Нет студентов с ровно одной двойкой");
  }
}

void show_subjects_above_average(List<String> students_list, List<String> subjects_list,
Map<String, double> subject_averages,
Map<String, double> student_averages) {

  double total_sum = 0;
  student_averages.forEach((student, avg) {
    total_sum += avg;
  });
  double overall_average = total_sum / students_list.length;

  print("Общий средний балл по группе: ${overall_average.toStringAsFixed(2)}\n");

  List<String> above_average = [];

  subject_averages.forEach((subject, avg) {
    if (avg > overall_average) {
      above_average.add("$subject (${avg.toStringAsFixed(2)})");
    }
  });

  if (above_average.isEmpty) {
    print("Нет предметов выше общего среднего");
  } else {
    print("Предметы выше общего среднего:");
    above_average.forEach((s) => print("  $s"));
  }
}

void show_category_count(List<String> students_list, Map<String, double> student_averages) {
  int excellent = 0;
  int good = 0;
  int other = 0;

  for (String student in students_list) {
    double avg = student_averages[student]!;

    if (avg >= 4.5) {
      excellent++;
    } else if (avg >= 3.5) {
      good++;
    } else {
      other++;
    }
  }

  print("Отличники (>= 4.5): $excellent чел.");
  print("Хорошисты (3.5 - 4.5): $good чел.");
  print("Остальные (< 3.5): $other чел.");
  print("Всего студентов: ${students_list.length}");
}