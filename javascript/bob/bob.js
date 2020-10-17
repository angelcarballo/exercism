//
// This is only a SKELETON file for the 'Bob' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const hey = (msg) => {
  if (isShouting(msg) && isQuestion(msg)) return 'Calm down, I know what I\'m doing!';
  if (isQuestion(msg)) return 'Sure.';
  if (isShouting(msg)) return 'Whoa, chill out!';
  if (isSilence(msg)) return 'Fine. Be that way!';
  return 'Whatever.';
};

function isSilence(msg) {
  return msg.match(/^\s*$/);
}

function isShouting(msg) {
  return msg.match(/[A-Z]/) && !msg.match(/[a-z]/);
}

function isQuestion(msg) {
  return msg.match(/\?\s*$/);
}
