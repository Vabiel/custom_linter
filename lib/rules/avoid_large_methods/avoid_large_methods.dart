import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidLargeMethods extends DartLintRule {
  static const _defaultMaxLines = 100;

  final int maxLines;

  AvoidLargeMethods({int? maxLines})
    : maxLines = maxLines ?? _defaultMaxLines,
      super(
        code: const LintCode(
          name: 'avoid_large_methods',
          problemMessage:
              'Avoid methods with many lines. '
              'The method contains {0} lines, maximum {1}.',
          errorSeverity: ErrorSeverity.WARNING,
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodDeclaration((node) {
      if (node.isAbstract) return;

      final startLine = resolver.lineInfo.getLocation(node.offset).lineNumber;
      final endLine = resolver.lineInfo.getLocation(node.end).lineNumber;
      final lineCount = endLine - startLine + 1;

      if (lineCount > maxLines) {
        reporter.atNode(node, code, arguments: [lineCount, maxLines]);
      }
    });
  }
}
