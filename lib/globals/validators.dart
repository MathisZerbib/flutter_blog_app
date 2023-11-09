class Validator {
  static String? isMessage(String? value) {
    if (value!.length > 512) {
      return 'Ce champ doit contenir maximum 512 charactères.';
    } else if (value.isEmpty) {
      return 'Ce champ doit contenir minimum 1 charactères.';
    }
    return null;
  }
}
