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
  ];

// TODO DEBUG
  WordTime(int hour, int minute)
      : super(
          2019,
          1,
          1,
          hour,
          minute,
        ) {
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
        _amPm = '';
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
    } else if (m == 30) {
      _wordMinute = 'half past';
      _wordHour = _wordNumber[h];
    } else if (m == 45) {
      _wordMinute = 'quarter to';
      _wordHour = (_wordNumber[h + 1]);
    } else if (m <= 30) {
      _wordMinute = '${_wordNumber[m]} past';
      _wordHour = _wordNumber[h];
    } else if (m > 30) {
      _wordMinute = '${_wordNumber[60 - m]} to';
      _wordHour = _wordNumber[h + 1];
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
