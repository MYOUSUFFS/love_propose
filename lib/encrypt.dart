import 'dart:convert';

import 'package:encrypt/encrypt.dart';

final key = Key.fromUtf8(
    'mylengthSuperSecretPassphrasehel'); // Replace with a strong key
final iv = IV.fromLength(16);
final encrypter = Encrypter(AES(key));

String encrypt(String text) {
  final encrypted = encrypter.encrypt(text, iv: iv);
  return encrypted.base64;
}

String decrypt(String base64Text) {
  final encrypted = Encrypted.fromBase64(base64Text);
  return encrypter.decrypt(encrypted, iv: iv);
}

String encodeString(String inputString, String encoding) {
  List<int> bytes = inputString.codeUnits;
  String encodedString = utf8.decode(bytes);
  return encodedString;
}

String decodeString(String inputString, String encoding) {
  List<int> encodedBytes = utf8.encode(inputString);
  String decodedString = utf8.decode(encodedBytes);
  return decodedString;
}
