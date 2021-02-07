// This is only a SKELETON file for the 'Robot Name' exercise. It's been
// provided as a convenience to get your started writing code faster.

export class Robot {
  static names = [];

  constructor() {
    this.reset();
  }

  reset() {
    let newname = null;
    do {
      newname = randomName();
    } while(Robot.names.includes(newname));
    this._name = newname;
    Robot.names.push(newname);
  }

  get name() {
    return this._name;
  }
}

function randomName() {
  return randomLetter() + randomLetter() + randomNumber(9) + randomNumber(9) + randomNumber(9);
}

function randomNumber(max) {
  return Math.round(Math.random() * max);
}


function randomLetter() {
  // 65: A, 90: Z
  return String.fromCharCode(65 + randomNumber(25));
}

Robot.releaseNames = () => {};
