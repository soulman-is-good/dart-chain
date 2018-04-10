import './database/Checkpoint.dart';

class Config {
  static const int DISPLAY_DECIMAL_POINTS = 8;
  static const int COIN = 1e8;
  static const int MONEY_SUPPLY = 350e6 * COIN;
  static const int INITIAL_EMISSION = MONEY_SUPPLY;
  static const int MINIMUM_FEE = 10000;
  
  static const String COIN_NAME = "smcoin";
  static const String GENESIS_BLOCK_TX_HEX = "";
  static const int CURRENT_TRANSACTION_VERSION = 1;
  static const int BLOCK_MAJOR_VERSION = 1;
  static const int BLOCK_MINOR_VERSION = 0;
  
  static const List<String> SEED_NODES = [
    // "your_seed_ip:9009",
  ];
  static const List<Checkpoint> CHECKPOINTS = [
    // const Checkpoint(1000, '84b6345731e2702cdaadc6ce5e5238c4ca5ecf48e3447136b2ed829b8a95f3ad'),
  ];
}