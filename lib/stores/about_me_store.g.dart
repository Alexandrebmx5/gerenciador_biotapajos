// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_me_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AboutMeStore on _AboutMeStore, Store {
  final _$aboutMeHistoricAtom = Atom(name: '_AboutMeStore.aboutMeHistoric');

  @override
  AboutMeHistoric get aboutMeHistoric {
    _$aboutMeHistoricAtom.reportRead();
    return super.aboutMeHistoric;
  }

  @override
  set aboutMeHistoric(AboutMeHistoric value) {
    _$aboutMeHistoricAtom.reportWrite(value, super.aboutMeHistoric, () {
      super.aboutMeHistoric = value;
    });
  }

  final _$teamAtom = Atom(name: '_AboutMeStore.team');

  @override
  List<Team> get team {
    _$teamAtom.reportRead();
    return super.team;
  }

  @override
  set team(List<Team> value) {
    _$teamAtom.reportWrite(value, super.team, () {
      super.team = value;
    });
  }

  final _$collaboratorsAtom = Atom(name: '_AboutMeStore.collaborators');

  @override
  List<Collaborators> get collaborators {
    _$collaboratorsAtom.reportRead();
    return super.collaborators;
  }

  @override
  set collaborators(List<Collaborators> value) {
    _$collaboratorsAtom.reportWrite(value, super.collaborators, () {
      super.collaborators = value;
    });
  }

  final _$partnerInstitutionsAtom =
      Atom(name: '_AboutMeStore.partnerInstitutions');

  @override
  PartnerInstitutions get partnerInstitutions {
    _$partnerInstitutionsAtom.reportRead();
    return super.partnerInstitutions;
  }

  @override
  set partnerInstitutions(PartnerInstitutions value) {
    _$partnerInstitutionsAtom.reportWrite(value, super.partnerInstitutions, () {
      super.partnerInstitutions = value;
    });
  }

  final _$loadingAtom = Atom(name: '_AboutMeStore.loading');

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

  @override
  String toString() {
    return '''
aboutMeHistoric: ${aboutMeHistoric},
team: ${team},
collaborators: ${collaborators},
partnerInstitutions: ${partnerInstitutions},
loading: ${loading}
    ''';
  }
}
