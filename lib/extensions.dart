extension stickWithZero on int {
  String addZero() {
    if (this >= 0 && this <= 9)
      return '0$this';
    else
      return '$this';
  }
}

extension nameOfDay on DateTime {
  int getTwelveHourFormat() {
    if (this.hour != null && this.hour > 12)
      return (this.hour - 12);
    else
      return this.hour;
  }

  String amOrPm() {
    // if (this.hour == 0) return 'AM';
    if (this.hour > 12 && this.hour != null)
      return 'PM';
    else
      return 'AM';
  }

  String getDayName() {
    switch (this?.weekday) {
      case 1:
        {
          return 'MONDAY';
        }
        break;
      case 2:
        {
          return 'TUESDAY';
        }
        break;
      case 3:
        {
          return 'WEDNESDAY';
        }
        break;
      case 4:
        {
          return 'THURSDAY';
        }
        break;
      case 5:
        {
          return 'FRIDAY';
        }
        break;
      case 6:
        {
          return 'SATURDAY';
        }
        break;
      case 7:
        {
          return 'SUNDAY';
        }
        break;

      default:
        {
          return 'TODAY';
        }
        break;
    }
  }
}
