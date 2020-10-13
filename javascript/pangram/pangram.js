//
// This is only a SKELETON file for the 'Pangram' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isPangram = (sentence) => {
  const letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
  return letters.every((letter) => sentence.toLowerCase().includes(letter));
};
