import 'package:gerenciador_aquifero/models/about_me/team/team.dart';
import 'package:mobx/mobx.dart';


part 'edit_team_store.g.dart';

class EditTeamStore = _EditTeamStore with _$EditTeamStore;

abstract class _EditTeamStore with Store {

  _EditTeamStore(this.team){
    if(team.img != null)
      img = team.img.asObservable();
    name = team.name ?? '';
    descriptionPt = team.descriptionPt ?? '';
    descriptionEn = team.descriptionEn ?? '';
  }

  Team team;

  ObservableList img = ObservableList();

  @computed
  bool get imgValid => img.isNotEmpty;
  String get imgError {
    if (!showErrors || imgValid)
      return null;
    else
      return 'Insira imagens';
  }

  @observable
  String name;

  @action
  void setNome(String value) => name = value;

  @computed
  bool get nameValid => name.length >= 4;
  String get nameError {
    if (!showErrors || nameValid)
      return null;
    else if (name.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  String descriptionPt;

  @action
  void setDescriptionPt(String value) => descriptionPt = value;

  @computed
  bool get descriptionPtValid => descriptionPt != null;
  String get descriptionPtError {
    if (!showErrors || descriptionPtValid)
      return null;
    else if (descriptionPt.isEmpty)
      return 'Campo obrigatório';
    else
      return '';
  }

  @observable
  String descriptionEn;

  @action
  void setDescriptionEn(String value) => descriptionEn = value;

  @computed
  bool get descriptionEnValid => descriptionEn != null;
  String get descriptionEnError {
    if (!showErrors || descriptionEnValid)
      return null;
    else if (descriptionEn.isEmpty)
      return 'Campo obrigatório';
    else
      return '';
  }

  @computed
  bool get formValid =>
          imgValid &&
          nameValid &&
          descriptionPtValid &&
          descriptionEnValid;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool savedTeam = false;

  @action
  Future<void> _send() async {
    team.img = img;
    team.name = name;
    team.descriptionPt = descriptionPt;
    team.descriptionEn = descriptionEn;

    loading = true;
    try {
      await Team().editTeam(team);
      savedTeam = true;
    } catch (e) {
      error = e;
    }
    loading = false;
  }

}