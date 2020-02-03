import 'dart:io';

import 'package:open_file/open_file.dart';


class OpenFileClass{

  static Future<bool> open (File file) async {

    if (file.path== null) return false;

    if (!file.existsSync()) return false;

    String ext = file.path.split('.').last;

    if (ext.toLowerCase() =='pdf'){
      OpenFile.open(
        file.path,
        type: 'application/pdf',
        uti: 'com.adobe.pdf',
      );
    }else{
      OpenFile.open( file.path );
    }

    return true;

  }
}