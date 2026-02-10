# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Initial implementation of all six modules.

## [0.1.0] - Initial release

### Added

- **Design System**: Spacing constants and extensions, `AppColors`, `AppTextStyle`, `AppTheme.light()` / `AppTheme.dark()`.
- **Network**: `AppHttpClient` (Dio-based), auth/logging/error interceptors, `Result<T>` API (`get`, `post`, `put`, `delete`, `getJson`).
- **Widgets**: `PrimaryButton`, `AppTextField`, `AppLoadingIndicator`, `EmptyState`, `ErrorState`.
- **Error & Result**: `Result<T>`, `Success`, `Failure`, `AppError`, `AppErrorKind`, `displayMessage`.
- **Utils**: `AppLogger` (env-aware), validators (`required`, `email`, `minLength`, `maxLength`, `pattern`, `combine`), formatters (`formatDate`, `formatDateTime`, `formatDecimal`, `formatCurrency`), `Debouncer`.
- **Config**: `Environment` (dev/uat/prod/test), `AppConfig` with `forDev`, `forUat`, `forProd`.
- Example app demonstrating theme, widgets, Result-based API call, and empty/error states.
- Single barrel export (`package:mbvn_flutter_base/mbvn_flutter_base.dart`) and scoped exports (`design_system.dart`, `network.dart`, etc.).

[Unreleased]: https://github.com/your-org/mbvn_flutter_base/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/your-org/mbvn_flutter_base/releases/tag/v0.1.0
