// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_about_me_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAboutMeStore on _EditAboutMeStore, Store {
  Computed<bool> _$ptValidComputed;

  @override
  bool get ptValid => (_$ptValidComputed ??= Computed<bool>(() => super.ptValid,
          name: '_EditAboutMeStore.ptValid'))
      .value;
  Computed<bool> _$enValidComputed;

  @override
  bool get enValid => (_$enValidComputed ??= Computed<bool>(() => super.enValid,
          name: '_EditAboutMeStore.enValid'))
      .value;
  Computed<bool> _$iaaPtValidComputed;

  @override
  bool get iaaPtValid =>
      (_$iaaPtValidComputed ??= Computed<bool>(() => super.iaaPtValid,
              name: '_EditAboutMeStore.iaaPtValid'))
          .value;
  Computed<bool> _$iaaEnValidComputed;

  @override
  bool get iaaEnValid =>
      (_$iaaEnValidComputed ??= Computed<bool>(() => super.iaaEnValid,
              name: '_EditAboutMeStore.iaaEnValid'))
          .value;
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_EditAboutMeStore.formValid'))
          .value;
  Computed<Function> _$sendPressedComputed;

  @override
  Function get sendPressed =>
      (_$sendPressedComputed ??= Computed<Function>(() => super.sendPressed,
              name: '_EditAboutMeStore.sendPressed'))
          .value;

  final _$ptAtom = Atom(name: '_EditAboutMeStore.pt');

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

  final _$enAtom = Atom(name: '_EditAboutMeStore.en');

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

  final _$iaaPtAtom = Atom(name: '_EditAboutMeStore.iaaPt');

  @override
  String get iaaPt {
    _$iaaPtAtom.reportRead();
    return super.iaaPt;
  }

  @override
  set iaaPt(String value) {
    _$iaaPtAtom.reportWrite(value, super.iaaPt, () {
      super.iaaPt = value;
    });
  }

  final _$iaaEnAtom = Atom(name: '_EditAboutMeStore.iaaEn');

  @override
  String get iaaEn {
    _$iaaEnAtom.reportRead();
    return super.iaaEn;
  }

  @override
  set iaaEn(String value) {
    _$iaaEnAtom.reportWrite(value, super.iaaEn, () {
      super.iaaEn = value;
    });
  }

  final _$showErrorsAtom = Atom(name: '_EditAboutMeStore.showErrors');

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

  final _$loadingAtom = Atom(name: '_EditAboutMeStore.loading');

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

  final _$errorAtom = Atom(name: '_EditAboutMeStore.error');

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

  final _$saveAboutAtom = Atom(name: '_EditAboutMeStore.saveAbout');

  @override
  bool get saveAbout {
    _$saveAboutAtom.reportRead();
    return super.saveAbout;
  }

  @override
  set saveAbout(bool value) {
    _$saveAboutAtom.reportWrite(value, super.saveAbout, () {
      super.saveAbout = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_EditAboutMeStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_EditAboutMeStoreActionController =
      ActionController(name: '_EditAboutMeStore');

  @override
  void setPt(String value) {
    final _$actionInfo = _$_EditAboutMeStoreActionController.startAction(
        name: '_EditAboutMeStore.setPt');
    try {
      return super.setPt(value);
    } finally {
      _$_EditAboutMeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEn(String value) {
    final _$actionInfo = _$_EditAboutMeStoreActionController.startAction(
        name: '_EditAboutMeStore.setEn');
    try {
      return super.setEn(value);
    } finally {
      _$_EditAboutMeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIaaPt(String value) {
    final _$actionInfo = _$_EditAboutMeStoreActionController.startAction(
        name: '_EditAboutMeStore.setIaaPt');
    try {
      return super.setIaaPt(value);
    } finally {
      _$_EditAboutMeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIaaEn(String value) {
    final _$actionInfo = _$_EditAboutMeStoreActionController.startAction(
        name: '_EditAboutMeStore.setIaaEn');
    try {
      return super.setIaaEn(value);
    } finally {
      _$_EditAboutMeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_EditAboutMeStoreActionController.startAction(
        name: '_EditAboutMeStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_EditAboutMeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pt: ${pt},
en: ${en},
iaaPt: ${iaaPt},
iaaEn: ${iaaEn},
showErrors: ${showErrors},
loading: ${loading},
error: ${error},
saveAbout: ${saveAbout},
ptValid: ${ptValid},
enValid: ${enValid},
iaaPtValid: ${iaaPtValid},
iaaEnValid: ${iaaEnValid},
formValid: ${formValid},
sendPressed: ${sendPressed}
    ''';
  }
}
