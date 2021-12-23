// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_partner_institutions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditPartnerInstitutionsStore on _EditPartnerInstitutionsStore, Store {
  Computed<bool> _$imgValidComputed;

  @override
  bool get imgValid =>
      (_$imgValidComputed ??= Computed<bool>(() => super.imgValid,
              name: '_EditPartnerInstitutionsStore.imgValid'))
          .value;
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_EditPartnerInstitutionsStore.formValid'))
          .value;
  Computed<Function> _$sendPressedComputed;

  @override
  Function get sendPressed =>
      (_$sendPressedComputed ??= Computed<Function>(() => super.sendPressed,
              name: '_EditPartnerInstitutionsStore.sendPressed'))
          .value;

  final _$showErrorsAtom =
      Atom(name: '_EditPartnerInstitutionsStore.showErrors');

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

  final _$loadingAtom = Atom(name: '_EditPartnerInstitutionsStore.loading');

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

  final _$errorAtom = Atom(name: '_EditPartnerInstitutionsStore.error');

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

  final _$savePartnersAtom =
      Atom(name: '_EditPartnerInstitutionsStore.savePartners');

  @override
  bool get savePartners {
    _$savePartnersAtom.reportRead();
    return super.savePartners;
  }

  @override
  set savePartners(bool value) {
    _$savePartnersAtom.reportWrite(value, super.savePartners, () {
      super.savePartners = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_EditPartnerInstitutionsStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_EditPartnerInstitutionsStoreActionController =
      ActionController(name: '_EditPartnerInstitutionsStore');

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_EditPartnerInstitutionsStoreActionController
        .startAction(name: '_EditPartnerInstitutionsStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_EditPartnerInstitutionsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showErrors: ${showErrors},
loading: ${loading},
error: ${error},
savePartners: ${savePartners},
imgValid: ${imgValid},
formValid: ${formValid},
sendPressed: ${sendPressed}
    ''';
  }
}
