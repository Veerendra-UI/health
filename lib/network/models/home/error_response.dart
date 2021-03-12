import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.errors,
    this.errorRaw,
  });

  Errors errors;
  Map<String, dynamic> errorRaw;

  ErrorResponse copyWith({
    Errors errors,
  }) =>
      ErrorResponse(
        errors: errors ?? this.errors,
      );

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    Errors errorObj;
    Map<String, dynamic> errorRaw;
    try {
      errorRaw = json["errors"] ?? json;
      errorObj = Errors.fromJson(errorRaw);
    } catch (e, s) {
      print(e);
      print(s);
      errorObj = Errors(error: json["errors"]);
      errorRaw = {"error": json["errors"]};
    }

    return ErrorResponse(
        errors: json["errors"] == null ? null : errorObj, errorRaw: errorRaw);
  }

  String getErrorMessage() {
    return errors?.getErrorMessage() ?? getErrorFromMap();
  }

  Map<String, dynamic> toJson() => {
        "errors": errors == null ? null : errors.toJson(),
      };

  @override
  String toString() {
    return 'ErrorResponse{errors: $errors, errorRaw: $errorRaw}';
  }

  String getErrorFromMap() {
    if (errorRaw != null) {
      return loopMap(errorRaw);
    }
    return null;
  }

  String loopMap(Map<String, dynamic> errorRaw) {
    for (var value in errorRaw.values) {
      if (value is Map) {
        return loopMap(value);
      } else if (value != null) {
        return value.toString();
      }
    }
    return null;
  }
}

class Errors {
  Errors({
    this.error,
    this.email,
    this.password,
  });

  String error;
  String email;
  String password;

  Errors copyWith({
    String error,
    String email,
    String password,
  }) =>
      Errors(
        error: error ?? this.error,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        error: json["error"] == null ? null : json["error"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
      };

  String getErrorMessage() {
    if (error != null) {
      return error;
    }
    if (email != null) {
      return "Email error - $email";
    }
    if (password != null) {
      return "Password error - $password";
    }

    return error ?? email ?? password;
  }

  @override
  String toString() {
    return 'Errors{error: $error}';
  }
}
