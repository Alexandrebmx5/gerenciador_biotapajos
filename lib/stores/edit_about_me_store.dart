import 'package:gerenciador_aquifero/models/about_me/about_me_historic.dart';
import 'package:mobx/mobx.dart';

part 'edit_about_me_store.g.dart';

class EditAboutMeStore = _EditAboutMeStore with _$EditAboutMeStore;

abstract class _EditAboutMeStore with Store {

  _EditAboutMeStore({this.aboutMeHistoric}){

    if(aboutMeHistoric.iaaLogo != null)
      iaaLogo = aboutMeHistoric.iaaLogo.asObservable();
    pt = aboutMeHistoric.pt ?? '';
    en = aboutMeHistoric.en ?? '';
    iaaPt = aboutMeHistoric.iaaPt ?? '';
    iaaEn = aboutMeHistoric.iaaEn ?? '';
  }

  AboutMeHistoric aboutMeHistoric;

  ObservableList iaaLogo = ObservableList();

  @observable
  String pt = '';

  @action
  void setPt(String value) => pt = value;

  @computed
  bool get ptValid => pt != null;
  String get ptError {
    if (!showErrors || ptValid)
      return null;
    else if (pt.isEmpty)
      return 'Campo obrigatório';
    else
      return '';
  }

  @observable
  String en = '';

  @action
  void setEn(String value) => en = value;

  @computed
  bool get enValid => en != null;
  String get enError {
    if (!showErrors || enValid)
      return null;
    else if (en.isEmpty)
      return 'Campo obrigatório';
    else
      return '';
  }

  @observable
  String iaaPt = '';

  @action
  void setIaaPt(String value) => iaaPt = value;

  @computed
  bool get iaaPtValid => iaaPt != null;
  String get iaaPtError {
    if (!showErrors || iaaPtValid)
      return null;
    else if (iaaPt.isEmpty)
      return 'Campo obrigatório';
    else
      return '';
  }

  @observable
  String iaaEn = '';

  @action
  void setIaaEn(String value) => iaaEn = value;

  @computed
  bool get iaaEnValid => iaaEn != null;
  String get iaaEnError {
    if (!showErrors || iaaEnValid)
      return null;
    else if (iaaEn.isEmpty)
      return 'Campo obrigatório';
    else
      return '';
  }

  @computed
  bool get formValid => ptValid && enValid && iaaPtValid && iaaEnValid;

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
  bool saveAbout = false;

  @action
  Future<void> _send() async {

    aboutMeHistoric.iaaLogo = iaaLogo;
    aboutMeHistoric.pt = pt;
    aboutMeHistoric.en = en;
    aboutMeHistoric.iaaPt = iaaPt;
    aboutMeHistoric.iaaEn = iaaEn;

    loading = true;
    try {
      await AboutMeHistoric().editAboutMe(aboutMeHistoric);
      saveAbout = true;
    } catch (e) {
      error = e;
    }
    loading = false;

  }

}