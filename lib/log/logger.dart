import 'package:logger/logger.dart';

final Logger log = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 2, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        // colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ),
    output: null, // Use the default LogOutput (-> send everything to console)
    filter: null // Use the default LogFilter (-> only log in debug mode)
);