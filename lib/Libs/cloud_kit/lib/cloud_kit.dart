import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class CloudKit {
  static const MethodChannel _channel = const MethodChannel('cloud_kit');

  String _containerId = '';

  CloudKit(String containerIdentifier) {
    _containerId = containerIdentifier;
  }

  /// Save a new entry to CloudKit using a key and value.
  /// The key need to be unique.
  /// Returns a boolean [bool] with true if the save was successfully.
  Future<bool> save(String key, String value) async {
    if (!Platform.isIOS) {
      return false;
    }

    if (key.length == 0 || value.length == 0) {
      return false;
    }

    bool status = await _channel.invokeMethod('save',
            {"key": key, "value": value, "containerId": _containerId}) ??
        false;

    return status;
  }

  /// Loads a value from CloudKit by key.
  /// Returns a string [string] with the saved value.
  /// This can be null if the key was not found.
  Future<String?> get(String key) async {
    if (!Platform.isIOS) {
      return null;
    }

    if (key.length == 0) {
      return null;
    }

    List<dynamic> records = await (_channel
        .invokeMethod('get', {"key": key, "containerId": _containerId}));

    if (records.length != 0) {
      return records[0];
    } else {
      return null;
    }
  }

  /// Delete a entry from CloudKit using the key.
  Future<void> delete(String key) async {
    if (!Platform.isIOS) {
      return;
    }

    if (key.length == 0) {
      return;
    }

    await _channel
        .invokeMethod('delete', {"key": key, "containerId": _containerId});
  }

  /// Deletes the entire user database.
  Future<void> clearDatabase() async {
    if (!Platform.isIOS) {
      return;
    }

    await _channel.invokeMethod('deleteAll', {"containerId": _containerId});
  }
}
