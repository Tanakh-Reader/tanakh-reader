// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'dart:typed_data';

// class HebrewBibleDatabase {
//   // https://blog.devgenius.io/adding-sqlite-db-file-from-the-assets-internet-in-flutter-3ec42c14cd44
//   var databasesPath = await getDatabasesPath();
//   var path = join(databasesPath, "demo_asset_example.db");

//   // Check if the database exists
//   var exists = await databaseExists(path);

//   if (!exists) {
//     // Should happen only the first time you launch your application
//     print("Creating new copy from asset");

//     // Make sure the parent directory exists
//     try {
//       await Directory(dirname(path)).create(recursive: true);
//     } catch (_) {}
      
//     // Copy from asset
//     ByteData data = await rootBundle.load(join("assets", "example.db"));
//     List<int> bytes =
//     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    
//     // Write and flush the bytes written
//     await File(path).writeAsBytes(bytes, flush: true);

//   } else {
//     print("Opening existing database");
//   }
//   // open the database
//   db = await openDatabase(path, readOnly: true);
// }