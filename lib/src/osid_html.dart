// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'override.dart';

String get _osVersion => window.navigator.appVersion;

final OperatingSystem platformOS =
    OperatingSystemInternal(const BrowserOS(), _osVersion);
