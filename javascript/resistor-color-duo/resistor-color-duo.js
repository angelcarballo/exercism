//
// This is only a SKELETON file for the 'Resistor Color Duo' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const decodedValue = (colors) => {
  let relevant_colors = colors.slice(0,2);
  return relevant_colors.reduce((value, color, index) => value + (colorCode(color) * numeral(index)), 0);
};

export const COLORS = ["black","brown","red","orange","yellow","green","blue","violet","grey","white"];

function colorCode(color) {
  return COLORS.indexOf(color);
};

function numeral(index) {
  return 10 ** (1 - index);
}
