/*
 * 
 * Create an BankAccount class have:
 * 1. Variables:  OwnerInfo,_restMoney, _password
 * 2. Methods: deposit(gửi),withdraw(rút), _checkAuth
 * 3. use getter/setter
 * 
 */

class BankAccount {
  String name;
  int _restMoney;
  int _password;
  BankAccount(this.name, this._restMoney, this._password);
  int get money => _restMoney;

  bool _checkAuth(int pw) {
    if (pw == _password) return true;
    return false;
  }

  void deposit(int money, int pw) {
    if (money > 0 && _checkAuth(pw)) {
      _restMoney += money;
      print("Deposit: $money");
      print("Accout have: $_restMoney");
    }
  }

  void withdraw(int money, int pw) {
    if (money < _restMoney && _checkAuth(pw)) {
      _restMoney -= money;
      print("Deposit: $money");
      print("Accout have: $_restMoney");
    }
  }
}

void main() {
  var long = BankAccount("long", 1000000, 060620);
  print(long.money);
  long.deposit(500000, 060620);
  long.withdraw(200000, 060620);
}
