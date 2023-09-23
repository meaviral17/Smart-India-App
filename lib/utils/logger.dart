enum LogType { info, success, error, warning, danger }

abstract class Implementlog {
  bool get showLogs;
  void log(String message, String functionName,
      {LogType logType = LogType.info}) {}
}

class Logger {
  static const bool showLogs = true;

  static void logS(String message, String functionName) {
    if (showLogs) {
      print('✅ ' + functionName + "➡️" + message);
    }
  }

  static void logW(String message, String functionName) {
    if (showLogs) {
      print('🟡 ' + functionName + "➡️" + message);
    }
  }

  static void logE(String message, String functionName) {
    if (showLogs) {
      print('❌ ' + functionName + "➡️" + message);
    }
  }

  static void logI(String message, String functionName) {
    if (showLogs) {
      print('ℹ️ ' + functionName + "➡️" + message);
    }
  }

  static void logU(String message, String functionName) {
    if (showLogs) {
      print('🔥 ' + functionName + "➡️" + message);
    }
  }

  static void logH(String message, {String functionName = ""}) {
    if (showLogs) {
      print('👻 ' + functionName + "➡️" + message);
    }
  }

  static void logA(String message) {
    if (showLogs) {
      print('😽' + "➡️" + message);
    }
  }
}