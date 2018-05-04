import 'dart:io';
import 'dart:async';
import '../utils/dataUtils.dart';

const String INDEX_FILE_NAME = 'index.db';
const String DATABASE_FILE_NAME = 'data.db';

class Database {
  final Directory dbPath;
  /// Structure |key 64 byte|offset int32|length int32|
  final File _indexFile;
  final File _database;

  Database(Uri path):
    dbPath = new Directory.fromUri(path),
    _indexFile = new File.fromUri(path.resolve(INDEX_FILE_NAME)),
    _database = new File.fromUri(path.resolve(DATABASE_FILE_NAME));
  
  Future<List<RandomAccessFile>> _prepare() {
    return Future.wait<RandomAccessFile>([
      _indexFile.open(mode: FileMode.WRITE),
      _database.open(mode: FileMode.WRITE),
    ]);
  }
  
  Future<List<RandomAccessFile>> _open() async {
    await dbPath.create(recursive: true);
    
    return _prepare();
  }
  
  Future<List<int>> _searchIndexFileForKey(RandomAccessFile indexFile, String key, final int length) async {
    int offset = 0;
    int dataOffset = null;
    int dataLength = null;

    while (offset < length && dataOffset == null) {
      await indexFile.setPosition(offset);
      List<int> bytes = await indexFile.read(64);

      if (key == String.fromCharCodes(bytes)) {
        List<int> offsetBytes = await indexFile.read(32);
        List<int> lengthBytes = await indexFile.read(32);

        dataOffset = uInt8ListToInt(offsetBytes);
        dataLength = uInt8ListToInt(lengthBytes);
      }
      offset += 128;
    }
    if (dataOffset == null) {
      return null;
    }

    return [dataOffset, dataLength];
  }
  
  Future _writeKey(RandomAccessFile indexFile, String key, int offset, int size, int length) async {
    List<int> keyBytes = createUint8ListFromString(key).toList();
    List<int> offsetBytes = intToUInt8List(offset, 32).toList();
    List<int> sizeBytes = intToUInt8List(size, 32).toList();

    await indexFile.setPosition(length);
    await indexFile.writeFrom(keyBytes);
    await indexFile.writeFrom(offsetBytes);
    await indexFile.writeFrom(sizeBytes);
  }
  
  /// TODO value should be dynamic (with codecs?)
  /// 1 record can be up to 4Gb length so index is 32byte int
  //? Have third file - meta. contains key increment
  //? Read from index file
  Future put(String value, String key) async {
    List<RandomAccessFile> controlFiles = await _open();
    RandomAccessFile indexFile = controlFiles.first;
    RandomAccessFile database = controlFiles.last;
    final int length = await indexFile.length();
    final int databaseSize = await database.length();
    List<int> offsets = await _searchIndexFileForKey(indexFile, key, length);
    final int dataOffset = offsets?.first ?? databaseSize;

    await Future.wait([
      database.lock(),
      indexFile.lock(),
    ]);

    await database.setPosition(databaseSize);
    await database.writeString(value);
    await _writeKey(indexFile, key, dataOffset, value.length, length);

    if (offsets == null) {
      // TODO: clean up
    }

    await Future.wait([
      database.unlock(),
      indexFile.unlock(),
    ]);
    await Future.wait([
      database.close(),
      indexFile.close(),
    ]);
  }
  
  Future<String> get(String key) async {
    List<RandomAccessFile> controlFiles = await _open();
    RandomAccessFile indexFile = controlFiles.first;
    RandomAccessFile database = controlFiles.last;
    final int length = await indexFile.length();
    List<int> offsets = await _searchIndexFileForKey(indexFile, key, length);
    
    if (offsets?.first == null || offsets?.last == null) {
      throw new Exception("'$key' not found in database");
    }
    final int dataOffset = offsets.first;
    final int dataLength = offset.last;

    await database.setPosition(dataOffset);
    final List<int> data = await database.read(dataLength);

    database.close();
    indexFile.close();

    return Future.value(String.fromCharCodes(data));
  }
}