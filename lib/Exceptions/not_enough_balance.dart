class NotEnoughBalance implements Exception {
  
  @override
  String toString() {
    return "Not enough balance to proccess transaction";
  }
}
