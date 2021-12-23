import 'package:gerenciador_aquifero/models/about_me/collaborators.dart';
import 'package:mobx/mobx.dart';

part 'edit_collaborators_store.g.dart';

class EditCollaboratorsStore = _EditCollaboratorsStore with _$EditCollaboratorsStore;

abstract class _EditCollaboratorsStore with Store {

  _EditCollaboratorsStore(this.collaborators){
    name = collaborators.name ?? '';
    descriptionPt = collaborators.descriptionPt ?? '';
    descriptionEn = collaborators.descriptionEn ?? '';
  }

  Collaborators collaborators;

  @observable
  String name = '';

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
  String descriptionPt = '';

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
  String descriptionEn = '';

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
  bool savedCollaborators = false;

  @action
  Future<void> _send() async {
    collaborators.name = name;
    collaborators.descriptionPt = descriptionPt;
    collaborators.descriptionEn = descriptionEn;

    loading = true;
    try {
      await Collaborators().editCollaborators(collaborators);
      savedCollaborators = true;
    } catch (e) {
      error = e;
    }
    loading = false;
  }

}