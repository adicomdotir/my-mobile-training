import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockito_practice_test.mocks.dart';

@GenerateMocks([Cat])
// Real class
class Cat {
  String sound() => "Meow";
  bool eatFood(String food, {bool? hungry}) => true;
  Future<void> chew() async => print("Chewing...");
  int walk(List<String> places) => 7;
  void sleep() {}
  void hunt(String place, String prey) {}
  int lives = 9;
}

void main() {
  // Create mock object.
  var cat = MockCat();

  group('Mock Cat Test', () {
    test('Stub a mock method before interacting.', () {
      // Stub a mock method before interacting.
      when(cat.sound()).thenReturn("Purr");
      expect(cat.sound(), "Purr");
      // You can call it again.
      expect(cat.sound(), "Purr");
    });

    test("Let's change the stub.", () {
      // Let's change the stub.
      when(cat.sound()).thenReturn("Meow");
      expect(cat.sound(), "Meow");
    });

    test('You can stub getters.', () {
      // You can stub getters.
      when(cat.lives).thenReturn(9);
      expect(cat.lives, 9);
    });

    test("You can stub a method to throw.", () {
      // You can stub a method to throw.
      when(cat.lives).thenThrow(RangeError('Boo'));
      expect(() => cat.lives, throwsRangeError);
    });

    test('We can calculate a response at call time.', () {
      // We can calculate a response at call time.
      var responses = ["Purr", "Meow"];
      when(cat.sound()).thenAnswer((_) => responses.removeAt(0));
      expect(cat.sound(), "Purr");
      expect(cat.sound(), "Meow");
    });
  });
}
