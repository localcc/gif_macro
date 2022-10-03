import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';

part 'settings_store.g.dart';

@collection
class Settings {
  Settings({required this.toggleWindowKeybind, required this.runOnStartup});

  Id id = Isar.autoIncrement;
  List<int> toggleWindowKeybind;
  bool runOnStartup;
}

class SettingsProvider extends ChangeNotifier {
  SettingsProvider({required this.isar}) {
    isar.settings.watchLazy(fireImmediately: true).listen((event) {
      notifyListeners();
    });
  }

  Future<Settings> getSettings() async {
    final list = await isar.settings.where().findAll();
    return list.isNotEmpty
        ? list.first
        : Settings(toggleWindowKeybind: List.empty(), runOnStartup: false);
  }

  Future<void> setRunOnStartup(bool runOnStartup) async {
    var settings = await getSettings();
    settings.runOnStartup = runOnStartup;
    await updateSettings(settings);
  }

  Future<void> setToggleWindowKeybind(List<int> toggleWindowKeybind) async {
    var settings = await getSettings();
    settings.toggleWindowKeybind = toggleWindowKeybind;
    await updateSettings(settings);
  }

  Future<void> updateSettings(Settings settings) async {
    await isar.writeTxn(() async {
      isar.settings.put(settings);
    });
  }

  late final Isar isar;
}
