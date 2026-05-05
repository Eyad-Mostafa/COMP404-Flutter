import 'package:comp404_flutter/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("Validators Tests", () {

    test("empty email", () {
      expect(Validators.email(""), isNotNull);
    });

    test("invalid email format", () {
      expect(Validators.email("test"), isNotNull);
    });

    test("valid email", () {
      expect(Validators.email("test@gmail.com"), null);
    });

    test("weak password", () {
      expect(Validators.password("123"), isNotNull);
    });

    test("password missing uppercase", () {
      expect(Validators.password("abcdefg1"), isNotNull);
    });

    test("valid password", () {
      expect(Validators.password("Aa123456"), null);
    });

    test("password mismatch", () {
      expect(
        Validators.confirmPassword("123", "456"),
        isNotNull,
      );
    });

  });


}