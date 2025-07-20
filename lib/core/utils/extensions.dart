extension StringExt on String {
  bool get isEmail => RegExp(r'^\S+@\S+\.\S+\$').hasMatch(this);
}
