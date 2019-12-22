class WordTime extends DateTime {
  String _wordMinute;
  String _wordHour;
  String _amPm;

  static const _wordNumber = [
    "midnight",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
    "twenty",
    "twenty-one",
    "twenty-two",
    "twenty-three",
    "twenty-four",
    "twenty-five",
    "twenty-six",
    "twenty-seven",
    "twenty-eight",
    "twenty-nine",
    "thirty",
    "thirty-one",
    "thirty-two",
    "thirty-three",
    "thirty-four",
    "thirty-five",
    "thirty-six",
    "thirty-seven",
    "thirty-eight",
    "thirty-nine",
    "forty",
    "forty-one",
    "forty-two",
    "forty-three",
    "forty-four",
    "forty-five",
    "forty-six",
    "forty-seven",
    "forty-eight",
    "forty-nine",
    "fifty",
    "fifty-one",
    "fifty-two",
    "fifty-three",
    "fifty-four",
    "fifty-five",
    "fifty-six",
    "fifty-seven",
    "fifty-eight",
    "fifty-nine",
  ];

  WordTime(int year,
      [int month = 1,
      int day = 1,
      int hour = 0,
      int minute = 0,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0])
      : super(
            year, month, day, hour, minute, second, millisecond, microsecond) {
    _timeToWords();
  }

  WordTime.now() : super.now() {
    _timeToWords();
  }

  void _timeToWords() {
    final m = this.minute;
    int h = this.hour;

    if (h < 12) {
      (h == 0 && m <= 30) ? _amPm = '' : _amPm = 'a.m.';
    } else {
      if (h == 12 && m <= 30) {
        _amPm = 'a.m.';
      } else {
        _amPm = 'p.m.';
        h = h % 12;
      }
    }

    if (m == 0 && h == 12) {
      _wordMinute = '';
      _wordHour = 'midday';
      _amPm = '';
    } else if (m == 0 && h == 0) {
      _wordMinute = '';
      _wordHour = 'midnight';
      _amPm = '';
    } else if (m == 0) {
      _wordHour = _wordNumber[h];
      _wordMinute = 'o\' clock';
    } else if (m == 15) {
      _wordMinute = 'quarter past';
      _wordHour = _wordNumber[h];
      if (h == 12) _amPm = '';
    } else if (m == 30) {
      _wordMinute = 'half past';
      _wordHour = _wordNumber[h];
      if (h == 12) _amPm = '';
    } else if (m == 45) {
      _wordMinute = 'quarter to';
      if (h == 11 && _amPm == 'p.m.') {
        _wordHour = (_wordNumber[0]);
      } else {
        _wordHour = (_wordNumber[h + 1]);
      }
      if (h + 1 == 12) _amPm = '';
    } else if (m <= 30) {
      _wordMinute = '${_wordNumber[m]} past';
      _wordHour = _wordNumber[h];
      if (h == 12) _amPm = '';
    } else if (m > 30) {
      _wordMinute = '${_wordNumber[60 - m]} to';
      if (h == 11 && _amPm == 'p.m.') {
        _wordHour = (_wordNumber[0]);
      } else {
        _wordHour = (_wordNumber[h + 1]);
      }
      if (h + 1 == 12) _amPm = '';
    }
  }

  String get wordMinute {
    return _wordMinute;
  }

  String get wordHour {
    return _wordHour;
  }

  String get amPm {
    return _amPm;
  }
}
