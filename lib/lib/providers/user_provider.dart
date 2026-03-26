import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameProvider = StateProvider<String>((ref) {
  return "Victoria Robertson";
});

final userMantraProvider = StateProvider<String>((ref) {
  return "A mantra goes here";
});