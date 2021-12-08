import 'package:gerenciador_aquifero/models/especie/especie.dart';
import 'package:mobx/mobx.dart';

part 'new_especie_store.g.dart';

class NewEspecieStore = _NewEspecieStore with _$NewEspecieStore;

abstract class _NewEspecieStore with Store {

  _NewEspecieStore({this.especie}) {
    if(especie.img != null)
      img = especie.img.asObservable();

    pt = especie.pt ?? '';
    en = especie.en ?? '';
  }

  final Especie especie;

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
  String pt = '';

  @action
  void setPt(String value) => pt = value;

  @computed
  bool get ptValid => pt.length >= 4;
  String get ptError {
    if (!showErrors || ptValid)
      return null;
    else if (pt.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título em português';
  }

  @observable
  String en = '';

  @action
  void setEn(String value) => en = value;

  @computed
  bool get enValid => en.length >= 4;
  String get enError {
    if (!showErrors || enValid)
      return null;
    else if (en.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título em inglês';
  }

  @computed
  bool get formValid =>
          imgValid &&
          ptValid &&
          enValid;
  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  String error;

  @observable
  bool loading = false;

  @observable
  bool saveEs = false;

  @action
  Future<void> _send() async {

    especie.img = img;
    especie.pt = pt;
    especie.en = en;

    loading = true;
    try {
      await Especie().save(especie);
      saveEs = true;
    } catch (e){
      error = e;
    }
    loading = false;
  }

}