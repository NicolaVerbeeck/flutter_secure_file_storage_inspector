import 'dart:typed_data';

import 'package:flutter_secure_file_storage/flutter_secure_file_storage.dart';
import 'package:storage_inspector/storage_inspector.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

class SecureFileStorageInspector implements KeyValueServer {
  final FlutterSecureFileStorage storage;

  @override
  final Set<StorageType> supportedKeyTypes = const {StorageType.string};
  @override
  final Set<StorageType> supportedValueTypes = const {StorageType.binary};
  @override
  final Map<ValueWithType, StorageType> typeForKey = const {};
  @override
  final Set<ValueWithType> keySuggestions;
  @override
  final Set<ValueWithType> keyOptions;
  @override
  final String name;
  @override
  final String? icon;
  @override
  final String id = const Uuid().v4();
  @override
  final Map<ValueWithType, String> keyIcons;

  SecureFileStorageInspector({
    required this.storage,
    required this.name,
    this.icon,
    Set<String> keySuggestions = const {},
    Set<String> keyOptions = const {},
    Map<String, String> keyIcons = const {},
  })  : keySuggestions = keySuggestions
            .map((e) => ValueWithType(StorageType.string, e))
            .toSet(),
        keyOptions =
            keyOptions.map((e) => ValueWithType(StorageType.string, e)).toSet(),
        keyIcons = keyIcons.map(
          (key, value) =>
              MapEntry(ValueWithType(StorageType.string, key), value),
        );

  @override
  Future<List<Tuple2<ValueWithType, ValueWithType>>> get allValues async {
    return (await storage.getAllKeys())
        .map(
          (e) => Tuple2(
            ValueWithType(StorageType.string, e),
            const ValueWithType(StorageType.binary, null),
          ),
        )
        .toList();
  }

  @override
  Future<void> clear() => storage.deleteAll();

  @override
  Future<ValueWithType> get(ValueWithType key) async {
    final value = await storage.read<Uint8List>(key: key.value.toString());
    if (value == null) throw ArgumentError('No value found for key: $value');

    return ValueWithType(StorageType.binary, value);
  }

  @override
  Future<void> remove(ValueWithType key) =>
      storage.delete(key: key.value.toString());

  @override
  Future<void> set(
    ValueWithType key,
    ValueWithType newValue,
  ) =>
      storage.write(key: key.value.toString(), value: newValue.value);
}
