import 'package:nanoid/nanoid.dart';

class IDGeneratorHelper {
  static String generateId() {
    return customAlphabet(
      '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz',
      19,
    );
  }
}
