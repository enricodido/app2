class Validation {
  bool username(value) {
    if (value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool password(value) {
    if (value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool empty({required String value}) {
    if (value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
