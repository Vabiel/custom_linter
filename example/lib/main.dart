import 'package:flutter/material.dart';

void main() {
  String? nullableString;
  // expect: no_null_assert
  debugPrint(nullableString!);

  runApp(MaterialApp(home: Scaffold(body: MyWidget())));
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expect: prefer_ink_well_over_gesture_detector
        GestureDetector(
          onTap: () => debugPrint('Tapped'),
          child: const Text('Tap me'),
        ),
        GestureDetector(
          onTap: () => debugPrint('Tapped'),
          onDoubleTap: () => debugPrint('Double tapped'),
          // Линт не должен сработать
          child: const Text('Tap or double tap me'),
        ),
      ],
    );
  }
}

// expect: no_forbidden_class_names
class Demo {
  void doSomething() {
    // expect: avoid_magic_numbers
    var magic = 42;
    debugPrint(magic.toString());
  }

  // expect: no_forbidden_method_names
  void execute() {
    debugPrint('Execute Order 66');
  }

  // expect: no_empty_blocks
  void empty() {}

  // expect: avoid_large_methods
  void bubbleSort(List<int> numbers) {
    debugPrint("Initial list: $numbers");
    var n = numbers.length;
    bool swapped;

    do {
      swapped = false;

      for (int i = 0; i < n - 1; i++) {
        if (numbers[i] > numbers[i + 1]) {
          int temp = numbers[i];
          numbers[i] = numbers[i + 1];
          numbers[i + 1] = temp;
          swapped = true;
        }
      }
      n--;
    } while (swapped);

    debugPrint("Sorted list: $numbers");
  }
}
