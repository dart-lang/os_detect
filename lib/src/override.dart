// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Functionality to override information about the current platform.
library pkg.os_detect.src.override;

import 'dart:async' show Zone, runZoned;

import 'package:meta/meta.dart';

import 'osid_unknown.dart'
    if (dart.library.io) 'osid_io.dart'
    if (dart.library.html) 'osid_html.dart';

/// The name and version of an operating system.
final class OperatingSystem {
  /// The current operating system ID.
  ///
  /// Defaults to what information is available
  /// from known platform specific libraries,
  /// but can be overridden using functionality from the
  /// `osid_override.dart` library.
  @pragma('vm:try-inline')
  static OperatingSystem get current =>
      Zone.current[#_os] as OperatingSystem? ?? platformOS;

  /// A string representing the operating system or platform.
  String get id => _osId.id;

  // Operating system ID object.
  final OS _osId;

  /// A string representing the version of the operating system or platform.
  ///
  /// May be empty if no version is known or available.
  final String version;

  /// Creates a new operating system object for testing.
  ///
  /// Can be used with [overrideOperatingSystem] to selectively
  /// change the value returned by [current].
  ///
  /// **Notice:** Using this constructor may reduce the efficiency
  /// of compilers recognizing code that isn't needed when compiling
  /// for a particular platform (aka. "tree-shaking" of unreachable code).
  @visibleForTesting
  @pragma('vm:prefer-inline')
  OperatingSystem(String id, String version)
      : this._(
            id == 'linux'
                ? const LinuxOS()
                : id == 'macos'
                    ? const MacOS()
                    : id == 'windows'
                        ? const WindowsOS()
                        : id == 'android'
                            ? const AndroidOS()
                            : id == 'ios'
                                ? const IOS()
                                : id == 'fuchsia'
                                    ? const FuchsiaOS()
                                    : id == 'browser'
                                        ? const BrowserOS()
                                        : UnknownOS(id),
            version);

  /// Used by platforms which know the ID object.
  const OperatingSystem._(this._osId, this.version);

  /// Whether the operating system is a version of
  /// [Linux](https://en.wikipedia.org/wiki/Linux).
  ///
  /// Identified by [id] being the string `linux`.
  ///
  /// This value is `false` if the operating system is a specialized
  /// version of Linux that identifies itself by a different name,
  /// for example Android (see [isAndroid]).
  bool get isLinux => _osId is LinuxOS;

  /// Whether the operating system is a version of
  /// [macOS](https://en.wikipedia.org/wiki/MacOS).
  ///
  /// Identified by [id] being the string `macos`.
  bool get isMacOS => _osId is MacOS;

  /// Whether the operating system is a version of
  /// [Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows).
  ///
  /// Identified by [id] being the string `windows`.
  bool get isWindows => _osId is WindowsOS;

  /// Whether the operating system is a version of
  /// [Android](https://en.wikipedia.org/wiki/Android_%28operating_system%29).
  ///
  /// Identified by [id] being the string `android`.
  bool get isAndroid => _osId is AndroidOS;

  /// Whether the operating system is a version of
  /// [iOS](https://en.wikipedia.org/wiki/IOS).
  ///
  /// Identified by [id] being the string `ios`.
  bool get isIOS => _osId is IOS;

  /// Whether the operating system is a version of
  /// [Fuchsia](https://en.wikipedia.org/wiki/Google_Fuchsia).
  ///
  /// Identified by [id] being the string `fuchsia`.
  bool get isFuchsia => _osId is FuchsiaOS;

  /// Whether running in a web browser.
  ///
  /// Identified by [id] being the string `browser`.
  ///
  /// If so, the [version] is the string made available
  /// through `window.navigator.appVersion`.
  bool get isBrowser => _osId is BrowserOS;
}

// Exposes the `OperatingSystem._` constructor to the conditionally imported
// libraries.
final class OperatingSystemInternal extends OperatingSystem {
  const OperatingSystemInternal(super.id, super.version) : super._();
}

/// Operating identity object.
///
/// By only instantiating these subtypes guarded by target-OS guarded
/// checks, unless using the "for testing" [OperatingSystem] constructor,
/// all but one of the subclasses should be tree-shaken,
/// and, e.g., the `_isId is IOS` test above should become tree-shakable
/// on all other platforms.
sealed class OS {
  const OS();
  abstract final String id;
}

/// Operations system object for Linux.
class LinuxOS extends OS {
  @override
  final String id = 'linux';
  const LinuxOS();
}

/// Operations system object for MacOS.
class MacOS extends OS {
  @override
  final String id = 'macos';
  const MacOS();
}

/// Operations system object for Windows.
class WindowsOS extends OS {
  @override
  final String id = 'windows';
  const WindowsOS();
}

/// Operations system object for Android.
class AndroidOS extends OS {
  @override
  final String id = 'android';
  const AndroidOS();
}

/// Operations system object for iOS.
class IOS extends OS {
  @override
  final String id = 'ios';
  const IOS();
}

/// Operations system object for Fuchsia.
class FuchsiaOS extends OS {
  @override
  final String id = 'fuchsia';
  const FuchsiaOS();
}

/// Operations system object for browsers.
class BrowserOS extends OS {
  @override
  final String id = 'browser';
  const BrowserOS();
}

/// Fallback to represent unknown operating system.
///
/// Do not use for one of the recognized operating
/// systems
class UnknownOS extends OS {
  @override
  final String id;
  const UnknownOS(this.id)
      : assert(id != 'linux'),
        assert(id != 'macos'),
        assert(id != 'windows'),
        assert(id != 'android'),
        assert(id != 'ios'),
        assert(id != 'fuchsia'),
        assert(id != 'browser');
}

/// Run [body] in a zone with platform overrides.
///
/// Overrides [OperatingSystem.current] with the supplied [operatingSystem]
/// value while running in a new zone, and then runs [body] in that zone.
///
/// This override affects the `operatingSystem` and `version`
/// exported by `package:osid/osid.dart`.
R overrideOperatingSystem<R>(
        OperatingSystem operatingSystem, R Function() body) =>
    runZoned(body, zoneValues: {#_os: operatingSystem});
