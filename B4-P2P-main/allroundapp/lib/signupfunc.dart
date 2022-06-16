// ignore_for_file: unnecessary_new, avoid_print, import_of_legacy_library_into_null_safe, undefined_hidden_name, non_constant_identifier_names, unused_import, unused_element, unnecessary_import

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:core';
import 'dart:io';

//import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';
//import 'package:x509/x509.dart';
import "package:pointycastle/export.dart" hide ASN1ObjectIdentifier, ASN1Object, ASN1Sequence, ASN1Integer,
ASN1Null, ASN1BitString, ASN1OctetString, ASN1Set;
import 'package:asn1lib/asn1lib.dart';
import 'package:basic_utils/basic_utils.dart' hide ASN1ObjectIdentifier, ASN1Object, ASN1Sequence,
ASN1Integer, ASN1Null, ASN1BitString, ASN1OctetString,ASN1Set, ASN1PrintableString, ASN1UTF8String;

List<String> _chunked(String string){
  return string.split('');
}

Map<String, String> Info = {
  "CN": "www.davidjanes.com",
  "O": "Consensas",
  "L": "Toronto",
  "ST": "Ontario",
  "C": "CA",
};

void newmain() {
  AsymmetricKeyPair keyPair = rsaGenerateKeyPair();

  ASN1ObjectIdentifier.registerFrequentNames();


  //String dn_string = jsonEncode(Info);

  ASN1Object encodedCSR = makeRSACSR(Info, keyPair.privateKey, keyPair.publicKey);
  //print(encodedCSR);
  print(encodeCSRToPem(encodedCSR));
  //print(keyPair.publicKey);
  print(encodeRSAPublicKeyToPem(keyPair.publicKey));
  print(encodeRSAPrivateKeyToPem(keyPair.privateKey));
}



AsymmetricKeyPair rsaGenerateKeyPair({int bitStrength = 2048}) {
  var keyParams =
  RSAKeyGeneratorParameters(BigInt.parse('65537'), bitStrength, 12);

  var secureRandom = FortunaRandom();
  var random = Random.secure();
  List<int> seeds = [];
  for (int i = 0; i < 32; i++) {
    seeds.add(random.nextInt(255));
  }
  secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

  var rngParams = ParametersWithRandom(keyParams, secureRandom);
  var k = RSAKeyGenerator();
  k.init(rngParams);

  return k.generateKeyPair();
}



ASN1Object makeRSACSR(
    Map dn, privateKey, publicKey) {
  //ASN1Object encodedDN = JsonEncoder(dn) as ASN1Object;

  ASN1Sequence blockDN = ASN1Sequence();
  blockDN.add(ASN1Integer(BigInt.from(0)));
  blockDN.add(encodeDN(Info));
  blockDN.add(_makePublicKeyBlock(publicKey));  // Directly add public key
  //blockDN.add(publicKey);
  blockDN.add(ASN1Null(tag: 0xA0)); // let's call this WTF

  ASN1Sequence blockProtocol = ASN1Sequence();
  blockProtocol.add(ASN1ObjectIdentifier.fromName("md5WithRSAEncryption"));
  blockProtocol.add(ASN1Null());

  ASN1Sequence outer = ASN1Sequence();
  outer.add(blockDN);
  outer.add(blockProtocol);


  outer.add(ASN1BitString(rsaSign(blockDN.encodedBytes, privateKey)));
  outer.add(ASN1BitString(rsaSign(blockDN.encodedBytes, privateKey)));
  return outer;
}

List<int> rsaPrivateKeyToBytes(String privateKey){
  return utf8.encode(privateKey);
}


List<int> rsaSign(Uint8List inBytes, RSAPrivateKey privateKey) {
  Signer signer = Signer("MD5/RSA");
  signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

  Signature signature = signer.generateSignature(inBytes); // Doubt
  List<int> bytes = utf8.encode(signature.toString());
  return bytes;
}


encodeRSAPublicKeyToPem(publicKey) {
  var algorithmSeq = new ASN1Sequence();
  var algorithmAsn1Obj = new ASN1Object.fromBytes(Uint8List.fromList(
      [0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1]));
  var paramsAsn1Obj = new ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
  algorithmSeq.add(algorithmAsn1Obj);
  algorithmSeq.add(paramsAsn1Obj);

  var publicKeySeq = new ASN1Sequence();
  publicKeySeq.add(ASN1Integer(publicKey.modulus));
  publicKeySeq.add(ASN1Integer(publicKey.exponent));
  var publicKeySeqBitString =
  new ASN1BitString(Uint8List.fromList(publicKeySeq.encodedBytes));

  var topLevelSeq = new ASN1Sequence();
  topLevelSeq.add(algorithmSeq);
  topLevelSeq.add(publicKeySeqBitString);
  var dataBase64 = base64.encode(topLevelSeq.encodedBytes);

  List<String> chunks = chunk(dataBase64, 256); // Doubt

  return """-----BEGIN PUBLIC KEY-----\r\n${chunks.join("\r\n")}\r\n-----END PUBLIC KEY-----\r\n""";
}

