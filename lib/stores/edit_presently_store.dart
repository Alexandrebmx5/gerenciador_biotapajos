import 'package:gerenciador_aquifero/models/info_presently/presently.dart';
import 'package:mobx/mobx.dart';

part 'edit_presently_store.g.dart';

class EditPresentlyStore = _EditPresentlyStore with _$EditPresentlyStore;

abstract class _EditPresentlyStore with Store {

  _EditPresentlyStore(this.presently){
    if(presently.img != null)
      img = presently.img.asObservable();

    title = presently.title ?? '';
    paragraphOne = presently.paragraphOne ?? '';
    paragraphTwo = presently.paragraphTwo ?? '';
    paragraphThree = presently.paragraphThree ?? '';
    paragraphFour = presently.paragraphFour ?? '';
    titleEn = presently.titleEn ?? '';
    paragraphOneEn = presently.paragraphOneEn ?? '';
    paragraphTwoEn = presently.paragraphTwoEn ?? '';
    paragraphThreeEn = presently.paragraphThreeEn ?? '';
    paragraphFourEn = presently.paragraphFourEn ?? '';
  }

  Presently presently;

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
  bool savePresently = false;

  @action
  Future<void> _send() async {
    loading = true;

    presently.img = img;
    presently.title = title;
    presently.paragraphOne = paragraphOne;
    presently.paragraphTwo = paragraphTwo;
    presently.paragraphThree = paragraphThree;
    presently.paragraphFour = paragraphFour;
    presently.titleEn = titleEn;
    presently.paragraphOneEn = paragraphOneEn;
    presently.paragraphTwoEn = paragraphTwoEn;
    presently.paragraphThreeEn = paragraphThreeEn;
    presently.paragraphFourEn = paragraphFourEn;

    try {
      await Presently().editPresently(presently);
      savePresently = true;
    } catch (e){
      error = e;
    }

    loading = false;
  }

}