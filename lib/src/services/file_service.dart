import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService{
static Future<String> getApplicationDataPath() async {
  if (Platform.isIOS) {
    return (await getApplicationSupportDirectory()).path;
  } else {
    return (await getApplicationSupportDirectory()).path;
  }
}
}

