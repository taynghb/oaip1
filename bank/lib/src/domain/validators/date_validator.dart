// Валидация даты/времени
class DateValidator {
  static String? validateDate(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустым';
    }
    
    final date = DateTime.tryParse(value.trim());
    if (date == null) {
      return '$fieldName должен быть в формате ГГГГ-ММ-ДД';
    }
    
    return null;
  }

  static String? validateFutureDate(String? value, String fieldName) {
    final error = validateDate(value, fieldName);
    if (error != null) return error;
    
    final date = DateTime.parse(value!.trim());
    final now = DateTime.now();
    
    if (date.isBefore(now)) {
      return '$fieldName должен быть в будущем';
    }
    
    return null;
  }

  static String? validateDateRange(String? startDate, String? endDate) {
    final startError = validateDate(startDate, 'Дата начала');
    if (startError != null) return startError;
    
    final endError = validateDate(endDate, 'Дата окончания');
    if (endError != null) return endError;
    
    final start = DateTime.parse(startDate!.trim());
    final end = DateTime.parse(endDate!.trim());
    
    if (end.isBefore(start)) {
      return 'Дата окончания не может быть раньше даты начала';
    }
    
    return null;
  }
}