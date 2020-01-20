// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';

import './models/word_time.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color.fromRGBO(245, 245, 245, 1),
  _Element.text: Color.fromRGBO(33, 33, 33, 1),
};

final _darkTheme = {
  _Element.background: Color.fromRGBO(33, 33, 33, 1),
  _Element.text: Color.fromRGBO(135, 135, 135, 1),
};

class WordClock extends StatefulWidget {
  const WordClock(this.model);

  final ClockModel model;

  @override
  _WordClockState createState() => _WordClockState();
}

class _WordClockState extends State<WordClock> {
  WordTime _wordTime = WordTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(WordClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _wordTime = WordTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _wordTime.second) -
            Duration(milliseconds: _wordTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      //   _timer = Timer(
      //     Duration(seconds: 1) - Duration(milliseconds: _wordTime.millisecond),
      //     _updateTime,
      //   );
    });
  }

  @override
  Widget build(BuildContext context) {
    const _maxFontSize = 60.0;
    const _mainFont = 'JuliusSansOne';
    const _secondaryFont = 'Roboto';

    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    final defaultStyle = TextStyle(
      color: colors[_Element.text],
    );

    return Container(
      color: colors[_Element.background],
      child: DefaultTextStyle(
        style: defaultStyle,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // top left corner
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'it\'s',
                    style: TextStyle(
                      fontFamily: _secondaryFont,
                      fontSize: _maxFontSize,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  child: Text(
                    _wordTime.line1,
                    style: TextStyle(
                      fontFamily: _mainFont,
                    ),
                  ),
                ),
              ),
              _wordTime.line2 == ''
                  ? Container()
                  : Expanded(
                      flex: 2,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        child: Text(
                          _wordTime.line2,
                          style: TextStyle(
                            fontFamily: _mainFont,
                          ),
                        ),
                      ),
                    ),
              // Bottom right corner shows a.m. or p.m. in case needed
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _wordTime.amPm,
                    style: TextStyle(
                      fontFamily: _secondaryFont,
                      fontSize: _maxFontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
