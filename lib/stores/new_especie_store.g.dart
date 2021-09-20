// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_especie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewEspecieStore on _NewEspecieStore, Store {
  Computed<bool> _$imgValidComputed;

  @override
  bool get imgValid =>
      (_$imgValidComputed ??= Computed<bool>(() => super.imgValid,
              name: '_NewEspecieStore.imgValid'))
          .value;
  Computed<bool> _$ptValidComputed;

  @override
  bool get ptValid => (_$ptValidComputed ??=
          Computed<bool>(() => super.ptValid, name: '_NewEspecieStore.ptValid'))
      .value;
  Computed<bool> _$enValidComputed;

  @override
  bool get enValid => (_$enValidComputed ??=
          Computed<bool>(() => super.enValid, name: '_NewEspecieStore.enValid'))
      .value;
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_NewEspecieStore.formValid'))
          .value;
  Computed<Function> _$sendPressedComputed;

  @override
  Function get sendPressed =>
      (_$sendPressedComputed ??= Computed<Function>(() => super.sendPressed,
              name: '_NewEspecieStore.sendPressed'))
          .value;

  final _$ptAtom = Atom(name: '_NewEspecieStore.pt');

  @override
  String get pt {
    _$ptAtom.reportRead();
    return super.pt;
  }

  @override
  set pt(String value) {
    _$ptAtom.reportWrite(value, super.pt, () {
      super.pt = value;
    });
  }

  final _$enAtom = Atom(name: '_NewEspecieStore.en');

  @override
  String get en {
    _$enAtom.reportRead();
    return super.en;
  }

  @override
  set en(String value) {
    _$enAtom.reportWrite(value, super.en, () {
      super.en = value;
    });
  }

  final _$showErrorsAtom = Atom(name: '_NewEspecieStore.showErrors');

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

  final _$errorAtom = Atom(name: '_NewEspecieStore.error');

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

  final _$loadingAtom = Atom(name: '_NewEspecieStore.loading');

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

  final _$saveEsAtom = Atom(name: '_NewEspecieStore.saveEs');

  @override
  bool get saveEs {
    _$saveEsAtom.reportRead();
    return super.saveEs;
  }

  @override
  set saveEs(bool value) {
    _$saveEsAtom.reportWrite(value, super.saveEs, () {
      super.saveEs = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_NewEspecieStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_NewEspecieStoreActionController =
      ActionController(name: '_NewEspecieStore');

  @override
  void setPt(String value) {
    final _$actionInfo = _$_NewEspecieStoreActionController.startAction(
        name: '_NewEspecieStore.setPt');
    try {
      return super.setPt(value);
    } finally {
      _$_NewEspecieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEn(String value) {
    final _$actionInfo = _$_NewEspecieStoreActionController.startAction(
        name: '_NewEspecieStore.setEn');
    try {
      return super.setEn(value);
    } finally {
      _$_NewEspecieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_NewEspecieStoreActionController.startAction(
        name: '_NewEspecieStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_NewEspecieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pt: ${pt},
en: ${en},
showErrors: ${showErrors},
error: ${error},
loading: ${loading},
saveEs: ${saveEs},
imgValid: ${imgValid},
ptValid: ${ptValid},
enValid: ${enValid},
formValid: ${formValid},
sendPressed: ${sendPressed}
    ''';
  }
}
