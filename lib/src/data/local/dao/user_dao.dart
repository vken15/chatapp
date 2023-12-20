import 'package:chatapp/src/data/local/local_db.dart';
import 'package:chatapp/src/data/models/user/user_info.dart';
import 'package:sembast/sembast.dart';

class UserDao {
  static const String USER_STORE_NAME = 'Users';
  final _userStore = intMapStoreFactory.store(USER_STORE_NAME);

  Future<Database?> get _db async => await LocalDataBase.instance.database;

  Future insertOrUpdate(UserInfo user) async {
    await _userStore
        .record(user.id!)
        .put((await _db) as Database, user.toJson(), merge: true);
  }

  // Future update(UserInfo user) async {
  //   final finder = Finder(filter: Filter.byKey(user.id));
  //   print(user.id);
  //   final result = await _userStore.update((await _db) as Database, user.toJson(),
  //       finder: finder);
  //   print(result);
  // }

  Future delete(UserInfo user) async {
    final finder = Finder(filter: Filter.byKey(user.id));
    await _userStore.delete((await _db) as Database, finder: finder);
  }

  Future deleteAll() async {
    await _userStore.delete((await _db) as Database);
  }

  Future<UserInfo> getById(int userId) async {
    final finder = Finder(filter: Filter.equals('id', userId));
    final recordSnapshot = await _userStore.findFirst(
      (await _db) as Database,
      finder: finder,
    );
    if (recordSnapshot != null) {
      return UserInfo.fromJson(recordSnapshot.value);
    } else {
      throw Exception("Người dùng không tồn tại!");
    }
  }
}
