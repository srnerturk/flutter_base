# mbvn_flutter_base

Company-wide Flutter base package for design system, network layer, common widgets, error/result handling, utilities, and app configuration. Kept lightweight and framework-agnostic; no app-specific business logic.

## Installation

Add as a git dependency in your app's `pubspec.yaml`:

```yaml
dependencies:
  mbvn_flutter_base:
    git:
      url: https://github.com/your-org/mbvn_flutter_base.git
      ref: v0.1.0  # or branch: main
```

Then run `flutter pub get`.

## Usage

Single import:

```dart
import 'package:mbvn_flutter_base/mbvn_flutter_base.dart';
```

Or scoped imports:

```dart
import 'package:mbvn_flutter_base/design_system.dart';
import 'package:mbvn_flutter_base/network.dart';
import 'package:mbvn_flutter_base/widgets.dart';
import 'package:mbvn_flutter_base/error_result.dart';
import 'package:mbvn_flutter_base/utils.dart';
import 'package:mbvn_flutter_base/config.dart';
```

### Modules

| Module | Contents |
|--------|----------|
| **Design System** | `Spacing`, `AppColors`, `AppTextStyle`, `AppTheme.light()` / `AppTheme.dark()`, spacing extensions (e.g. `8.horizontal`) |
| **Network** | `AppHttpClient` (Dio-based, `Result<T>` API), auth/logging/error interceptors |
| **Widgets** | `PrimaryButton`, `AppTextField`, `AppLoadingIndicator`, `EmptyState`, `ErrorState` |
| **Error & Result** | `Result<T>`, `Success`, `Failure`, `AppError`, `AppErrorKind` |
| **Utils** | `AppLogger`, validators (`required`, `email`, `minLength`, …), formatters (`formatDate`, `formatCurrency`, …), `Debouncer` |
| **Config** | `Environment`, `AppConfig` (with `forDev`, `forUat`, `forProd`) |

### Example

```dart
// Theme
MaterialApp(
  theme: AppTheme.light(),
  darkTheme: AppTheme.dark(),
  home: MyHome(),
);

// Result-based API call
final client = AppHttpClient(
  baseUrl: config.baseUrl,
  getToken: () async => token,
);
final result = await client.getJson<MyModel>('/path', fromJson: MyModel.fromJson);
result.fold(
  (data) => use(data),
  (error) => showError(error.displayMessage),
);

// Widgets
PrimaryButton(label: 'Submit', onPressed: () {}, isLoading: false);
AppTextField(label: 'Email', hint: 'Enter email');
EmptyState(title: 'No items', onRetry: () {});
ErrorState(message: 'Failed', onRetry: () {});
```

## What this package does NOT include

- Navigation / routing
- State management (Riverpod, Bloc, etc.)
- Local persistence (shared_preferences, Hive, SQLite)
- Analytics or crash reporting
- Authentication flows (only generic auth interceptor and error types)
- App-specific APIs or DTOs
- Internationalization (formatters accept optional locale)
- Testing framework (only dev_dependencies for the package’s own tests)

## Example app

Run the example app from the package root:

```bash
cd example && flutter run
```

## Versioning

We use [semantic versioning](https://semver.org/):

- **MAJOR**: Breaking changes (removed/renamed public API, changed `Result` or `AppError` shape).
- **MINOR**: New backward-compatible modules or exports.
- **PATCH**: Bug fixes and internal refactors.

Pre-1.0 the API may still change; after 1.0 we avoid breaking changes without a MAJOR bump. Prefer adding optional parameters and new exports over changing existing signatures; deprecate before removing. See [CHANGELOG.md](CHANGELOG.md) for release notes.

## License

Private; see your organization’s policy.
