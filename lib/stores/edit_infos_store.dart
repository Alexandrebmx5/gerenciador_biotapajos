import 'package:gerenciador_aquifero/models/info_presently/infos.dart';
import 'package:mobx/mobx.dart';

part 'edit_infos_store.g.dart';

class EditInfosStore = _EditInfosStore with _$EditInfosStore;

abstract class _EditInfosStore with Store {

  _EditInfosStore(this.infos){
    if(infos.img != null)
      img = infos.img.asObservable();

    title = infos.title ?? '';
    paragraphOne = infos.paragraphOne ?? '';
    paragraphTwo = infos.paragraphTwo ?? '';
    paragraphThree = infos.paragraphThree ?? '';
    paragraphFour = infos.paragraphFour ?? '';
    titleEn = infos.titleEn ?? '';
    paragraphOneEn = infos.paragraphOneEn ?? '';
    paragraphTwoEn = infos.paragraphTwoEn ?? '';
    paragraphThreeEn = infos.paragraphThreeEn ?? '';
    paragraphFourEn = infos.paragraphFourEn ?? '';
  }

  Infos infos;

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
  String title;

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title != null && title.length > 5;
  String get titleError {
    if (!showErrors || titleValid)
      return null;
    else if (title.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  String paragraphOne;

  @action
  void setParagraphOne(String value) => paragraphOne = value;

  @computed
  bool get paragraphOneValid => paragraphOne != null && paragraphOne.length > 15;
  String get paragraphOneError {
    if (!showErrors || paragraphOneValid)
      return null;
    else if (paragraphOne.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Parágrafo muito curto';
  }

  @observable
  String paragraphTwo;

  @action
  void setParagraphTwo(String value) => paragraphTwo = value;

  @computed
  bool get paragraphTwoValid => paragraphTwo != null && paragraphTwo.length > 15;
  String get paragraphTwoError {
    if (!showErrors || paragraphTwoValid)
      return null;
    else if (paragraphOne.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Parágrafo muito curto';
  }

  @observable
  String paragraphThree;

  @action
  void setParagraphThree(String value) => paragraphThree = value;


  @observable
  String paragraphFour;

  @action
  void setParagraphFour(String value) => paragraphFour = value;

  @observable
  String titleEn;

  @action
  void setTitleEn(String value) => titleEn = value;

  @computed
  bool get titleEnValid => titleEn != null && titleEn.length > 5;
  String get titleEnError {
    if (!showErrors || titleEnValid)
      return null;
    else if (titleEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  String paragraphOneEn;

  @action
  void setParagraphOneEn(String value) => paragraphOneEn = value;

  @computed
  bool get paragraphOneEnValid => paragraphOneEn != null && paragraphOneEn.length > 15;
  String get paragraphOneEnError {
    if (!showErrors || paragraphOneEnValid)
      return null;
    else if (paragraphOneEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Parágrafo muito curto';
  }

  @observable
  String paragraphTwoEn;

  @action
  void setParagraphTwoEn(String value) => paragraphTwoEn = value;

  @computed
  bool get paragraphTwoEnValid => paragraphTwoEn != null && paragraphTwoEn.length > 15;
  String get paragraphTwoEnError {
    if (!showErrors || paragraphTwoEnValid)
      return null;
    else if (paragraphTwoEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Parágrafo muito curto';
  }

  @observable
  String paragraphThreeEn;

  @action
  void setParagraphThreeEn(String value) => paragraphThreeEn = value;


  @observable
  String paragraphFourEn;

  @action
  void setParagraphFourEn(String value) => paragraphFourEn = value;

  @computed
  bool get formValid =>
      titleValid &&
          imgValid &&
          paragraphOneValid &&
          paragraphTwoValid &&
          titleEnValid &&
          paragraphOneEnValid &&
          paragraphTwoEnValid;

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
  bool saveInfos = false;

  @action
  Future<void> _send() async {
    loading = true;

    infos.img = img;
    infos.title = title;
    infos.paragraphOne = paragraphOne;
    infos.paragraphTwo = paragraphTwo;
    infos.paragraphThree = paragraphThree;
    infos.paragraphFour = paragraphFour;
    infos.titleEn = titleEn;
    infos.paragraphOneEn = paragraphOneEn;
    infos.paragraphTwoEn = paragraphTwoEn;
    infos.paragraphThreeEn = paragraphThreeEn;
    infos.paragraphFourEn = paragraphFourEn;

    try {
      await Infos().editInfos(infos);
      saveInfos = true;
    } catch (e){
      error = e;
    }

    loading = false;
  }

}