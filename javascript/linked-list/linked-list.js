//
// This is only a SKELETON file for the 'Linked List' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class LinkedList {
  constructor() {
    this.first = null;
    this.last = null;
    this._count = 0;
  }

  push(value) {
    let new_first = new Node(value, null, this.first);
    if (this.empty()) {
      this.last = new_first
    } else {
      this.first.previous = new_first;
    }
    this.first = new_first;
    this._count++;
  }

  pop() {
    let poped = this.first;
    this.first = poped.next;
    if (poped.next) {
      poped.next.previous = null;
    } else {
      this.last = null;
    }
    this._count--;
    return poped.value;
  }

  shift() {
    let shifted = this.last;
    this.last = shifted.previous;
    if (shifted.previous) {
      shifted.previous.next = null;
    } else {
      this.first = null;
    }
    this._count--;
    return shifted.value;
  }

  unshift(value) {
    let new_last = new Node(value, this.last, null);
    if (this.empty()) {
      this.first = new_last;
    } else {
      this.last.next = new_last;
    }
    this.last = new_last;
    this._count++;
  }

  delete(value) {
    let candidate = this.first;
    do {
      if (candidate.value == value) {
        this.#do_delete(candidate);
        break;
      }
      candidate = candidate.next;
    } while (candidate);
  }

  #do_delete(node) {
    if (node.previous) {
      node.previous.next = node.next;
    } else {
      this.first = node.next;
    }
    if (node.next) {
      node.next.previous = node.previous;
    } else {
      this.last = node.previous;
    }
    this._count--;
  }

  count() {
    return this._count;
  }

  empty() {
    return this._count === 0;
  }
}

class Node {
  constructor(value, previous, next) {
    this.value = value;
    this.previous = previous;
    this.next = next;
  }
}
