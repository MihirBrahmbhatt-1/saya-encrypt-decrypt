import 'package:encrypt/encrypt.dart';

Key cryptKey = Key.fromUtf8("ruJRn-gee%8c2g=m");
final iv = IV.fromUtf8("uA%frBlR9tCv;f&h");

String encryptInputParams(String inputString) {
  final encrypter = Encrypter(
    AES(
      cryptKey,
      mode: AESMode.cbc,
      padding: 'PKCS7',
    ),
  );
  final encrypted = encrypter.encrypt(
    inputString,
    iv: iv,
  );
  return encrypted.base64.toString();
}

String decryptApiResponse(String apiResponseString) {
  final encrypter = Encrypter(
    AES(
      cryptKey,
      mode: AESMode.cbc,
      padding: 'PKCS7',
    ),
  );
  final decrypted = encrypter.decrypt(
    Encrypted.fromBase64(apiResponseString),
    iv: iv,
  );
  return decrypted;
}
