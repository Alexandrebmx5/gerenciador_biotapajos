import 'package:gerenciador_aquifero/models/especie/subespecie.dart';
import 'package:mobx/mobx.dart';

part 'new_subespecie_store.g.dart';

class NewSubEspecieStore = _NewSubEspecieStore with _$NewSubEspecieStore;

abstract class _NewSubEspecieStore with Store {

  _NewSubEspecieStore({this.subEspecie}) {
    if(subEspecie.img != null)
      img = subEspecie.img.asObservable();

    sound = subEspecie.sound ?? '';
    nome = subEspecie.nome ?? '';
    nomeEn = subEspecie.nomeEn ?? '';
    reproductions = subEspecie.reproduction ?? '';
    reproductionsEn = subEspecie.reproductionEn ?? '';
    youKnow = subEspecie.youKnow ?? '';
    youKnowEn = subEspecie.youKnowEn ?? '';
    specie = subEspecie.specie ?? '';
    specieEn = subEspecie.specieEn ?? '';
    subspecie = subEspecie.subspecie ?? '';
    subspecieEn = subEspecie.subspecieEn ?? '';
    scientificName = subEspecie.scientificName ?? '';
    scientificNameEn = subEspecie.scientificNameEn ?? '';
    locations = subEspecie.locations ?? '';
    locationsEn = subEspecie.locationsEn ?? '';
    howKnow = subEspecie.howKnow ?? '';
    howKnowEn = subEspecie.howKnowEn ?? '';
    color = subEspecie.color ?? '';
    colorEn = subEspecie.colorEn ?? '';
    active = subEspecie.active ?? '';
    activeEn = subEspecie.activeEn ?? '';
  }

  final SubEspecie subEspecie;

  ObservableList img = ObservableList();

  @observable
  var sound;

  @action
  void setSound(var value) => sound = value;

  @observable
  String soundName;

  @action
  void setSoundName(String value) => soundName = value;

  @observable
  String nome = '';

  @action
  void setNome(String value) => nome = value;

  @observable
  String nomeEn = '';

  @action
  void setNomeEn(String value) => nomeEn = value;

  @observable
  String reproductions = '';

  @action
  void setReproductions(String value) => reproductions = value;


  @observable
  String reproductionsEn = '';

  @action
  void setReproductionsEn(String value) => reproductionsEn = value;

  @observable
  String youKnow = '';

  @action
  void setYouKnow(String value) => youKnow = value;

  @observable
  String youKnowEn = '';

  @action
  void setYouKnowEn(String value) => youKnowEn = value;

  @observable
  String specie = '';

  @action
  void setSpecie(String value) => specie = value;

  @observable
  String specieEn = '';

  @action
  void setSpecieEn(String value) => specieEn = value;


  @observable
  String subspecie = '';

  @action
  void setSubspecie(String value) => subspecie = value;

  @observable
  String subspecieEn = '';

  @action
  void setSubspecieEn(String value) => subspecieEn = value;

  @observable
  String scientificName = '';

  @action
  void setScientificName(String value) => scientificName = value;

  @observable
  String scientificNameEn = '';

  @action
  void setScientificNameEn(String value) => scientificNameEn = value;

  @observable
  String locations = '';

  @action
  void setLocations(String value) => locations = value;

  @observable
  String locationsEn = '';

  @action
  void setLocationsEn(String value) => locationsEn = value;

  @observable
  String howKnow = '';

  @action
  void setHowKnow(String value) => howKnow = value;

  @observable
  String howKnowEn = '';

  @action
  void setHowKnowEn(String value) => howKnowEn = value;

  @observable
  String color = '';

  @action
  void setColor(String value) => color = value;

  @observable
  String colorEn = '';

  @action
  void setColorEn(String value) => colorEn = value;

  @observable
  String active = '';

  @action
  void setActive(String value) => active = value;

  @observable
  String activeEn = '';

  @action
  void setActiveEn(String value) => activeEn = value;

  @computed
  Function get sendPressed => _send;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  String error;

  @observable
  bool loading = false;

  @observable
  bool saveSub = false;

  @action
  Future<void> _send() async {

    subEspecie.img = img.isEmpty ? [] : img;
    subEspecie.sound = sound;
    subEspecie.soundName = soundName;
    subEspecie.nome = nome;
    subEspecie.nomeEn = nomeEn;
    subEspecie.reproduction = reproductions;
    subEspecie.reproductionEn = reproductionsEn;
    subEspecie.youKnow = youKnow;
    subEspecie.youKnowEn = youKnowEn;
    subEspecie.specie = specie;
    subEspecie.specieEn = specieEn;
    subEspecie.subspecie = subspecie;
    subEspecie.subspecieEn = subspecieEn;
    subEspecie.scientificName = scientificName;
    subEspecie.scientificNameEn = scientificNameEn;
    subEspecie.locations = locations;
    subEspecie.locationsEn = locationsEn;
    subEspecie.howKnow = howKnow;
    subEspecie.howKnowEn = howKnowEn;
    subEspecie.color = color;
    subEspecie.colorEn = colorEn;
    subEspecie.active = active;
    subEspecie.activeEn = activeEn;

    loading = true;
    try {
      await SubEspecie().save(subEspecie);
      saveSub = true;
    } catch (e){
      error = e;
    }
    loading = false;
  }

}