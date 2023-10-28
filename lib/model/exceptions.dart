
import 'package:flutter/material.dart';
import 'package:flutter_challenge/repository/failure.dart';
import 'package:flutter_challenge/utilities/network_utils.dart';

class ServerException implements Exception {
  final String? errorMessage;
  ServerException({this.errorMessage = SERVER_ERROR_MESSAGE});
  ServerFailure toFailure() => ServerFailure(error: errorMessage);
}

class InputException implements Exception {
  final String? errorMessage;
  InputException({@required this.errorMessage});
  InputFailure toFailure() => InputFailure(errorMessage: errorMessage);
}

class UnauthorisedException implements Exception {
  final String errorMessage;
  UnauthorisedException({this.errorMessage = ''});
  BadAuthFailure toFailure() => BadAuthFailure(errorMessage: errorMessage);
}

class NetworkException implements Exception {}

class UnknownException implements Exception {}
