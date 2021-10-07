// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Functionality to override information about the current platform.
///
/// The main classes of the package are declared here to allow them
/// to interact with the override functionality.
library pkg.os_detect.override;

import "dart:async" show Zone, runZoned;

import "src/osid_unknown.dart"
    if (dart.library.io) "src/osid_io.dart"
    if (dart.library.html) "src/osid_html.dart";

import "src/constants.dart";

/// The name and version of an operating system.
class OperatingSystem {
  /// The current operating system ID.
  ///
  /// Defaults to what information is available
  /// from known platform specific libraries,
  /// but can be overridden using functionality from the
  /// `osid_override.dart` library.
  static OperatingSystem get current =>
      (Zone.current[#_osid] as OperatingSystem?) ?? platformOS;

  /// A string representing the operating system or platform.
  final String id;

  /// A string representing the version of the operating system or platform.
  ///
  /// May be empty if no version is known or available.
  final String version;

  /// Creates an operating system ID with the provided values.
  const OperatingSystem(this.id, this.version);
}

/// Convenience operations on [OperatingSystem].
///
/// Implemented as extensions to allow users to *implement* [OperatingSystem]
/// without having to implement all of these getters.
extension OperatingSystemGetters on OperatingSystem {
  /// Whether the operating system is a version of
  /// [Linux](https://en.wikipedia.org/wiki/Linux).
  ///
  /// Identified by [id] being the string `linux`.
  ///
  /// This value is `false` if the operating system is a specialized
  /// version of Linux that identifies itself by a different name,
  /// for example Android (see [isAndroid]).
  bool get isLinux => (idLinux == id);

  /// Whether the operating system is a version of
  /// [macOS](https://en.wikipedia.org/wiki/MacOS).
  ///
  /// Identified by [id] being the string `macos`.
  bool get isMacOS => (idMacOS == id);

  /// Whether the operating system is a version of
  /// [Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows).
  ///
  /// Identified by [id] being the string `windows`.
  bool get isWindows => (idWindows == id);

  /// Whether the operating system is a version of
  /// [Android](https://en.wikipedia.org/wiki/Android_%28operating_system%29).
  ///
  /// Identified by [id] being the string `android`.
  bool get isAndroid => (idAndroid == id);

  /// Whether the operating system is a version of
  /// [iOS](https://en.wikipedia.org/wiki/IOS).
  ///
  /// Identified by [id] being the string `ios`.
  bool get isIOS => (idIOS == id);

  /// Whether the operating system is a version of
  /// [Fuchsia](https://en.wikipedia.org/wiki/Google_Fuchsia).
  ///
  /// Identified by [id] being the string `fuchsia`.
  bool get isFuchsia => (idFuchsia == id);

  /// Whether running in a web browser.
  ///
  /// Identified by [id] being the string `browser`.
  ///
  /// If so, the [version] is the string made available
  /// through `window.navigator.appVersion`.
  bool get isBrowser => (idBrowser == id);
}

/// Run [body] in a zone with platform overrides.
///
/// Overrides [OperatingSystem.current] with the supplied [osId]
/// value while running in a new zone, and then runs [body] in that zone.
///
/// This override affects the `operatingSystem` and `version`
/// exported by `package:osid/osid.dart`.
R overrideOperatingSystem<R>(
    OperatingSystem operatingSystem, R Function() body) {
  return runZoned(body, zoneValues: {#_osid: operatingSystem});
}
