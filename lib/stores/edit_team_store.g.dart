// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_team_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditTeamStore on _EditTeamStore, Store {
  Computed<bool> _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_EditTeamStore.nameValid'))
          .value;
  Computed<bool> _$descriptionPtValidComputed;

  @override
  bool get descriptionPtValid => (_$descriptionPtValidComputed ??=
          Computed<bool>(() => super.descriptionPtValid,
              name: '_EditTeamStore.descriptionPtValid'))
      .value;
  Computed<bool> _$descriptionEnValidComputed;

  @override
  bool get descriptionEnValid => (_$descriptionEnValidComputed ??=
          Computed<bool>(() => super.descriptionEnValid,
              name: '_EditTeamStore.descriptionEnValid'))
      .value;
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_EditTeamStore.formValid'))
          .value;
  Computed<Function> _$sendPressedComputed;

  @override
  Function get sendPressed =>
      (_$sendPressedComputed ??= Computed<Function>(() => super.sendPressed,
              name: '_EditTeamStore.sendPressed'))
          .value;

  final _$nameAtom = Atom(name: '_EditTeamStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$descriptionPtAtom = Atom(name: '_EditTeamStore.descriptionPt');

  @override
  String get descriptionPt {
    _$descriptionPtAtom.reportRead();
    return super.descriptionPt;
  }

  @override
  set descriptionPt(String value) {
    _$descriptionPtAtom.reportWrite(value, super.descriptionPt, () {
      super.descriptionPt = value;
    });
  }

  final _$descriptionEnAtom = Atom(name: '_EditTeamStore.descriptionEn');

  @override
  String get descriptionEn {
    _$descriptionEnAtom.reportRead();
    return super.descriptionEn;
  }

  @override
  set descriptionEn(String value) {
    _$descriptionEnAtom.reportWrite(value, super.descriptionEn, () {
      super.descriptionEn = value;
    });
  }

  final _$showErrorsAtom = Atom(name: '_EditTeamStore.showErrors');

  @override
  bool get showErrors {
    _$showErrorsAtom.reportRead();
    return super.showErrors;
  }

  @override
  set showErrors(bool value) {
    _$showErrorsAtom.reportWrite(value, super.showErrors, () {
      super.showErrors = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EditTeamStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_EditTeamStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$savedTeamAtom = Atom(name: '_EditTeamStore.savedTeam');

  @override
  bool get savedTeam {
    _$savedTeamAtom.reportRead();
    return super.savedTeam;
  }

  @override
  set savedTeam(bool value) {
    _$savedTeamAtom.reportWrite(value, super.savedTeam, () {
      super.savedTeam = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_EditTeamStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_EditTeamStoreActionController =
      ActionController(name: '_EditTeamStore');

  @override
  void setNome(String value) {
    final _$actionInfo = _$_EditTeamStoreActionController.startAction(
        name: '_EditTeamStore.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_EditTeamStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescriptionPt(String value) {
    final _$actionInfo = _$_EditTeamStoreActionController.startAction(
        name: '_EditTeamStore.setDescriptionPt');
    try {
      return super.setDescriptionPt(value);
    } finally {
      _$_EditTeamStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescriptionEn(String value) {
    final _$actionInfo = _$_EditTeamStoreActionController.startAction(
        name: '_EditTeamStore.setDescriptionEn');
    try {
      return super.setDescriptionEn(value);
    } finally {
      _$_EditTeamStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_EditTeamStoreActionController.startAction(
        name: '_EditTeamStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_EditTeamStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
descriptionPt: ${descriptionPt},
descriptionEn: ${descriptionEn},
showErrors: ${showErrors},
loading: ${loading},
error: ${error},
savedTeam: ${savedTeam},
nameValid: ${nameValid},
descriptionPtValid: ${descriptionPtValid},
descriptionEnValid: ${descriptionEnValid},
formValid: ${formValid},
sendPressed: ${sendPressed}
    ''';
  }
}
