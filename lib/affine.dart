import 'package:flutter/material.dart';
import 'dart:math';

class Affine extends StatelessWidget {
  const Affine({super.key});

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

    // Check if modular inverse exists
    if (modInverseA == -1) {
      throw Exception('Modular inverse does not exist');
    }

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

// Extended Euclidean Algorithm to find modular inverse
  List<int> extendedGCD(int a, int b) {
    if (b == 0) {
      return [a, 1, 0];
    } else {
      List<int> result = extendedGCD(b, a % b);
      int d = result[0];
      int x = result[2];
      int y = result[1] - (a ~/ b) * result[2];
      return [d, x, y];
    }
  }

// Modular inverse function
  int modInverse(int a, int m) {
    List<int> result = extendedGCD(a, m);
    int d = result[0];
    int x = result[1];

    if (d == 1) {
      // Modular inverse exists
      return (x % m + m) % m;
    } else {
      // Modular inverse does not exist
      return -1;
    }
  }

  int findCoprime(int n) {
    Random random = Random();
    int coprime;
    do {
      coprime = random.nextInt(n);
    } while (gcd(coprime, n) != 1);
    return coprime;
  }

  int gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
