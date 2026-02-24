import '../../domain/models/validation_info.dart';

class PasswordChecker {
  static int __minLength = 15;
  static int __lettersLeastCount = 1;
  static int __numbersLeastCount = 1;
  static bool __hasSpecials = true;
  static bool __hasUpperCase = true;
  static bool __hasLowerCase = true;

  static final RegExp _specialCharsRegex = RegExp(r'[$@_!?#%^&:;\/\\\]\[]');

  static final RegExp _upperCaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowerCaseRegex = RegExp(r'[a-z]');

  /// Checks if password matches all defined rules
  /// @param password password input
  /// @return [ValidationInfo] with [ValidationInfo.isValid] equals to true if password is valid; otherwise - false
  ValidationInfo checkPassword(String password) {
    if (password.length < __minLength) {
      return ValidationInfo(
        isValid: false,
        error:
            'Password should contain at least $__minLength amount of symbols',
      );
    }

    var numbersReg = RegExp(r"[0-9]");
    final numberCount = numbersReg.allMatches(password).length;
    if (numberCount < __numbersLeastCount) {
      return ValidationInfo(
        isValid: false,
        error:
            'Password should contain at least $__numbersLeastCount amount of numbers',
      );
    }

    var lttersReg = RegExp(r"[A-Za-z]");
    final letterCount = lttersReg.allMatches(password).length;
    if (letterCount < __lettersLeastCount) {
      return ValidationInfo(
        isValid: false,
        error:
            'Password should contain at least $__lettersLeastCount amount of symbols',
      );
    }

    final hasSpecial = _specialCharsRegex.allMatches(password);
    if (hasSpecial.isNotEmpty && !__hasSpecials ||
        hasSpecial.isEmpty && __hasSpecials) {
      return ValidationInfo(
        isValid: false,
        error: 'Password must contain specials',
      );
    }

    final hasUpper = _upperCaseRegex.hasMatch(password);
    if (hasUpper != __hasUpperCase) {
      return ValidationInfo(
        isValid: false,
        error: 'Password must contain upper case letters',
      );
    }

    final hasLower = _lowerCaseRegex.hasMatch(password);
    if (hasLower != __hasLowerCase) {
      return ValidationInfo(
        isValid: false,
        error: 'Password must contain lower case letters',
      );
    }

    return ValidationInfo(isValid: true);
  }

  /// Defines rules for checking password
  /// @param minLength password min length
  /// @param hasSpecials should password contain specials
  /// @param hasLowerCase should password contain lowercase letters
  /// @param hasUpperCase password contain uppercase letters
  /// @param lettersLeastCount min number of letters password must contain
  /// @param numbersLeastCount min number of numbers password must contain
  static void define({
    int minLength = 15,
    int lettersLeastCount = 1,
    int numbersLeastCount = 1,
    bool hasSpecials = true,
    bool hasUpperCase = true,
    bool hasLowerCase = true,
  }) {
    __minLength = minLength;
    __lettersLeastCount = lettersLeastCount;
    __numbersLeastCount = numbersLeastCount;
    __hasSpecials = hasSpecials;
    __hasUpperCase = hasUpperCase;
    __hasLowerCase = hasLowerCase;
  }
}
