class TransactionOutput {
  final int amount;
  final String publicKey;
  
  TransactionOutput(this.amount, this.publicKey);
}

class TransactionInput {
  final int amount;
  final int prevOutIndex;
}


class Transaction {
  final int version;
  final int unlockTime;
  final List<TransactionInput> inputs;
  final List<TransactionOutput> outputs;
  
  bool operator== (Transaction a, Transaction b) {
    if (a.version == b.version && a.)
  }
}