import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferInkWellOverGestureDetector extends DartLintRule {
  PreferInkWellOverGestureDetector()
    : super(
        code: LintCode(
          name: 'prefer_ink_well_over_gesture_detector',
          problemMessage:
              'Use InkWell instead of GestureDetector if only onTap is handled.',
          errorSeverity: ErrorSeverity.WARNING,
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final constructor = node.constructorName;
      if (constructor.type.toString() == 'GestureDetector') {
        final arguments = node.argumentList.arguments;
        final hasOnTap = arguments.any(
          (arg) => arg is NamedExpression && arg.name.label.name == 'onTap',
        );
        final hasOtherCallbacks = arguments.any(
          (arg) =>
              arg is NamedExpression &&
              [
                'onDoubleTap',
                'onLongPress',
                'onPanUpdate',
                'onPanStart',
                'onPanEnd',
              ].contains(arg.name.label.name),
        );

        if (hasOnTap && !hasOtherCallbacks) {
          reporter.atNode(node, code);
        }
      }
    });
  }

  @override
  List<Fix> getFixes() => [_ReplaceGestureDetectorWithInkWellFix()];
}

class _ReplaceGestureDetectorWithInkWellFix extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (node.constructorName.type.toString() == 'GestureDetector' &&
          analysisError.sourceRange.intersects(node.sourceRange)) {
        final changeBuilder = reporter.createChangeBuilder(
          message: 'Replace GestureDetector with InkWell',
          priority: 1,
        );

        changeBuilder.addDartFileEdit((builder) {
          builder.addSimpleReplacement(
            node.constructorName.type.sourceRange,
            'InkWell',
          );
        });
      }
    });
  }
}
