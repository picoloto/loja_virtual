bool emailValid(String email) {
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  return regex.hasMatch(email);
}

String emptyField(String text) => text.isEmpty ? 'Campo Obrigatório' : null;

String emptyFieldAndBoolCondition(String text, bool condition) {
  if (text.isEmpty) {
    return 'Campo Obrigatório';
  } else if (condition) {
    return 'Inválido';
  }
  return null;
}
