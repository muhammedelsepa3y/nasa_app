import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_app/data/models/mars_photo.dart';
import 'package:nasa_app/utils/constants.dart';

class NetworkServices {
  static final NetworkServices _networkServices = NetworkServices._internal();
  NetworkServices._internal();
  late Dio _dio;
  factory NetworkServices() {
    _networkServices._dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
        responseType: ResponseType.json,
        queryParameters: {
          'api_key': apiKey,
        },
        method: 'GET',
      ),

    );
    _networkServices._dio.interceptors.add(
      RetryInterceptor(
        dio: _networkServices._dio,
        logPrint: log,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 3),
          Duration(seconds: 5),
        ],
        retryableExtraStatuses: {status403Forbidden},
      ),
    );
    return _networkServices;
  }




  Future<List<dynamic>> getMarsPhoto(DateTime earthDate) async {
    try {
      Response response = await _dio.request(
        baseUrl+marsRoverPhotosEndPoint,
        queryParameters: {
          "earth_date": earthDate.toString(),
        },
      );
      return response.data["photos"];

    } catch(e){
      rethrow;
    }
  }
}
