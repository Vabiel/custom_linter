import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidMagicNumbers extends DartLintRule {
  AvoidMagicNumbers()
    : super(
        code: const LintCode(
          name: 'avoid_magic_numbers',
          problemMessage:
              'Avoid magic numbers, use constants. '
              'Replace {0} with a named constant.',
          errorSeverity: ErrorSeverity.WARNING,
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addIntegerLiteral((node) {
      final value = node.value;
      if (value != null && value != 0 && value != 1) {
        reporter.atNode(node, code, arguments: [value]);
      }
    });

    context.registry.addDoubleLiteral((node) {
      reporter.atNode(node, code, arguments: [node.value]);
    });
  }
}
