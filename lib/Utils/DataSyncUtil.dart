import 'dart:collection';

import '../Pages/Settings/SettingsProvider.dart';

class DataSyncUtil {
  static getLocalData() async {
    Map rst = {"histories": [], "favorites": []};
    rst["histories"] = SettingsProvider().getHistories();
    rst["favorites"] = SettingsProvider().getFavorites();
    return rst;
  }

  static importFromJson(Map data, bool localFirst) async {
    // histories
    List<String> cloudHistory = List<String>.from(data["histories"]);
    List<String> localHistory = SettingsProvider().getHistories();
    print('local history');
    print(localHistory);
    List<String> resultHistory = localHistory;
    List<String> combineHistory;
    if (localFirst) {
      combineHistory = localHistory + cloudHistory;
    } else {
      combineHistory = cloudHistory + localHistory;
    }
    resultHistory = LinkedHashSet<String>.from(combineHistory).toList();
    print(resultHistory);
    await SettingsProvider().replaceHistories(resultHistory);

    // favorites
    List<String> cloudFavorite = List<String>.from(data["favorites"]);
    List<String> localFavorite = SettingsProvider().getFavorites();
    print('local favorite');
    print(localFavorite);
    List<String> resultFavorite = localFavorite;
    List<String> combineFavorite;
    if (localFirst) {
      combineFavorite = localFavorite + cloudFavorite;
    } else {
      combineFavorite = cloudFavorite + localFavorite;
    }
    resultFavorite = LinkedHashSet<String>.from(combineFavorite).toList();
    print(resultFavorite);
    await SettingsProvider().replaceFavorites(resultFavorite);
    return {"histories": resultHistory, "favorites": resultFavorite};
  }
}