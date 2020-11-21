export const rows = (total_rows) => {
  let triangle = [];

  for (var row_num = 0; row_num < total_rows; row_num++) {
    triangle[row_num] = [];

    for (var pos = 0; pos <= row_num; pos++) {
      switch(pos) {
        case 0:
        case row_num:
          triangle[row_num].push(1);
          break;
        default:
          triangle[row_num].push(
            triangle[row_num - 1].slice(pos - 1, pos + 1).reduce((sum, n) => sum + n)
          );
      }
    }
  }
  return triangle;
};
