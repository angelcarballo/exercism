//
// This is only a SKELETON file for the 'Grade School' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class GradeSchool {
  constructor() {
     this._students = {};
  }

  roster() {
    return this.grades().reduce((obj, grade) => {
      obj[grade] = this.grade(grade);
      return obj;
    }, {})
  }

  add(student, grade) {
    this._students[student] = grade;
  }

  grades() {
    return [...new Set(Object.values(this._students))];
  }

  grade(grade) {
    return Object.keys(this._students)
      .filter(g => this._students[g] == grade)
      .sort();
  }
}
