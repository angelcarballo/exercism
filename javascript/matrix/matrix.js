//
// This is only a SKELETON file for the 'Matrix' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Matrix {
  constructor(matrix_as_string) {
    this.rows =
      matrix_as_string.split('\n').map(row => row.split(' ').map(char => parseInt(char)));
    this.columns =
      this.rows[0].map((_, columnIndex) => this.rows.map(row => row[columnIndex]));
  }
}
