import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'rules/rules.dart';

PluginBase createPlugin() => _MyCustomLintsPlugin();

class _MyCustomLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    LintOptions? getRule(String rule) => configs.rules[rule];

    final avoidLargeMethods = getRule('avoid_large_methods');
    final noForbiddenClassNames = getRule('no_forbidden_class_names');
    final noForbiddenMethodNames = getRule('no_forbidden_method_names');

    return [
      NoNullAssert(),
      AvoidLargeMethods(maxLines: avoidLargeMethods.readParam('max_lines')),
      NoForbiddenClassNames(
        forbiddenNames: noForbiddenClassNames.readList('forbidden_names'),
      ),
      NoForbiddenMethodNames(
        forbiddenNames: noForbiddenMethodNames.readList('forbidden_names'),
      ),
      AvoidMagicNumbers(),
      PreferInkWellOverGestureDetector(),
      NoEmptyBlocks(),
    ];
  }
}

extension _LintOptionsExt on LintOptions? {
  T? readParam<T>(String param) => this?.json[param] as T?;

  List<T>? readList<T>(String param) {
    return (this?.json[param] as List?)?.map((e) => e as T).toList();
  }
}
