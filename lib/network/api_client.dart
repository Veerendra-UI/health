import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';
import 'package:YOURDRS_FlutterAPP/common/app_log_helper.dart';
import 'package:YOURDRS_FlutterAPP/common/app_response.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient with AppLogHelper {
  static const errorMsg = "Got error, please try again.";

  Dio _dio;

  ApiClient(this._dio);

  Future<DioResponse> sendRequest(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    DioResponse dioResponse = new DioResponse();
    dioResponse.requestUrl = path;
    try {
      Response<String> response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response != null) {
        printLog("response.success");
        dioResponse.isSuccessful = true;
        dioResponse.code = response.statusCode;
        dioResponse.message = response.statusMessage;
        dioResponse.rawResponse = response.data;
      } else {
        printLog("response.failed");
        dioResponse.errorMsgFromApiClient =
            ApiErrorHelper.getErrorMessage(ApiErrors.OTHER);
      }
    } catch (exception, s) {
      printLog("response.exception");
      printLog(exception, s);
      dioResponse.errorMsgFromApiClient =
          ApiErrorHelper.getErrorMessage(handleError(exception));
      if (exception != null && exception is DioError) {
        // only DioError will have the response
        dioResponse.rawResponse = exception?.response?.data ?? "";
      }
      printLog("responseHelper.errorMsg");
    }
    return dioResponse;
  }

  static ApiClient init() {
    BaseOptions options = new BaseOptions(
      baseUrl: AppConstants.dioBaseUrl,
      connectTimeout: AppConstants.dioConnectTimeout,
      receiveTimeout: AppConstants.dioReceiveTimeout,
    );
    Dio dio = Dio(options);
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        maxWidth: 180));
    return ApiClient(dio);
  }

  ApiErrors handleError(Object exception) {
    printLog(exception);
    ApiErrors apiError;
    if (exception is Error) {
      apiError = ApiErrors.OTHER;
    } else if (exception is Exception) {
      apiError = ApiErrors.OTHER;
      if (exception is DioError) {
        switch (exception.type) {
          case DioErrorType.CANCEL:
            apiError = ApiErrors.CANCEL;
            break;
          case DioErrorType.DEFAULT:
            apiError = ApiErrors.NO_NETWORK;
            break;
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.RECEIVE_TIMEOUT:
            apiError = ApiErrors.TIMEOUT;
            break;
          case DioErrorType.RESPONSE:
          default:
            apiError = ApiErrors.OTHER;
            break;
        }
      }
    }
    return apiError;
  }

  Options getDioOptions(String method, {bool auth = true}) {
    Options options = Options();
    options.method = method;
//    if (auth) {
//      options.headers = {
//        "Authorization": AppConstants.auth,
//      };
//    }
    return options;
  }
}

enum ApiErrors { NO_NETWORK, TIMEOUT, CANCEL, OTHER }

class ApiErrorHelper {
  static String getErrorMessage(ApiErrors errors) {
    switch (errors) {
      case ApiErrors.NO_NETWORK:
        return "Connection failed, Please check your internet connection and try again!";
      case ApiErrors.TIMEOUT:
        return "Connection timeout";
      case ApiErrors.CANCEL:
        return "Request cancelled";
      case ApiErrors.OTHER:
      default:
        return "Something went wrong, please try again!";
    }
  }
}
