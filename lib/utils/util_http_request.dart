import 'package:dio/dio.dart';
import 'package:flutter_application_1/configs/config_main.dart';
import 'package:flutter_application_1/configs/config_messages.dart';
import 'package:flutter_application_1/utils/util_hive.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

final dio = Dio(BaseOptions(
  connectTimeout: const Duration(
    minutes: MainConfig.networkRequestTimeoutMinute,
  ),
  receiveTimeout: const Duration(
    minutes: MainConfig.networkRequestTimeoutMinute,
  ),
  sendTimeout: const Duration(
    minutes: MainConfig.networkRequestTimeoutMinute,
  ),
));

enum AppNetworkResponseStatus { success, failed, serverError, requestError }

class AppNetworkResponse {
  final AppNetworkResponseStatus status;
  dynamic body;
  dynamic header;
  String? error;

  AppNetworkResponse(
    this.status, {
    required this.body,
    this.error,
    this.header,
  });
}

class AppNetworkRequest {
  static logNetworkRequest(path, response) {
    if (MainConfig.debugMode) {
      var networkCollection =
          const AppLocalStorage("network-debugger").read() ?? {"data": []};
      DateTime now = DateTime.now();
      String formattedTime = DateFormat.Hms().format(now);
      networkCollection["data"].insert(0, {
        "method": response.requestOptions.method,
        "timestamp": formattedTime,
        "statusCode": response.statusCode,
        "path": path,
        "body": response.data,
      });
      const AppLocalStorage(
        "network-debugger",
      ).insert(networkCollection);
    }
  }

  static post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Function(bool isLoading)? onLoad,
  }) async {
    try {
      await dotenv.load(fileName: ".env");
      final url = "${dotenv.env['hostname']}$path";
      final reqHeaders = Options(
        headers: MainConfig.networkRequestDefaultHeaders..addAll(headers ?? {}),
      );

      // Get the response
      final response = await dio.post(
        url,
        data: data,
        options: reqHeaders,
        onReceiveProgress: (count, total) {
          if (onLoad != null) {
            onLoad(false);
          }
        },
        onSendProgress: (count, total) {
          if (onLoad != null) {
            onLoad(true);
          }
        },
      );

      // Log Network Request
      // AppLogger.networkLog("POST", path, response.data);
      logNetworkRequest(path, response);

      // Catch the response
      // Only Receive 200 Success Response
      if (response.statusCode == 200) {
        return AppNetworkResponse(
          AppNetworkResponseStatus.success,
          body: response.data,
          header: response.headers,
        );
      } else {
        if (onLoad != null) {
          onLoad(false);
        }
        // Failed with server status anything than 200s
        return AppNetworkResponse(
          AppNetworkResponseStatus.failed,
          body: response.data ?? {},
          header: response.headers,
        );
      }
    } on DioException catch (e) {
      logNetworkRequest(path, e.response);
      if (onLoad != null) {
        onLoad(false);
      }
      if (e.response != null) {
        return AppNetworkResponse(
          AppNetworkResponseStatus.serverError,
          body: null,
          header: e.response?.headers,
          error: AppMessages.serverError,
        );
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return AppNetworkResponse(
          AppNetworkResponseStatus.requestError,
          error: e.message.toString(),
          body: null,
        );
      }
    }
  }

  // GET request
  static get(
    String path, {
    Map<String, dynamic>? headers,
    Function(bool isLoading)? onLoad,
  }) async {
    try {
      await dotenv.load(fileName: ".env");
      final url = "${dotenv.env['hostname']}$path";
      final reqHeaders = Options(
        headers: MainConfig.networkRequestDefaultHeaders..addAll(headers ?? {}),
      );
      if (onLoad != null) {
        onLoad(true);
      }
      // Get the response
      final response = await dio.get(
        url,
        options: reqHeaders,
        onReceiveProgress: (count, total) {
          if (onLoad != null) {
            onLoad(false);
          }
        },
      );

      // Log Network Request
      // AppLogger.networkLog("GET", path, response.data);
      logNetworkRequest(path, response);

      // Catch the response
      // Only Receive 200 Success Response
      if (response.statusCode == 200) {
        return AppNetworkResponse(
          AppNetworkResponseStatus.success,
          body: response.data,
          header: response.headers,
        );
      } else {
        if (onLoad != null) {
          onLoad(false);
        }
        // Failed with server status anything than 200s
        return AppNetworkResponse(
          AppNetworkResponseStatus.failed,
          body: response.data ?? {},
          header: response.headers,
        );
      }
    } on DioException catch (e) {
      logNetworkRequest(path, e.response);
      if (onLoad != null) {
        onLoad(false);
      }
      if (e.response != null) {
        return AppNetworkResponse(
          AppNetworkResponseStatus.serverError,
          body: null,
          header: e.response?.headers,
          error: e.response?.data["message"] ?? AppMessages.serverError,
        );
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return AppNetworkResponse(
          AppNetworkResponseStatus.requestError,
          error: e.message.toString(),
          body: null,
        );
      }
    }
  }
}
