import 'dart:io';
import 'package:bank/bank_system.dart';
import 'package:bank/src/domain/validators/date_validator.dart';
import 'package:bank/src/domain/validators/number_validator.dart';
import 'package:bank/src/domain/validators/text_validator.dart';

class InputHelper {
  static String askString(String prompt, {String? Function(String)? validator}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim() ?? '';
      
      if (validator != null) {
        final error = validator(input);
        if (error != null) {
          print('Ошибка: $error');
          continue;
        }
      }
      
      return input;
    }
  }

  static String askRequiredString(String prompt, String fieldName) {
    return askString(
      prompt,
      validator: (value) => TextValidator.validateRequired(value, fieldName),
    );
  }

  static double askPositiveDouble(String prompt, String fieldName) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim() ?? '';
      
      final error = NumberValidator.validatePositiveDouble(input, fieldName);
      if (error != null) {
        print('Ошибка: $error');
        continue;
      }
      
      return double.parse(input);
    }
  }

  static int askPositiveInt(String prompt, String fieldName) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim() ?? '';
      
      final error = NumberValidator.validatePositiveInt(input, fieldName);
      if (error != null) {
        print('Ошибка: $error');
        continue;
      }
      
      return int.parse(input);
    }
  }

  static DateTime askDate(String prompt, String fieldName) {
    while (true) {
      stdout.write('$prompt (ГГГГ-ММ-ДД): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      
      final error = DateValidator.validateDate(input, fieldName);
      if (error != null) {
        print('Ошибка: $error');
        continue;
      }
      
      return DateTime.parse(input);
    }
  }

  static DateTime askFutureDate(String prompt, String fieldName) {
    while (true) {
      final date = askDate(prompt, fieldName);
      
      final error = DateValidator.validateFutureDate(date.toIso8601String().substring(0, 10), fieldName);
      if (error != null) {
        print('Ошибка: $error');
        continue;
      }
      
      return date;
    }
  }

  static String askPhone(String prompt) {
    return askString(
      prompt,
      validator: (value) => TextValidator.validatePhone(value),
    );
  }

  static String askEmail(String prompt) {
    return askString(
      prompt,
      validator: (value) => TextValidator.validateEmail(value),
    );
  }

  static String askPassport(String prompt) {
    return askString(
      prompt,
      validator: (value) => TextValidator.validatePassport(value),
    );
  }

  static String selectFromList<T>(String prompt, List<T> items, String Function(T) display) {
    if (items.isEmpty) {
      print('Список пуст');
      return '';
    }
    
    print('\n$prompt:');
    for (int i = 0; i < items.length; i++) {
      print('${i + 1}. ${display(items[i])}');
    }
    
    while (true) {
      stdout.write('Выберите номер (1-${items.length}): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      final index = int.tryParse(input);
      
      if (index != null && index >= 1 && index <= items.length) {
        if (items[index - 1] is Client) {
          return (items[index - 1] as Client).id;
        } else if (items[index - 1] is Employee) {
          return (items[index - 1] as Employee).id;
        } else if (items[index - 1] is BankingService) {
          return (items[index - 1] as BankingService).id;
        } else if (items[index - 1] is Position) {
          return (items[index - 1] as Position).id;
        }
        return '';
      }
      
      print('Неверный выбор. Попробуйте снова.');
    }
  }

  static String askStatus() {
    print('\nВыберите статус договора:');
    print('1. active (активный)');
    print('2. completed (завершен)');
    print('3. terminated (расторгнут)');
    
    while (true) {
      stdout.write('Ваш выбор (1-3): ');
      final input = stdin.readLineSync()?.trim() ?? '';
      
      switch (input) {
        case '1':
          return 'active';
        case '2':
          return 'completed';
        case '3':
          return 'terminated';
        default:
          print('Неверный выбор. Попробуйте снова.');
      }
    }
  }

  static String confirm(String prompt) {
    while (true) {
      stdout.write('$prompt (y/n): ');
      final input = stdin.readLineSync()?.trim().toLowerCase() ?? '';
      
      if (input == 'y' || input == 'yes') {
        return 'y';
      } else if (input == 'n' || input == 'no') {
        return 'n';
      }
      
      print('Пожалуйста, введите y или n');
    }
  }
}