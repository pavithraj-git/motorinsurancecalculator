import 'dart:io';
import 'package:share_plus/share_plus.dart';

class ShareFile {
  createAndShareFile(File file) async {
    final params = ShareParams(
      text: 'Great picture',
      files: [XFile("${file.path}")],
    );

    final result = await SharePlus.instance.share(params);

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing the picture!');
    }
  }

}
