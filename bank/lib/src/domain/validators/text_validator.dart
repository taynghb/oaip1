// Валидация обязательного текстового поля
class TextValidator {
  static bool isNotEmpty(String? value) {
    if (value == null) return false;
    return value.trim().isNotEmpty;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (!isNotEmpty(value)) {
      return '$fieldName не может быть пустым';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final error = validateRequired(value, 'Телефон');
    if (error != null) return error;
    
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value!.trim())) {
      return 'Введите корректный номер телефона (10-15 цифр)';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final error = validateRequired(value, 'Email');
    if (error != null) return error;
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value!.trim())) {
      return 'Введите корректный email';
    }
    return null;
  }

  static String? validatePassport(String? value) {
    final error = validateRequired(value, 'Паспорт');
    if (error != null) return error;
    
    if (value!.trim().length < 10) {
      return 'Паспорт должен содержать минимум 10 символов';
    }
    return null;
  }
}