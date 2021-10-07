// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The string used to identify the Linux operating system.
const String idLinux = "linux";

/// The string used to identify the MacOS operating system.
const String idMacOS = "macos";

/// The string used to identify the Windows operating system.
const String idWindows = "windows";

/// The string used to identify the Android operating system.
const String idAndroid = "android";

/// The string used to identify the IOS operating system.
const String idIOS = "ios";

/// The string used to identify the Fuchsia operating system.
const String idFuchsia = "fuchsia";

/// The string used to identify the browser environment.
const String idBrowser = "browser";

/// Key used to look up an OS ID override in the compilation environment.
const osEnvironmentKey = "dart.os.name";

/// Key used to look up an OS version override in the compilation environment.
const osVersionEnvironmentKey = "dart.os.version";

/// A compilation environment override of the platform detection.
///
/// If set, it should match the actual platform being compiled to.
/// The compiler may be able to recognize that the
/// value of [operatingSystem] and of getters like [isLinux]
/// are a constant when this value is set.
const String? environmentOSNameOverride = bool.hasEnvironment(osEnvironmentKey)
    ? String.fromEnvironment(osEnvironmentKey)
    : null;

/// A compilation environment override of the platform version detection.
///
/// If set, it should match the actual platform version being compiled to.
/// The compiler may be able to recognize that the
/// value of [operatingSystemVersion] is a constant when the value is
/// set.
const String? environmentOSVersionOverride =
    bool.hasEnvironment(osVersionEnvironmentKey)
        ? String.fromEnvironment(osVersionEnvironmentKey)
        : null;

/// A compilation environment override of the platform detection of Linux.
const bool? environmentIsLinuxOverride = bool.hasEnvironment(osEnvironmentKey)
    ? String.fromEnvironment(osEnvironmentKey) == idLinux
    : null;

/// A compilation environment override of the platform detection of MacOS.
const bool? environmentIsMacOSOverride = bool.hasEnvironment(osEnvironmentKey)
    ? String.fromEnvironment(osEnvironmentKey) == idMacOS
    : null;

/// A compilation environment override of the platform detection of Windows.
const bool? environmentIsWindowsOverride = bool.hasEnvironment(osEnvironmentKey)
    ? String.fromEnvironment(osEnvironmentKey) == idWindows
    : null;

/// A compilation environment override of the platform detection of Android.
const bool? environmentIsAndroidOverride = bool.hasEnvironment(osEnvironmentKey)
    ? String.fromEnvironment(osEnvironmentKey) == idAndroid
    : null;

/// A compilation environment override of the platform detection of IOS.
const bool? environmentIsIOSOverride = bool.hasEnvironment(osEnvironmentKey)
    ? String.fromEnvironment(osEnvironmentKey) == idIOS
    : null;

/// A compilation environment override of the platform detection of Fuchsia.
const bool? environmentIsFuchsiaOverride = bool.hasEnvironment(osEnvironmentKey)
    ? String.fromEnvironment(osEnvironmentKey) == idFuchsia
    : null;

/// A compilation environment override of the platform detection of a browser.
const bool? environmentIsBrowserOverride = bool.hasEnvironment(osEnvironmentKey)
    ? String.fromEnvironment(osEnvironmentKey) == idBrowser
    : null;
