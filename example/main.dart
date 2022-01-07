import 'package:flutter/widgets.dart';
import 'package:flutter_secure_file_storage/flutter_secure_file_storage.dart';
import 'package:flutter_secure_file_storage_inspector/flutter_secure_file_storage_inspector.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage_inspector/storage_inspector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = FlutterSecureFileStorage(const FlutterSecureStorage());

  final driver = StorageServerDriver(
    bundleId: 'com.example.test',
    icon: '<some icon>',
  );
  final secureStorage =
      SecureFileStorageInspector(storage: storage, name: 'Secure files');
  driver.addKeyValueServer(secureStorage);

  // Don't wait for a connection from the instrumentation driver
  await driver.start(paused: false);

  // run app

  await driver.stop(); //Optional when main ends
}
