// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:os_detect/os_detect.dart" as platform;

const prettyOsNames = {
  "android": "Android",
  "browser": "a browser",
  "fuchsia": "Fuchsia",
  "ios": "iOS",
  "linux": "Linux",
  "macos": "MacOS",
  "windows": "Windows",
};

void main() {
  var osId = platform.operatingSystem;
  var osName = prettyOsNames[osId];
  var osVersionText = "";
  if (osName != null) {
    osVersionText = " (${platform.operatingSystemVersion})";
  } else {
    osName = "an unknown operating system";
  }
  var mobileText = (platform.isAndroid || platform.isIOS) ? " (mobile)" : "";

  print("Running on $osName$osVersionText$mobileText.");
}
