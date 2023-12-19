import 'package:chatapp/src/data/local/local_db.dart';
import 'package:chatapp/src/data/models/message/received_message.dart';
import 'package:sembast/sembast.dart';

class MessageDao {
  static const String MESSAGE_STORE_NAME = 'Messages';
  final _messageStore = intMapStoreFactory.store(MESSAGE_STORE_NAME);

  Future<Database?> get _db async => await LocalDataBase.instance.database;

  Future insert(ReceivedMessage message) async {
    await _messageStore.record(message.id!).put((await _db) as Database, message.toJson());
  }

  Future update(ReceivedMessage message) async {
    final finder = Finder(filter: Filter.byKey(message.id));
    await _messageStore.update((await _db) as Database, message.toJson(),
        finder: finder);
  }

  Future delete(ReceivedMessage message) async {
    final finder = Finder(filter: Filter.byKey(message.id));
    await _messageStore.delete((await _db) as Database, finder: finder);
  }

  Future<List<ReceivedMessage>> getAllByIdSortedByLatest(int chatId, pageNumber) async {
    final finder = Finder(
        filter: Filter.equals('chatId', chatId),
        sortOrders: [SortOrder('createdAt', false)], limit: 12, offset: (pageNumber - 1) * 12);
    final recordSnapshot = await _messageStore.find(
      (await _db) as Database,
      finder: finder,
    );
    return recordSnapshot.map((snapshot) {
      final messages = ReceivedMessage.fromJson(snapshot.value);
      messages.chatId = snapshot.key;
      return messages;
    }).toList();
  }
}
