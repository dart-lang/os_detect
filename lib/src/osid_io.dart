// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'override.dart';

@pragma('vm:platform-const')
final OS? _osType = Platform.operatingSystem == 'linux'
    ? const LinuxOS()
    : Platform.operatingSystem == 'macos'
        ? const MacOS()
        : Platform.operatingSystem == 'windows'
            ? const WindowsOS()
            : Platform.operatingSystem == 'android'
                ? const AndroidOS()
                : Platform.operatingSystem == 'ios'
                    ? const IOS()
                    : Platform.operatingSystem == 'fuchsia'
                        ? const FuchsiaOS()
                        : Platform.operatingSystem == 'browser'
                            ? const BrowserOS()
                            : null;

final OperatingSystem platformOS = OperatingSystemInternal(
    _osType ?? UnknownOS(Platform.operatingSystem),
    Platform.operatingSystemVersion);
