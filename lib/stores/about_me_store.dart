import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerenciador_aquifero/models/about_me/about_me_historic.dart';
import 'package:gerenciador_aquifero/models/about_me/collaborators.dart';
import 'package:gerenciador_aquifero/models/about_me/partner_institutions.dart';
import 'package:gerenciador_aquifero/models/about_me/team.dart';
import 'package:mobx/mobx.dart';

part 'about_me_store.g.dart';

class AboutMeStore = _AboutMeStore with _$AboutMeStore;

abstract class _AboutMeStore with Store {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  _AboutMeStore() {
    _getAboutMe();
    _getTeam();
    _getCollaborators();
    _getPartnerInstitutions();
  }

  @observable
  AboutMeHistoric aboutMeHistoric;

  @observable
  List<Team> team;

  @observable
  List<Collaborators> collaborators;

  @observable
  PartnerInstitutions partnerInstitutions;


  Future<void> _getAboutMe() async {
    loading = true;
    final DocumentSnapshot doc = await firestore
        .collection('aboutUs').doc('about_us')
        .get();

    aboutMeHistoric = AboutMeHistoric.fromDocument(doc);

  }

  Future<void> _getTeam() async {
    final queryBuilder = firestore
        .collection('name_team')
        .get();

    final response = await queryBuilder;

    team = response.docs.map((e) =>
        Team.fromDocument(e)).toList();

  }

  Future<void> _getCollaborators() async {
    final queryBuilder = firestore
        .collection('collaborators')
        .get();

    final response = await queryBuilder;

    collaborators = response.docs.map((e) =>
        Collaborators.fromDocument(e)).toList();

  }

  Future<void> _getPartnerInstitutions() async {
    final DocumentSnapshot doc = await firestore
        .collection('partner_institutions').doc('gB4TTNA4N1JUkfuAJPf8')
        .get();

    partnerInstitutions = PartnerInstitutions.fromDocument(doc);

    loading = false;

  }

  @observable
  bool loading = false;

  void refreshAboutMe() => _getAboutMe();
  void refreshTeam() => _getTeam();
  void refreshCollaborators() => _getCollaborators();
  void refreshPartnerInstitutions() => _getPartnerInstitutions();

}