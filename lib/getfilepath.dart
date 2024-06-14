import 'package:path_provider/path_provider.dart';

Future<void> getFilePaths() async {
  try {
    // Get the directory to save files
    final directory = await getApplicationDocumentsDirectory();
    print('Application Documents Directory: ${directory.path}');

    // Example: Creating a file path
    final filePath = '${directory.path}/example.mp4';
    print('Example File Path: $filePath');
  } catch (e) {
    print('Error getting file paths: $e');
  }
}
