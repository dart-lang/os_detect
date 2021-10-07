## 2.1.0

- Allow environment variables `dart.os.name`/`dart.os.version` to completely
  override the platform detection.
  Setting these duing production mode compilation might allow the compiler
  to recognize that the `operatingSystem` value is effectively constant
  and more eagerly remove unreachable code.
## 2.0.0

- Stable null safety release.

## 2.0.0-nullsafety.0

- Migrate to null safety.

## 1.0.0

* Initial release
