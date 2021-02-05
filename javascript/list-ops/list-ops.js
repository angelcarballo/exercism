//
// This is only a SKELETON file for the 'List Ops' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class List {
  constructor(values) {
    this.values = values || [];
  }

  append(list) {
    const start = this.length();
    for (var i=0; i < list.length(); i++) {
      this.values[start + i] = list.values[i];
    }
    return this;
  }

  concat(list) {
    const newlist = new List();
    newlist.append(this);
    for (var i=0; i < list.length(); i++) {
      newlist.append(list.values[i]);
    }
    return newlist;
  }

  filter(f) {
    const newlist = new List();
    for (var i=0; i < this.length(); i++) {
      if (f(this.values[i])) {
        newlist.values[newlist.length()] = this.values[i];
      }
    }
    return newlist;
  }

  map(f) {
    const newlist = new List();
    for (var i=0; i < this.length(); i++) {
      newlist.values[i] = f(this.values[i]);
    }
    return newlist;
  }

  length() {
    return this.values.length;
  }

  foldl(f, initial) {
    var result = initial;
    for (var i=0; i < this.length(); i++) {
      result = f(result, this.values[i]);
    }
    return result;
  }

  foldr(f, initial) {
    var result = initial;
    for (var i=this.length() -1; i >= 0; i--) {
      result = f(result, this.values[i]);
    }
    return result;
  }

  reverse() {
    const newlist = new List();
    for (var i=0; i < this.length(); i++) {
      newlist.values[i] = this.values[this.length() -1 -i];
    }
    return newlist;
  }
}
