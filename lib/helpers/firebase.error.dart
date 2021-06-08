String getErrorString(String code) {
  switch (code) {
    case 'user-not-found':
      return 'Seu e-mail é inválido.';
    case 'email-already-in-use':
      return 'E-mail já está sendo utilizado em outra conta.';
    case 'wrong-password':
      return 'Sua senha está incorreta.';
    case 'user_disabled':
      return 'Este usuário foi desabilitado.';
    case 'network-request-failed':
      return 'Muitas solicitações. Tente novamente mais tarde.';

    default:
      return 'Um erro indefinido ocorreu.';
  }
}
