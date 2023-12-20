import 'package:chatapp/src/data/local/local_db.dart';
import 'package:chatapp/src/data/models/chat/get_chat.dart';
import 'package:sembast/sembast.dart';

class ChatDao {
  static const String CHAT_STORE_NAME = 'Chats';
  final _chatStore = intMapStoreFactory.store(CHAT_STORE_NAME);

  Future<Database?> get _db async => await LocalDataBase.instance.database;

  Future insertOrUpdate(GetChats chat) async {
    await _chatStore.record(chat.id!).put((await _db) as Database, chat.toJson());
  }

  // Future update(GetChats chat) async {
  //   final finder = Finder(filter: Filter.byKey(chat.id));
  //   await _chatStore.update((await _db) as Database, chat.toJson(),
  //       finder: finder);
  // }

  Future delete(GetChats chat) async {
    final finder = Finder(filter: Filter.byKey(chat.id));
    await _chatStore.delete((await _db) as Database, finder: finder);
  }

  Future deleteAll() async {
    await _chatStore.delete((await _db) as Database);
  }

  Future<List<GetChats>> getAll() async {
    final recordSnapshot = await _chatStore.find(
      (await _db) as Database,
    );
    return recordSnapshot.map((snapshot) {
      final chats = GetChats.fromJson2(snapshot.value);
      //chats.id = snapshot.key;
      return chats;
    }).toList();
  }
}
