import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoForbiddenClassNames extends DartLintRule {
  static const _forbiddenClassNames = {'Test', 'Foo', 'Bar'};

  final Set<String> forbiddenNames;

  NoForbiddenClassNames({List<String>? forbiddenNames})
    : forbiddenNames = forbiddenNames?.toSet() ?? _forbiddenClassNames,
      super(
        code: const LintCode(
          name: 'no_forbidden_class_names',
          problemMessage:
              'Names like Test, Foo, Bar are not allowed for classes.'
              'Class name {0} is not allowed.',
          errorSeverity: ErrorSeverity.WARNING,
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final className = node.name.lexeme;
      if (forbiddenNames.contains(className)) {
        reporter.atToken(node.name, code, arguments: [className]);
      }
    });
  }
}
