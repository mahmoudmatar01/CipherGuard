import 'package:flutter/material.dart';

class ViginereCesar extends StatelessWidget {
  const ViginereCesar({super.key});

  // Encryption Method
  String vigenereEncrypt(String plaintext, String key) {
    // key is word
    // Cipher Text = ( Plain Text + Key ) mod n
    StringBuffer ciphertext = StringBuffer();

    int mod = 'A'.codeUnitAt(0); // 65 first alpha

    for (int i = 0, j = 0; i < plaintext.length; i++) {
      String char = plaintext[i];

      if (RegExp(r'[A-Za-z]').hasMatch(char)) {
        // Encrypt only alphabetic characters
        bool isUpperCase = char == char.toUpperCase();
        char = char.toUpperCase();

        int charCode = char.codeUnitAt(0) - mod;

        int keyShift = key[j % key.length].toUpperCase().codeUnitAt(0) - mod;

        int encryptedCharCode = (charCode + keyShift) % 26;

        char = String.fromCharCode((encryptedCharCode % 26) + mod);

        if (!isUpperCase) {
          char = char.toLowerCase();
        }

        j++;
      }

      ciphertext.write(char);
    }

    return ciphertext.toString();
  }

  // Decryption Method
  String vigenereDecrypt(String ciphertext, String key) {
    // key is word
    // Plain TextCipher Text = ( Cipher Text + Key ) mod n
    StringBuffer decryptedText = StringBuffer();

    int mod = 'A'.codeUnitAt(0); // 65 first alpha

    for (int i = 0, j = 0; i < ciphertext.length; i++) {
      String char = ciphertext[i];

      if (RegExp(r'[A-Za-z]').hasMatch(char)) {
        // Decrypt only alphabetic characters
        bool isUpperCase = char == char.toUpperCase();
        char = char.toUpperCase();

        int charCode = char.codeUnitAt(0) - mod;
        int keyShift = key[j % key.length].toUpperCase().codeUnitAt(0) - mod;

        int decryptedCharCode = (charCode - keyShift + 26) % 26;

        char = String.fromCharCode((decryptedCharCode % 26) + mod);

        if (!isUpperCase) {
          char = char.toLowerCase();
        }

        j++;
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
