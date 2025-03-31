# Custom Linter

<p align="center">
  <strong>A Set of Custom Linting Rules for Dart and Flutter</strong><br>
  Designed to improve code quality and enforce development standards.
</p>

<p align="center">
  <a href="LICENSE">BSD 3-Clause License</a>
</p>

---

## About

`custom_linter` is a package of custom linting rules built using [custom_lint](https://pub.dev/packages/custom_lint). It helps developers maintain clean and readable code in Dart and Flutter projects by detecting potential issues such as magic numbers, empty blocks, or commented-out code.

The project includes the following rules:
- **`no_null_assert`**: Prohibits the use of the `!` operator for null assertion.
- **`avoid_large_methods`**: Limits the size of methods to a specified number of lines.
- **`no_forbidden_class_names`**: Disallows the use of specific class names.
- **`no_forbidden_method_names`**: Disallows the use of specific method names.
- **`avoid_magic_numbers`**: Requires replacing magic numbers with named constants.
- **`prefer_ink_well_over_gesture_detector`**: Recommends using `InkWell` over `GestureDetector` for simple tap events.
- **`no_empty_blocks`**: Prohibits empty code blocks (excluding those with comments).

---

## Installation

### 1. Setting Up the `custom_linter` Package
If you want to use this project as a standalone package:

1. Clone the repository:
```bash
  git clone <repository_url>
  cd custom_linter
```
2. Install dependencies:
```bash
  dart pub get
```

### 2. Adding to Your Project
Add `custom_lint` and `custom_linter` to your application's `pubspec.yaml`:
```yaml
dev_dependencies:
  custom_lint: ^0.7.0
  custom_linter:
    path: ../custom_linter  # Specify the path to the custom_linter folder
```

### 3. Configuring `analysis_options.yaml`
Enable the `custom_lint` plugin and activate the desired rules:
```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - no_null_assert
    - no_empty_blocks
    - avoid_magic_numbers
    - prefer_ink_well_over_gesture_detector
    - no_forbidden_class_names:
        forbidden_names: [Test, Demo, Example]
    - no_forbidden_method_names:
        forbidden_names: [execute, perform, fetch]
    - avoid_large_methods:
        max_lines: 5
```

## Usage

1. After setup, run:
```bash
  flutter pub get
```   

2. Analyze your code:
```bash
  flutter pub run custom_lint
```   

3. Check the console or IDE output for lint violations.

## Rule Descriptions

### `no_null_assert`
- **Description**: Prohibits the use of the `!` operator for null assertion to avoid potential `NullPointerException`s.
- **Example**: `String? s; print(s!);` → Triggers a warning.

### `avoid_large_methods`
- **Description**: Limits the maximum number of lines in a method (default is 100, configurable via `max_lines`).
- **Example**: A method with 6 lines with `max_lines: 5` triggers a warning.

### `no_forbidden_class_names`
- **Description**: Disallows the use of specified class names (configurable via `forbidden_names`).
- **Example**: `class Test {}` → Triggers if `Test` is in the forbidden list.

### `no_forbidden_method_names`
- **Description**: Disallows the use of specified method names (configurable via `forbidden_names`).
- **Example**: `void execute() {}` → Triggers if `execute` is forbidden.

### `avoid_magic_numbers`
- **Description**: Requires replacing numbers (except 0 and 1) with named constants.
- **Example**: `var x = 42;` → Triggers a warning.

### `prefer_ink_well_over_gesture_detector`
- **Description**: Recommends using `InkWell` instead of `GestureDetector` for simple tap events to provide visual feedback.
- **Example**: `GestureDetector(onTap: () {}, child: Text('Tap'))` → Triggers.

### `no_empty_blocks`
- **Description**: Prohibits empty code blocks but ignores blocks with comments.
- **Example**: `if (true) {}` → Triggers; `if (true) { // comment }` → Does not trigger.

## Debugging

To enable debug output, add the following to `analysis_options.yaml`:

custom_lint:
debug: true
verbose: true

Logs will be written to `custom_lint.log` next to `pubspec.yaml`.

## Testing

An example project is provided in the [`example`](./example) directory at the root of this project to demonstrate rule violations and expected lints. To test the rules, navigate to the `example` directory and run the following:

flutter pub get

Then analyze the code:

flutter pub run custom_lint

If expected lints do not trigger, the command will fail. Check the `example/lib/main.dart` file for sample code with annotated violations.