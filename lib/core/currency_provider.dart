// // lib/core/providers/currency_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Currency {
//   final String code;
//   final String symbol;
//   final String name;

//   const Currency({
//     required this.code,
//     required this.symbol,
//     required this.name,
//   });
// }

// class CurrencyNotifier extends StateNotifier<Currency> {
//   CurrencyNotifier()
//     : super(const Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee')) {
//     _loadCurrency();
//   }

//   static const availableCurrencies = [
//     Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee'),
//     Currency(code: 'USD', symbol: '\$', name: 'US Dollar'),
//     Currency(code: 'EUR', symbol: '€', name: 'Euro'),
//     Currency(code: 'GBP', symbol: '£', name: 'British Pound'),
//     Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen'),
//   ];

//   Future<void> _loadCurrency() async {
//     final prefs = await SharedPreferences.getInstance();
//     final currencyCode = prefs.getString('currency_code') ?? 'INR';
//     final currency = availableCurrencies.firstWhere(
//       (c) => c.code == currencyCode,
//       orElse: () => availableCurrencies.first,
//     );
//     state = currency;
//   }

//   Future<void> setCurrency(Currency currency) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('currency_code', currency.code);
//     state = currency;
//   }

//   String formatAmount(double amount) {
//     return '${state.symbol}${amount.toStringAsFixed(2)}';
//   }
// }

// final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>(
//   (ref) => CurrencyNotifier(),
// );

// core/currency_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Currency {
  final String code;
  final String symbol;
  final String name;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
  });
}

class CurrencyNotifier extends StateNotifier<Currency> {
  static const _defaultCurrency = Currency(
    code: 'INR',
    symbol: '₹',
    name: 'Indian Rupee',
  );

  CurrencyNotifier() : super(_defaultCurrency) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('currency_code') ?? _defaultCurrency.code;
    final symbol =
        prefs.getString('currency_symbol') ?? _defaultCurrency.symbol;
    final name = prefs.getString('currency_name') ?? _defaultCurrency.name;
    state = Currency(code: code, symbol: symbol, name: name);
  }

  Future<void> setCurrency(Currency newCurrency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency_code', newCurrency.code);
    await prefs.setString('currency_symbol', newCurrency.symbol);
    await prefs.setString('currency_name', newCurrency.name);
    state = newCurrency; // Notify listeners
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>((
  ref,
) {
  return CurrencyNotifier();
});
