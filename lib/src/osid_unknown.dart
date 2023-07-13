// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'override.dart';

@pragma('vm:platform-const')
const String _os =
    String.fromEnvironment('dart.os.name', defaultValue: 'unknown');
const String _osVersion = String.fromEnvironment('dart.os.version');

const OperatingSystem platformOS = OperatingSystemInternal(
    _os == 'linux'
        ? LinuxOS()
        : _os == 'macos'
            ? MacOS()
            : _os == 'windows'
                ? WindowsOS()
                : _os == 'android'
                    ? AndroidOS()
                    : _os == 'ios'
                        ? IOS()
                        : _os == 'fuchsia'
                            ? FuchsiaOS()
                            : _os == 'browser'
                                ? BrowserOS()
                                : UnknownOS(_os),
    _osVersion);
