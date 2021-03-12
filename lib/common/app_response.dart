import 'package:YOURDRS_FlutterAPP/common/app_log_helper.dart';
import '../network/models/home/error_response.dart';

typedef ParserDef = T Function<T>(String response);

class DioResponse {
  /// true = request is success
  bool isSuccessful;
  int code;
  String message;

  /// response data for the request
  String rawResponse;

  /// Error message which can be displayed to user
  String errorMsgFromApiClient;

  String requestUrl;

  DioResponse({
    this.isSuccessful = false,
    this.rawResponse = "",
    this.errorMsgFromApiClient = "",
    this.code = 400,
    this.message = "Bad Request",
  });
}

class Request {
  final String requestUrl;
  final dynamic data;

  Request({
    this.requestUrl = "",
    this.data = "",
  });

  @override
  String toString() {
    return {"requestUrl": requestUrl, "data": data}.toString();
  }
}

class ApiResponse<T> {
  ///
  bool isSuccessful;
  int code;
  String message;
  String rawResponse;

  ///
  Request requestData;

  ///
  T data;
  ErrorResponse error;

  static const DEFAULT_ERROR_MESSAGE = "Got error, Please try again!";

  ApiResponse.withData(
    this.data, {
    this.isSuccessful = true,
    this.code = 200,
    this.message = "OK",
    this.rawResponse = "",
  });

  ApiResponse.withError(
    this.error, {
    this.isSuccessful = false,
    this.code = 400,
    this.message = "Bad Request",
    this.rawResponse = "",
  });

  ApiResponse.withErrorMsg({String errorMsg = DEFAULT_ERROR_MESSAGE}) {
    this.error = ErrorResponse(errors: Errors(error: errorMsg));
  }

  /// feature: for now assuming api will return only one type of error json for all request,
  /// Will make errorType is also generic in next phase
  static T _errorParser<T>(String response) {
    AppLogHelper.printLogs("ApiResponse", "_errorParser");
    return errorResponseFromJson(response) as T;
  }

//  static ApiResponse<T> parseData<T extends BaseResponse>(
  static ApiResponse<T> parseData<T>(
    DioResponse response,
    ParserDef resParserDef, {
    ParserDef errorParserDef = _errorParser,
  }) {
    ApiResponse<T> apiResponse;
    try {
      if (response.isSuccessful &&
          response.rawResponse !=
              null /*&& !response.response.contains("error")*/) {
        apiResponse =
            ApiResponse<T>.withData(resParserDef<T>(response.rawResponse));
      } else if (response.rawResponse != null &&
          response.rawResponse.trim().length > 0) {
        apiResponse =
            ApiResponse<T>.withError(errorParserDef(response.rawResponse));
      } else {
        apiResponse = ApiResponse.withError(ErrorResponse(
            errors: Errors(error: response.errorMsgFromApiClient)));
      }
    } catch (e, s) {
      print(e);
      print(s);
      apiResponse = ApiResponse.withError(ErrorResponse(
          errors: Errors(error: ApiResponse.DEFAULT_ERROR_MESSAGE)));
    }
    return apiResponse;
  }
}
