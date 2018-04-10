import 'dart:collection';
import './Hash.dart';
import '../config.dart';

class _BlockHeader extends LinkedListEntry {
  final Hash prevBlockID;
  final int nonce;
  final int majorVersion;
  final int minorVersion;
  final DateTime timestamp;
  
  _BlockHeader({
    this.nonce = 0,
    this.prevBlockID = null,
    this.majorVersion = Config.BLOCK_MAJOR_VERSION,
    this.minorVersion = Config.BLOCK_MINOR_VERSION,
    DateTime timestamp = null,
  }):
    this.timestamp = timestamp == null ? new DateTime.now() : timestamp;
}

class Block extends _BlockHeader {
  final Hash blockID;
  final HashSet<Hash> transactionHashes;

  Block({
    this.blockID,
    this.transactionHashes = null,
    int nonce = null,
    Hash prevBlockID = null,
    DateTime timestamp = null,
    int majorVersion,
    int minorVersion,
  }):super(
    nonce: nonce,
    prevBlockID: prevBlockID,
    majorVersion: majorVersion,
    minorVersion: minorVersion,
    timestamp: timestamp,
  );
  
  @override
  get hashCode => this.blockID;
}