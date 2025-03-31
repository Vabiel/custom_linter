import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoNullAssert extends DartLintRule {
  NoNullAssert()
    : super(
        code: const LintCode(
          name: 'no_null_assert',
          problemMessage:
              'Avoid using the null assert statement (!). '
              'This can lead to runtime errors.',
          errorSeverity: ErrorSeverity.WARNING,
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addPostfixExpression((node) {
      if (node.operator.type == TokenType.BANG) {
        reporter.atNode(node, code);
      }
    });
  }

  @override
  List<Fix> getFixes() => [
    _RemoveNullAssertFix(),
    _ReplaceWithQuestionDotFix(),
  ];
}

class _RemoveNullAssertFix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addPostfixExpression((node) {
      if (node.operator.type == TokenType.BANG &&
          analysisError.sourceRange.intersects(node.sourceRange)) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Remove null assert statement',
          priority: 1,
        );
        changeBuilder.addDartFileEdit((builder) {
          builder.addDeletion(SourceRange(node.operator.offset, 1));
        });
      }
    });
  }
}

class _ReplaceWithQuestionDotFix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addPostfixExpression((node) {
      if (node.operator.type == TokenType.BANG &&
          analysisError.sourceRange.intersects(node.sourceRange)) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Replace ! with ?.',
          priority: 2,
        );
        changeBuilder.addDartFileEdit((builder) {
          builder.addSimpleReplacement(
            SourceRange(node.operator.offset, 1),
            '?.',
          );
        });
      }
    });
  }
}
