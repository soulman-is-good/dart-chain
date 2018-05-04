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
  final LinkedList<TransactionInput> inputs;
  final LinkedList<TransactionOutput> outputs;

  Transaction(Hash fromAddress, Hash toAddress, int amount) {
    
    // find inputs by address? to find out balance???
    // find latest input 
  }
}