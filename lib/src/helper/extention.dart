extension ExtString on String? {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z\d._]+@[a-zA-Z\d]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this??"");
  }

  bool get isValidName {
    final nameRegExp = RegExp(r"^\s*([A-Za-z]+([.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this??"");
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(this??"");
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0\d{10}$");
    return phoneRegExp.hasMatch(this??"");
  }
}

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but the callback has index as second argument
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}
