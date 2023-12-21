import 'package:flutter/material.dart';

class Affine extends StatelessWidget {
  const Affine({super.key});

  int modInverse(int a, int m) {
    for (int i = 0; i < m; i++) {
      if ((a * i) % m == 1) {
        return i;
      }
    }
    throw Exception('Modular inverse does not exist');
  }

  // Encryption Method
  // C = [ ( a * p ) + b ] % n
  // key (a ,b)
  String affineEncrypt(String plaintext, int keyA, int keyB) {
    StringBuffer ciphertext = StringBuffer();

    for (int i = 0; i < plaintext.length; i++) {
      String char = plaintext[i];

      if (RegExp(r'[A-Za-z]').hasMatch(char)) {
        // Encrypt only alphabetic characters
        bool isUpperCase = char == char.toUpperCase();
        char = char.toUpperCase();

        int charCode = char.codeUnitAt(0) - 'A'.codeUnitAt(0);
        int encryptedCharCode = ((keyA * charCode) + keyB) % 26;

        char =
            String.fromCharCode((encryptedCharCode % 26) + 'A'.codeUnitAt(0));

        if (!isUpperCase) {
          char = char.toLowerCase();
        }
      }

      ciphertext.write(char);
    }

    return ciphertext.toString();
  }

  // Decryption Method
  // P = [ a^-1 * ( c- b ) ] % n
  // key (a ,b)
  String affineDecrypt(String ciphertext, int keyA, int keyB) {
    int modInverseA = modInverse(keyA, 26);
    StringBuffer decryptedText = StringBuffer();

    for (int i = 0; i < ciphertext.length; i++) {
      String char = ciphertext[i];

      if (RegExp(r'[A-Za-z]').hasMatch(char)) {
        // Decrypt only alphabetic characters
        bool isUpperCase = char == char.toUpperCase();
        char = char.toUpperCase();

        int charCode = char.codeUnitAt(0) - 'A'.codeUnitAt(0);
        int decryptedCharCode = (modInverseA * (charCode - keyB + 26)) % 26;

        char =
            String.fromCharCode((decryptedCharCode % 26) + 'A'.codeUnitAt(0));

        if (!isUpperCase) {
          char = char.toLowerCase();
        }
      }

      decryptedText.write(char);
    }

    return decryptedText.toString();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