// encodeCSRToPem(ASN1Object csr) {
//   List<String> chunks = _chunked(csr.toString());
//
//   return "-----BEGIN CERTIFICATE REQUEST-----\r\n" +
//       chunks.join("\r\n") +
//       "\r\n-----END CERTIFICATE REQUEST-----\r\n";
// }
List<String> chunk(String s, int chunkSize) {
  var chunked = <String>[];
  for (var i = 0; i < s.length; i += chunkSize) {
    var end = (i + chunkSize < s.length) ? i + chunkSize : s.length;
    chunked.add(s.substring(i, end));
  }
  return chunked;
}

encodeCSRToPem(ASN1Object csr) {
  List<String> chunks = chunk(base64.encode(csr.encodedBytes), 256);
  return """-----BEGIN CERTIFICATE REQUEST-----\r\n${chunks.join("\r\n")}\r\n-----END CERTIFICATE REQUEST-----\r\n""";
}



String formatKeyString(String key, String begin, String end,
    {int chunkSize = 64, String lineDelimiter = '\n'}) {
  var sb = StringBuffer();
  var chunks = chunk(key, chunkSize);
  sb.write(begin + lineDelimiter);
  for (var s in chunks) {
    sb.write(s + lineDelimiter);
  }
  sb.write(end);
  return sb.toString();
}

encodeRSAPrivateKeyToPem(privateKey) {
  var version = ASN1Integer(BigInt.from(0));

  var algorithmSeq = ASN1Sequence();
  var algorithmAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList(
      [0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1]));
  var paramsAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
  algorithmSeq.add(algorithmAsn1Obj);
  algorithmSeq.add(paramsAsn1Obj);

  var privateKeySeq = ASN1Sequence();
  var modulus = ASN1Integer(privateKey.n);
  var publicExponent = ASN1Integer(BigInt.parse('65537'));
  var privateExponent = ASN1Integer(privateKey.d);
  var p = ASN1Integer(privateKey.p);
  var q = ASN1Integer(privateKey.q);
  var dP = privateKey.d % (privateKey.p - BigInt.from(1));
  var exp1 = ASN1Integer(dP);
  var dQ = privateKey.d % (privateKey.q - BigInt.from(1));
  var exp2 = ASN1Integer(dQ);
  var iQ = privateKey.q.modInverse(privateKey.p);
  var co = ASN1Integer(iQ);

  privateKeySeq.add(version);
  privateKeySeq.add(modulus);
  privateKeySeq.add(publicExponent);
  privateKeySeq.add(privateExponent);
  privateKeySeq.add(p);
  privateKeySeq.add(q);
  privateKeySeq.add(exp1);
  privateKeySeq.add(exp2);
  privateKeySeq.add(co);
  var publicKeySeqOctetString =
  ASN1OctetString(Uint8List.fromList(privateKeySeq.encodedBytes));

  var topLevelSeq = ASN1Sequence();
  topLevelSeq.add(version);
  topLevelSeq.add(algorithmSeq);
  topLevelSeq.add(publicKeySeqOctetString);
  var dataBase64 = base64.encode(topLevelSeq.encodedBytes);

  List<String> chunks = chunk(dataBase64, 256);

  return """-----BEGIN PRIVATE KEY-----\r\n${chunks.join("\r\n")}\r\n-----END PRIVATE KEY-----\r\n""";
}


ASN1Object encodeDN(Map<String, String> dn) {
  var distinguishedName = ASN1Sequence();
  dn.forEach((name, value) {
    var oid = ASN1ObjectIdentifier.fromName(name);

    ASN1Object ovalue;
    switch (name.toUpperCase()) {
      case 'C':
        ovalue = ASN1PrintableString(value);
        break;
      case 'CN':
      case 'O':
      case 'L':
      case 'S':
      default:
        ovalue = ASN1UTF8String(value);
        break;
    }

    var pair = ASN1Sequence();
    pair.add(oid);
    pair.add(ovalue);

    var pairset = ASN1Set();
    pairset.add(pair);

    distinguishedName.add(pairset);
  });

  return distinguishedName;
}

ASN1Sequence _makePublicKeyBlock(publicKey) {
  var blockEncryptionType = ASN1Sequence();
  blockEncryptionType.add(ASN1ObjectIdentifier.fromName('rsaEncryption'));
  blockEncryptionType.add(ASN1Null());

  var publicKeySequence = ASN1Sequence();
  publicKeySequence.add(ASN1Integer(publicKey.modulus));
  publicKeySequence.add(ASN1Integer(publicKey.exponent));

  var blockPublicKey =
  ASN1BitString(publicKeySequence.encodedBytes);

  var outer = ASN1Sequence();
  outer.add(blockEncryptionType);
  outer.add(blockPublicKey);

  return outer;
}


