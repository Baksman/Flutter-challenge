import 'dart:async';
import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/repository/api_response.dart';
import 'package:flutter_challenge/repository/failure.dart';
import 'package:flutter_challenge/utilities/network_utils.dart';
import 'package:http/http.dart' as http;

/// [BaseDatasource]
///
/// Mixin interface to send Http requests and process the response
/// to [ApiResponse] of type [<Map<String, dynamic>>]
///
/// Utilize the transform and transformToStatusOnly functions extended on
/// [ApiResponse<Map<String, dynamic>>] to convert ApiResponses from your
/// datasources, to values/models you wish to use.
///
/// Returns error as [NetworkFailure] if request cannot connect.
///
/// Returns error as [ServerFailure] if status code **500** is returned,
/// or if body returned cannot be decoded (body is not json).
///
/// Return error as [InputFailure] if server returns error based on
/// conditions set in private function `_checkForError`
///

class BaseDatasource {
  final http.Client client;
  final String baseUrl = "https://dog.ceo/api";

  BaseDatasource({required this.client});

  Uri _url(
    String endpoint,
  ) =>
      Uri.parse(
        '$baseUrl$endpoint',
      );

  // String get userToken => _token.accessToken;
  Map<String, String> get jsonHeaders => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

  Future<ApiResponse<Map<String, dynamic>>> _processRequest(
    Future<http.Response> request,
  ) async {
    try {
      final response = await request.timeout(DB_TIMEOUT,
          onTimeout: () => throw TimeoutException(NETWORK_ERROR_MESSAGE));
      debugPrint('RESPONSE STATUS ---- ${response.statusCode}');
      debugPrint('RESPONSE BODY ---- ${response.body}');
      debugPrint('RESPONSE URL ---- ${response.request?.url}');

      dynamic data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        return ApiResponse(
          data: data,
          error: ServerFailure(error: response.body),
        );
      }

      final error = _checkForError(response.statusCode, data);
      return ApiResponse(
        data: data,
        error: error,
      );
    } on TimeoutException {
      return ApiResponse(error: ServerFailure(error: TIME_OUT_MESSAGE));
    } on FormatException {
      return ApiResponse(error: ServerFailure(error: FORMAT_EXCEPTION));
    } catch (e, s) {
      debugPrint(s.toString());
      return ApiResponse(error: convertException(e));
    }
  }

  ///Send a http *GET* request to "`$baseUrl$`[endpoint]"
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendGet(
      {required String endpoint,
      bool useToken = true,
      bool userV2Prefix = true,
      bool istest = false,
      Map<String, dynamic>? queryParams}) {
    final request = client.get(
      _url(endpoint),
      headers: jsonHeaders,
    );
    debugPrint('REQUEST -- $endpoint');
    return _processRequest(request);
  }

  ///Send a http *PATCH* request to "`$baseUrl$`[endpoint]".
  ///[payload] is encoded and sent as request body.
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.

  Failure _checkForError(int statusCode, data) {
    String? returnedMessage;
    // returnedMessage = '';
    if (statusCode - 200 <= 99) return NullFailure();
    if (data != null) {
      //Check if request was successful
      bool success = data['success'] ?? false;
      //If successful, return no failure
      // Null failure should be returned if success
      if (success) return NullFailure();

      //Check list of errors
      if (data['message'] is String) {
        returnedMessage = data['message'];
      }
      final errors = data['message'];
      if (errors is Map) {
        //If no error field - use messsage for failure
        if (errors.isEmpty) {
          returnedMessage = data['message'];
        }
        //If there are error fields - use errors for failure
        else {
          // returnedMessage = errors;
          errors.forEach((key, value) {
            if (value is List) {
              returnedMessage = value.first;
            } else {
              returnedMessage = '$returnedMessage\n$value';
            }
          });
        }
      } else if (errors is String) {
        returnedMessage = errors;
      }
    }

    returnedMessage ??= SERVER_ERROR_MESSAGE;
    debugPrint('-----$returnedMessage-----');

    if (statusCode == 401) {
      return BadAuthFailure(errorMessage: returnedMessage!);
    } else if (statusCode == 403) {
      return ServerFailure(error: returnedMessage!);
    } else if (statusCode == 404) {
      return NotFoundFailure(errorMessage: returnedMessage!);
    } else if (statusCode == 500) {
      return ServerFailure(error: returnedMessage!);
    } else if (statusCode == 502) {
      return ServerFailure(error: returnedMessage!);
    } else if (statusCode == 503) {
      return ServerFailure(error: returnedMessage!);
    } else if (statusCode == 504) {
      return ServerFailure(error: returnedMessage!);
    } else {
      return UnknownFailure(message: returnedMessage!);
    }
  }
}
