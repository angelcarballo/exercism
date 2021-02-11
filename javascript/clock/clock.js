//
// This is only a SKELETON file for the 'Clock' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Clock {
  constructor(hours, minutes=0) {
    const minutes_in_day = 1440;

    let total_minutes = (minutes + hours * 60) % minutes_in_day;
    if (total_minutes < 0) {
      total_minutes = minutes_in_day + total_minutes;
    }

    this._total_minutes = total_minutes;
  }

  get hours() {
    return Math.floor(this._total_minutes / 60) % 24;
  }

  get minutes() {
    return this._total_minutes % 60;
  }

  toString() {
    return `0${this.hours}`.slice(-2) + ":" + `0${this.minutes}`.slice(-2);
  }

  plus(minutes) {
    return new Clock(this.hours, this.minutes + minutes);
  }

  minus(minutes) {
    return this.plus(-minutes);
  }

  equals(clock) {
    return (this.hours == clock.hours) && (this.minutes == clock.minutes);
  }
}
