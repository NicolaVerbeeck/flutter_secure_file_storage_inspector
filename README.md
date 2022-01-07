# Flutter secure file storage inspector

[![pub package](https://img.shields.io/pub/v/flutter_secure_file_storage_inspector.svg?color=blue)](https://pub.dev/packages/flutter_secure_file_storage_inspector)
[![pub points](https://badges.bar/sentry/pub%20points)](https://pub.dev/packages/flutter_secure_file_storage_inspector/score)
[![plugin_badge](https://img.shields.io/jetbrains/plugin/v/18231-local-storage-inspector?color=blue&label=IntelliJ%20Plugin)](https://plugins.jetbrains.com/plugin/18231-local-storage-inspector)

Inspector interface for [flutter secure file storage](https://pub.dev/packages/flutter_secure_file_storage) package.

Allows key-value inspection of contents stored in the file storage using the [local storage inspector](https://pub.dev/packages/storage_inspector) package.

### Example
```dart
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
```
