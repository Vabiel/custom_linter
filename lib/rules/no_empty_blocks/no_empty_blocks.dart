import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoEmptyBlocks extends DartLintRule {
  NoEmptyBlocks()
      : super(
    code: const LintCode(
      name: 'no_empty_blocks',
      problemMessage: 'Empty code blocks are not allowed.',
      errorSeverity: ErrorSeverity.WARNING,
    ),
  );

  @override
  void run(
      CustomLintResolver resolver,
      ErrorReporter reporter,
      CustomLintContext context,
      ) {
    context.registry.addBlock((node) {
      if (node.statements.isEmpty && node.parent is! CatchClause) {
        reporter.atNode(node, code);
      }
    });
  }
}