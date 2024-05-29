# Flutter Story Viewer

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

Story View for Whatsapp and Instagram (works with variable video duration)

## Installation 💻

**❗ In order to start using Flutter Story Viewer you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Install via `flutter pub add`:

```sh
dart pub add flutter_story_viewer
```
Or

```yaml
dependencies:
  flutter_story_viewer: ^0.1.1
```

### 🚀 Example Usage

```dart
...
Column(
    children: <Widget>[
    SizedBox(
        height: size.height * 0.8,
        child: const FlutterStoryViewer(
        backgroundColor: Colors.grey,
        items: [
            VideoItem(
                url:
                    'https://townbox.s3.amazonaws.com/static/videos/FastApi_Websocket_Demo_2-19B0B1D7-460E-439A-B3FC-F78041DAB6A8.mp4',
            ),
            VideoItem(
                url:
                    'https://user-images.githubusercontent.com/28951144/229373709-603a7a89-2105-4e1b-a5a5-a6c3567c9a59.mp4',
            ),
            VideoItem(
                url:
                    'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
            ),
        ],
        ),
    )
    ],
)
...
```

Refer to the [`main.dart`](https://github.com/PeterAkande/flutter_story_viewer/blob/main/example/lib/main.dart) in the example.

##  Screenshots/Demo

| | |
|------|-------|
|<img src="https://github.com/PeterAkande/flutter_story_viewer//raw/main/assets/screenshot_1.png" width="250">|<img src="https://github.com/PeterAkande/flutter_story_viewer//raw/main/assets/screenshot_2.png" width="250">|

---

## 🐛 Bugs/Requests

Pull requests are well welcomed. I any request is needed, be cool to open an issue.

## Continuous Integration 🤖

Flutter Story Viewer comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---



[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
