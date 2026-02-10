import 'package:intl/intl.dart';

/// Date and number formatters. Uses [intl]; pass [locale] for i18n if needed.

final DateFormat _defaultDate = DateFormat.yMd();
final DateFormat _defaultDateTime = DateFormat.yMd().add_Hm();
final NumberFormat _defaultDecimal = NumberFormat.decimalPattern();
final NumberFormat _defaultCurrency = NumberFormat.simpleCurrency();

/// Formats [date] with optional [locale].
String formatDate(DateTime date, [String? locale]) {
  if (locale != null) {
    return DateFormat.yMd(locale).format(date);
  }
  return _defaultDate.format(date);
}

/// Formats [dateTime] with optional [locale].
String formatDateTime(DateTime dateTime, [String? locale]) {
  if (locale != null) {
    return DateFormat.yMd(locale).add_Hm().format(dateTime);
  }
  return _defaultDateTime.format(dateTime);
}

/// Formats [value] as decimal with optional [locale] and [fractionDigits].
String formatDecimal(num value, [String? locale, int? fractionDigits]) {
  if (locale != null || fractionDigits != null) {
    final pattern = fractionDigits != null && fractionDigits > 0
        ? '#,##0.${'0' * fractionDigits}'
        : null;
    final format = pattern != null
        ? NumberFormat(pattern, locale)
        : NumberFormat.decimalPattern(locale);
    return format.format(value);
  }
  return _defaultDecimal.format(value);
}

/// Formats [value] as currency with optional [locale] and [symbol].
String formatCurrency(num value, [String? locale, String? symbol]) {
  if (locale != null || symbol != null) {
    return NumberFormat.currency(locale: locale, symbol: symbol ?? '').format(value);
  }
  return _defaultCurrency.format(value);
}
