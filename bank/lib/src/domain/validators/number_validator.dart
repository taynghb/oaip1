// Валидация числовых полей (больше 0)
class NumberValidator {
  static bool isPositive(double value) {
    return value > 0;
  }

  static bool isPositiveInt(int value) {
    return value > 0;
  }

  static String? validatePositiveDouble(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустым';
    }
    
    final number = double.tryParse(value.trim());
    if (number == null) {
      return '$fieldName должно быть числом';
    }
    
    if (!isPositive(number)) {
      return '$fieldName должно быть больше 0';
    }
    
    return null;
  }

  static String? validatePositiveInt(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустым';
    }
    
    final number = int.tryParse(value.trim());
    if (number == null) {
      return '$fieldName должно быть целым числом';
    }
    
    if (!isPositiveInt(number)) {
      return '$fieldName должно быть больше 0';
    }
    
    return null;
  }

  static String? validateInterestRate(String? value) {
    final error = validatePositiveDouble(value, 'Процентная ставка');
    if (error != null) return error;
    
    final rate = double.parse(value!.trim());
    if (rate > 100) {
      return 'Процентная ставка не может быть больше 100%';
    }
    
    return null;
  }
}