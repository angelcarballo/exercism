//
// This is only a SKELETON file for the 'Secret Handshake' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
//
// 1: 1 = wink
// 2: 10 = double blink
// 4: 100 = close your eyes
// 8:  1000 = jump
// 16: 10000 = Reverse the order of the operations in the secret handshake.
//
// Given the input 3, the function would return the array
// ["wink", "double blink"] because 3 is 11 in binary.
//
// Given the input 19, the function would return the array
// ["double blink", "wink"] because 19 is 10011 in binary.

export const commands = (num) => {
  const reverse = 16;
  const ops = {
    'wink': 1,
    'double blink': 2,
    'close your eyes': 4,
    'jump': 8,
  };

  const commands = Object.keys(ops).filter((op) => ops[op] & num);
  return (reverse & num) ? commands.reverse() : commands;
};

