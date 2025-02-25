/*
 * 
 * Create an BankAccount class have:
 * 1. Variables:  OwnerInfo,_restMoney, _password
 * 2. Methods: deposit(gửi),withdraw(rút), _checkAuth
 *  3. use getter/setter
 * 
 */

class BankAccount {
  String name;
  int _restMoney = 0;
  int _password = 0;

  BankAccount({
    required this.name,
    required int setMoney,
    required int setPassword,
  }) {
    this._restMoney = setMoney;
    this._password = setPassword;
  }
  // Because main and class BankAccount in same file so main can read private properties
  // But if main and class BA in 2 differrent file, need to use getter and setter to read private properties
  // And contructor need to use setter getter too, or use:
  // BankAccount({required this.name, required int setMoney, required int setPassword})
  //     : _restMoney = setMoney,
  //       _password = setPassword;
  int get getMoney => _restMoney;
  set setMoney(int value) {
    _restMoney = value;
  }

  set setPassword(int value) => _password = value;
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
      print("Withdraw: $money");
      print("Accout have: $_restMoney");
    }
  }
}

void main() {
  var long = BankAccount(name: "long", setMoney: 1, setPassword: 060620);
  print(long.getMoney);

  long.deposit(500000, 060620);
  long.withdraw(200000, 060620);
}
