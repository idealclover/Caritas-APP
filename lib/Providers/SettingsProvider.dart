import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../Resources/Constant.dart';
import '../Resources/Themes.dart';

class SettingsProvider {
  final _box = GetStorage();
  final _key = 'settings';

  static const _key_privacyVersion = "privacyVersion";
  static const _key_themeIndex = "themeIndex";
  static const _key_themeMode = "themeMode";
  static const _key_themeCustomColor = "themeCustomColor";
  static const _key_lastCheckUpdateTime = "lastCheckUpdateTime";
  static const _key_cooldownTime = "cooldownTime";

  final _defaultSettings = {
    /// default privacy version when not installed
    _key_privacyVersion: -1,
    _key_themeIndex: 0,
    _key_themeMode: 0,
    _key_themeCustomColor: '',
    _key_lastCheckUpdateTime: 0,
    _key_cooldownTime: 600
  };

  /// Get settings from local storage
  // Map get settings => _loadSettingsFromBox();

  /// Load settings from local storage and if it's empty, returns default
  Map _loadSettingsFromBox() => _box.read(_key) ?? _defaultSettings;

  /// Save settings to local storage
  _saveSettingsToBox(Map settings) => _box.write(_key, settings);

  int getPrivacyVersion() {
    return _loadSettingsFromBox()[_key_privacyVersion] ??
        _defaultSettings[_key_privacyVersion];
  }

  void setPrivacyVersion(int value) {
    Map settings = _loadSettingsFromBox();
    settings[_key_privacyVersion] = value;
    print(settings);
    _saveSettingsToBox(settings);
  }

  int getThemeIndex() {
    return _loadSettingsFromBox()[_key_themeIndex] ??
        _defaultSettings[_key_themeIndex];
  }

  /// Switch theme and save to local storage
  void setThemeIndex(int value) {
    Get.changeTheme(Themes.themeList[value]['light']!);
    Map settings = _loadSettingsFromBox();
    settings[_key_themeIndex] = value;
    print(settings);
    _saveSettingsToBox(settings);
  }

  int getThemeMode() {
    return _loadSettingsFromBox()[_key_themeMode] ??
        _defaultSettings[_key_themeMode];
  }

  /// Switch theme and save to local storage
  void setThemeMode(int value) {
    Get.changeThemeMode(Constant.themeModeList[value]);
    Map settings = _loadSettingsFromBox();
    settings[_key_themeMode] = value;
    print(settings);
    _saveSettingsToBox(settings);
  }

  String getThemeCustomColor() {
    return _loadSettingsFromBox()[_key_themeCustomColor] ??
        _defaultSettings[_key_themeCustomColor];
  }

  void setThemeCustomColor(String value) {
    Map settings = _loadSettingsFromBox();
    settings[_key_themeCustomColor] = value;
    /// 自定义颜色时颜色主题为-1
    settings[_key_themeIndex] = -1;
    print(settings);
    _saveSettingsToBox(settings);
  }

  int getLastCheckUpdateTime() {
    return _loadSettingsFromBox()[_key_lastCheckUpdateTime] ??
        _defaultSettings[_key_lastCheckUpdateTime];
  }

  void setLastCheckUpdateTime(int value) {
    Map settings = _loadSettingsFromBox();
    settings[_key_lastCheckUpdateTime] = value;
    print(settings);
    _saveSettingsToBox(settings);
  }

  int getCooldownTime() {
    return _loadSettingsFromBox()[_key_cooldownTime] ??
        _defaultSettings[_key_cooldownTime];
  }

  void setCooldownTime(int value) {
    Map settings = _loadSettingsFromBox();
    settings[_key_cooldownTime] = value;
    print(settings);
    _saveSettingsToBox(settings);
  }
}
