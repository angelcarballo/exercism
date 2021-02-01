//
// This is only a SKELETON file for the 'Bank Account' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class BankAccount {
  constructor() {
    this._balance = 0;
    this._status = 'new';
  }

  open() {
    if (this._status == 'open')
      throw new ValueError();
    this._status = 'open';
  }

  close() {
    if (this._status != 'open')
      throw new ValueError();
    this._balance = 0;
    this._status = 'closed';
  }

  deposit(amount) {
    if (amount < 0 || this._status != 'open')
      throw new ValueError();
    this._balance += amount;
  }

  withdraw(amount) {
    if (amount < 0 || amount > this._balance || this._status != 'open')
      throw new ValueError();
    this._balance -= amount;
  }

  get balance() {
    if (this._status != 'open')
      throw new ValueError();
    return this._balance;
  }
}

export class ValueError extends Error {
  constructor() {
    super('Bank account error');
  }
}
