import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' as Foundation;

const Encrypt_Key = "zG2nSeEfSHfvTCHy5LCcqtBbQehKNLXn";
var iv = Uint8List(16);

class Decrypt {
  static decrypt(String text) {
    return Foundation.compute(decrypt2Base64, text);
  }

  static decrypt2Base64(String data, {keyStr: Encrypt_Key}) {
    Uint8List decrypted = new Base64Decoder().convert(data);
    String content = decryptStr(decrypted, keyStr);
    if (keyStr == Encrypt_Key) {
      return json.decode(content);
    } else {
      return content;
    }
  }

  static decryptStr(Uint8List data, String keyStr) {
    var digest = sha256.convert(keyStr.codeUnits);
    var key = new Uint8List.fromList(digest.bytes.take(32).toList());
    final encrypter = Encrypter(AES(Key(key), mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(Encrypted(data), iv: IV(iv));
    return decrypted;
  }
}
