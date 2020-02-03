import 'dart:io';
import 'dart:typed_data';
import 'package:sitediary/datas/eform_record.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

String applicationDocumentsDirectory;
String externalStorageDirectory;

class FileCopier{
  final String baseAppFolder = 'eForm';
  String appFolderFullPath ='';


  final EFormRecordDetail eFormRecordDetail;
  FileCopier(this.eFormRecordDetail);

  String baseDirectory;

  String relativePath;
  String destFullPath;

  bool isForceApplicationDirectory = true;

  Future<String> getBaseDir() async{


     if (Platform.isIOS || isForceApplicationDirectory ){
       //print('applicationDocumentsDirectory: $applicationDocumentsDirectory');
       if (applicationDocumentsDirectory==null){
         applicationDocumentsDirectory = (await getApplicationDocumentsDirectory()).path;
         //print('applicationDocumentsDirectory 2: $applicationDocumentsDirectory');
       }
       return  applicationDocumentsDirectory;

     }else{
       //print('externalStorageDirectory: $externalStorageDirectory');
       if (externalStorageDirectory==null){
         externalStorageDirectory = (await getExternalStorageDirectory()).path;
         //print('externalStorageDirectory 2: $externalStorageDirectory');
       }
       return externalStorageDirectory;
     }


  }

  Future<String> getFullPath() async {
    this.relativePath = eFormRecordDetail.itemPath;
    baseDirectory = await getBaseDir();
    destFullPath = join(baseDirectory, this.relativePath);

    File destFile = File(destFullPath);
    if (!destFile.parent.existsSync()) destFile.parent.createSync(recursive: true);

    return destFullPath;
  }

  Future<String> doCopyBytes(Uint8List bytes) async{
    final rd = eFormRecordDetail;
    Directory d  = await getTemporaryDirectory();

    File sourceFile = File(join(d.path, 'tempFile','signature', DateTime.now().millisecondsSinceEpoch.toString() ,rd.eFormItemKey ));

    if (sourceFile.existsSync()) sourceFile.deleteSync();
    else if (!sourceFile.parent.existsSync()) sourceFile.parent.createSync(recursive: true);
    print('Temp file path: ' + sourceFile.path);
    sourceFile.writeAsBytesSync(  bytes,mode: FileMode.write,flush: true);

    return doCopy(sourceFile);
  }

  Future<String> doCopy(File sourceFile) async{
    final rd = eFormRecordDetail;
    rd.setFile(sourceFile.path);

    int fileLength = sourceFile.lengthSync();
    rd.itemValueDecimal = fileLength.toDouble();

    baseDirectory = await getBaseDir();

    int fileTicket =DateTime.now().millisecondsSinceEpoch;

    relativePath = join(baseAppFolder,rd.eFormKey, rd.eFormRecordID, rd.eFormItemKey, '$fileTicket', rd.itemValue);
    rd.itemPath = relativePath;
    destFullPath = join(baseDirectory, relativePath);

    //Equal to destination
    if (destFullPath.toLowerCase() == sourceFile.path.toLowerCase()){
      return destFullPath;
    }

    //this.createFolderIfNotExists();
    File destFile = File(destFullPath);
    if (!destFile.parent.existsSync()) destFile.parent.createSync(recursive: true);

    if (destFile.existsSync()) destFile.deleteSync();

    //final destFile = File(destFullPath);
    sourceFile.copySync(destFullPath);

    return destFullPath;
  }

}

class FileStorage{

  FileStorage(this.baseFileName, this.isSystemFile);

  String fileFullPath = '';
  final String baseFileName;
  Future<File> get _localFile async {
    final path = await _localPath;
    //this.filePath = '$path/counter.txt';
    this.fileFullPath = join( path ,baseFileName);

    final file =  File(this.fileFullPath);

    if (!file.parent.existsSync()) file.parent.createSync(recursive: true);
    return file ;
  }

  Future<File> get getFile async {
    return _localFile;
  }

  final bool isSystemFile ;

  Future<String> getBaseDir() async{



    if (Platform.isIOS || isSystemFile){
      print('getApplicationDocumentsDirectory: $getApplicationDocumentsDirectory');
      if (applicationDocumentsDirectory==null){
        applicationDocumentsDirectory = (await getApplicationDocumentsDirectory()).path;
      }
      return applicationDocumentsDirectory;

    }else{
      print('externalStorageDirectory: $externalStorageDirectory');
      if (externalStorageDirectory==null){
        externalStorageDirectory = (await getExternalStorageDirectory()).path;
        print('externalStorageDirectory 2: $externalStorageDirectory');
      }
      return   externalStorageDirectory;
    }


  }

  Future<String> get _localPath async {
    final directory = await getBaseDir();
    return directory;
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$counter');
  }

  Future<File> writeString(String text) async {
    final file = await _localFile;
    // Write the file
    print('Saving list to: ${file.path}' );
    return file.writeAsString(text);
  }


  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<String> readString() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

}