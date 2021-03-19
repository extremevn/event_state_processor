import 'package:flutter/cupertino.dart';

class ApiException implements Exception {
  final int code;
  final String message;

  ApiException(this.code, this.message);

  ApiException.unknown(
      {this.code = unknownErrorCode, this.message = 'Unknown error'});

  ApiException.withMessage(
      {this.code = unknownErrorCode, @required this.message});

  ApiException.noInternet({this.code = networkErrorCode, this.message});

  static const int unknownErrorCode = 7000;
  static const int networkErrorCode = 9000;
}
