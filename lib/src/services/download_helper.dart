import 'package:dio/dio.dart';


class DownloadHelper {
  static Future<bool> downloadFileFromUrl(
      {String? url,
      String? filePath,
      CancelToken? cancelToken,
      required void downloadSuccessActions(),
      required void downloadFailedActions(),
      bool debugEnabledOnReceiveProgress = true}) async {
    try {
      var response = await Dio().download(url!, filePath,
          cancelToken: cancelToken,).catchError(( error,StackTrace stackTrace ){
          });
      if (response.statusCode == 200) {
        downloadSuccessActions();
        return Future.value(true);
      } else {
        print("Response : " + response.toString());
        downloadFailedActions();
        return Future.value(false);
      }
    } catch (error) {
      downloadFailedActions();
      return Future.error(error);
    }
  }
}
