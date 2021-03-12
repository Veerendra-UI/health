mixin AppLogHelper {
  void printLog(Object object, [StackTrace stackTrace]) {
    try {
      if (stackTrace != null) {
        Log.er("${this.runtimeType}", object, stackTrace);
      } else {
        Log.e("${this.runtimeType}", object);
      }
    } catch (e, s) {
      printLogs("printLog", object, stackTrace);
      printLogs("printLog error:", e, s);
    }
  }

  static void printLogs(String tag, Object object, [StackTrace s]) {
    if (s != null) {
      Log.er("$tag", object, s);
    } else {
      Log.e("$tag", object);
    }
  }
}

class Log {
  Log._();

  static final RegExp pattern = RegExp('.{1,800}');

  static e(String tag, Object msg) {
    try {
      pattern
          .allMatches("E:$tag: $msg")
          .forEach((match) => print(match.group(0)));
    } catch (e, s) {
      print("BASE ERR:$e");
      print("BASE ERR:$s");
    }
  }

  static er(String tag, Object msg, Object obj) {
    print("ER:$tag: $msg\nER:-->$obj");
  }
}
