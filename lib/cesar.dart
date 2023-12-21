import 'package:flutter/material.dart';

class CesarCipher extends StatelessWidget {
  const CesarCipher({super.key});

  // Encryption Method
  String caesarEncrypt(String plaintext, int key) {
    // key is number
    // Cipher Text = ( Plain Text + Key ) mod n
    String ciphertext = "";

    // loop in plain text to convert each char
    for (int i = 0; i < plaintext.length; i++) {
      String char = plaintext[i];

      // for ignore space (  )
      if (RegExp(r'[A-Za-z]').hasMatch(char)) {
        bool isUpperCase = char == char.toUpperCase();

        // Convert the letter to uppercase for consistency.
        char = char.toUpperCase();

        // start alpha 'A'.codeUnitAt(0)  =  65 ;
        int charCode = char.codeUnitAt(0) - 'A'.codeUnitAt(0);
        int encryptedCharCode = (charCode + key) % 26;

        // get cipher char for plain char
        char =
            String.fromCharCode((encryptedCharCode % 26) + 'A'.codeUnitAt(0));
        if (!isUpperCase) {
          char = char.toLowerCase();
        }
      }
      ciphertext += char;
    }
    return ciphertext;
  }

  // Decryption Method
  String caesarDecrypt(String ciphertext, int key) {
    // Decryption is the same as encryption with a negative shift
    // Plain Text = ( Cipher Text - Key ) mod n
    return caesarEncrypt(ciphertext, -key);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
