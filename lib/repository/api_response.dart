import 'dart:core';

import 'package:flutter_challenge/repository/failure.dart';

class ApiResponse<T> {
  final T? data;
  final Failure? error;
  final bool hasError;

  ApiResponse({
    this.data,
    this.error = NullFailure.instance,
  })  : hasError = error != NullFailure(),
        assert((data != null) || (error != NullFailure()),
            'Must have one of data or error');
}

extension Converter<E> on ApiResponse<Map<String, dynamic>> {
  // ignore: avoid_shadowing_type_parameters
  ApiResponse<E> transform<E>(
    E Function(Map<String, dynamic>? data) transformer, {
    bool ignoreHasError = false,
  }) {
    E? transformedData;
    if (data != null) {
      transformedData =
          (ignoreHasError || !hasError) ? transformer(data) : null;
    }

    return ApiResponse<E>(
      data: transformedData,
      error: error,
    );
  }

  ApiResponse<bool> transformToStatusOnly() {
    final status = (data?['status'] == 'success');

    return ApiResponse(
      data: status,
      error: error,
    );
    // return transform((data) {
    //   final status = data['success'] as bool;
    //   return status ?? false;
    // });
  }
}
