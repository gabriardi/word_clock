class WordTime extends DateTime {
  var _wordTime = {'line1': '', 'line2': '', 'amPm': ''};

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

  String get line1 {
    return _wordTime['line1'];
  }

  String get line2 {
    return _wordTime['line2'];
  }

  String get amPm {
    return _wordTime['amPm'];
  }

  void _timeToWords() {
    final m = this.minute;
    int h = this.hour;

    if (h < 12) {
      (h == 0 && m <= 30) ? _wordTime['amPm'] = '' : _wordTime['amPm'] = 'a.m.';
    } else {
      if (h == 12 && m <= 30) {
        _wordTime['amPm'] = 'a.m.';
      } else {
        _wordTime['amPm'] = 'p.m.';
        if (h != 12 || m == 45) h = h % 12;
      }
    }

    if (m == 0 && h == 12) {
      _wordTime['amPm'] = '';
      _wordTime['line1'] = 'midday';
    } else if (m == 0 && h == 0) {
      _wordTime['amPm'] = '';
      _wordTime['line1'] = 'midnight';
    } else if (m == 0) {
      _wordTime['line1'] = _wordNumber[h];
      _wordTime['line2'] = 'o\' clock';
    } else if (m == 15) {
      _wordTime['line1'] = 'quarter past';
      _wordTime['line2'] = _wordNumber[h];
      if (h == 12) _wordTime['amPm'] = '';
    } else if (m == 30) {
      _wordTime['line1'] = 'half past';
      _wordTime['line2'] = _wordNumber[h];
      if (h == 12) _wordTime['amPm'] = '';
    } else if (m == 45) {
      _wordTime['line1'] = 'quarter to';
      if (h == 11 && _wordTime['amPm'] == 'p.m.') {
        _wordTime['line2'] = _wordNumber[0];
      } else {
        _wordTime['line2'] = _wordNumber[h + 1];
      }
      if (h + 1 == 12) _wordTime['amPm'] = '';
    } else if (m < 10) {
      if (h == 12 || h == 0) _wordTime['amPm'] = '';
      _wordTime['line1'] = _wordNumber[h];
      _wordTime['line2'] = 'oh ${_wordNumber[m]}';
    } else {
      if (h == 12 || h == 0) _wordTime['amPm'] = '';
      _wordTime['line1'] = _wordNumber[h];
      _wordTime['line2'] = _wordNumber[m];
    }
  }
}
