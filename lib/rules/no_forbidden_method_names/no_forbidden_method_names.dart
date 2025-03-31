import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoForbiddenMethodNames extends DartLintRule {
  static const _forbiddenMethodNames = {'do', 'run', 'get'};

  final Set<String> forbiddenNames;

  NoForbiddenMethodNames({List<String>? forbiddenNames})
    : forbiddenNames = forbiddenNames?.toSet() ?? _forbiddenMethodNames,
      super(
        code: const LintCode(
          name: 'no_forbidden_method_names',
          problemMessage:
              'Names like do, run, get are not allowed for methods.'
              'Method name {0} is not allowed.',
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
      final methodName = node.name.lexeme;
      if (forbiddenNames.contains(methodName)) {
        reporter.atToken(node.name, code, arguments: [methodName]);
      }
    });
  }
}
