// ignore_for_file: public_member_api_docs, unnecessary_breaks

import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:path/path.dart' as p;

final String _logDir = p.join(Directory.current.path, 'logs');
final File _accessLogFile = File(p.join(_logDir, 'access.log'));
final File _errorLogFile = File(p.join(_logDir, 'error.log'));

Handler logger(Handler handler) {
  Directory(_logDir).createSync(recursive: true);

  return (context) async {
    final req = context.request;
    final start = DateTime.now();

    Response response;
    try {
      response = await handler(context);
    } catch (e, st) {
      final errMsg = '''
[${_timeNow()}] ERROR ${req.method} ${req.uri.path}
$e
$st
${'-' * 80}
''';
      await _writeLog(errMsg, isError: true);
      rethrow;
    }

    final duration = DateTime.now().difference(start);
    final status = response.statusCode;
    final logMsg = '''
[${_timeNow()}] ${req.method.value} ${req.uri.path}
→ Status: $status (${duration.inMilliseconds}ms)
${'-' * 80}
''';

    await _writeLog(logMsg, isError: status >= 400);
    _printColoredLog(req.method.value, req.uri.path, status, duration);

    return response;
  };
}

Future<void> _writeLog(String message, {bool isError = false}) async {
  final file = isError ? _errorLogFile : _accessLogFile;
  await file.writeAsString(message, mode: FileMode.append, flush: true);
}

void _printColoredLog(
  String method,
  String path,
  int status,
  Duration duration,
) {
  const reset = '\x1B[0m';
  const green = '\x1B[32m';
  const yellow = '\x1B[33m';
  const red = '\x1B[31m';
  const cyan = '\x1B[36m';
  const magenta = '\x1B[35m';

  // Status color
  String color;
  if (status >= 500) {
    color = red;
  } else if (status >= 400) {
    color = yellow;
  } else {
    color = green;
  }

  // Method color
  String methodColor;
  switch (method) {
    case 'GET':
      methodColor = cyan;
      break;
    case 'POST':
      methodColor = magenta;
      break;
    case 'PUT':
    case 'PATCH':
      methodColor = yellow;
      break;
    case 'DELETE':
      methodColor = red;
      break;
    default:
      methodColor = reset;
  }

  final time = _timeNow();
  final durationStr = '${duration.inMilliseconds}ms';

  // Print formatted, colored log line
  stdout.writeln(
    '[$time] $methodColor${method.padRight(6)}$reset ${path.padRight(35)} → $color$status$reset ($durationStr)',
  );
}

String _timeNow() {
  final now = DateTime.now();
  final hh = now.hour.toString().padLeft(2, '0');
  final mm = now.minute.toString().padLeft(2, '0');
  final ss = now.second.toString().padLeft(2, '0');
  return '$hh:$mm:$ss';
}
