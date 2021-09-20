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
    lat = subEspecie.lat ?? '';
    long = subEspecie.long ?? '';
  }

  final SubEspecie subEspecie;

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

  @computed
  bool get nomeValid => nome.length >= 4;
  String get nomeError {
    if (!showErrors || nomeValid)
      return null;
    else if (nome.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Nome em português';
  }

  @observable
  String nomeEn = '';

  @action
  void setNomeEn(String value) => nomeEn = value;

  @computed
  bool get nomeEnValid => nomeEn.length >= 4;
  String get nomeEnError {
    if (!showErrors || nomeEnValid)
      return null;
    else if (nomeEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Nome em inglês';
  }

  @observable
  String reproductions = '';

  @action
  void setReproductions(String value) => reproductions = value;

  @computed
  bool get reproductionsValid => reproductions.length >= 4;
  String get reproductionsError {
    if (!showErrors || reproductionsValid)
      return null;
    else if (reproductions.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Reprodução em português';
  }

  @observable
  String reproductionsEn = '';

  @action
  void setReproductionsEn(String value) => reproductionsEn = value;

  @computed
  bool get reproductionsEnValid => reproductionsEn.length >= 4;
  String get reproductionsEnError {
    if (!showErrors || reproductionsEnValid)
      return null;
    else if (reproductionsEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Reprodução em inglês';
  }

  @observable
  String youKnow = '';

  @action
  void setYouKnow(String value) => youKnow = value;

  @computed
  bool get youKnowValid => youKnow.length >= 4;
  String get youKnowError {
    if (!showErrors || youKnowValid)
      return null;
    else if (youKnow.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Você sabe em português';
  }

  @observable
  String youKnowEn = '';

  @action
  void setYouKnowEn(String value) => youKnowEn = value;

  @computed
  bool get youKnowEnValid => youKnowEn.length >= 4;
  String get youKnowEnError {
    if (!showErrors || youKnowEnValid)
      return null;
    else if (youKnowEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Você sabe em inglês';
  }

  @observable
  String specie = '';

  @action
  void setSpecie(String value) => specie = value;

  @computed
  bool get specieValid => specie.length >= 4;
  String get specieError {
    if (!showErrors || specieValid)
      return null;
    else if (specie.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Espécie em português';
  }

  @observable
  String specieEn = '';

  @action
  void setSpecieEn(String value) => specieEn = value;

  @computed
  bool get specieEnValid => specieEn.length >= 4;
  String get specieEnError {
    if (!showErrors || specieEnValid)
      return null;
    else if (specieEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Espécie em inglês';
  }

  @observable
  String subspecie = '';

  @action
  void setSubspecie(String value) => subspecie = value;

  @computed
  bool get subspecieValid => subspecie.length >= 4;
  String get subspecieError {
    if (!showErrors ||subspecieValid)
      return null;
    else if (subspecie.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Sub Espécie em português';
  }

  @observable
  String subspecieEn = '';

  @action
  void setSubspecieEn(String value) => subspecieEn = value;

  @computed
  bool get subspecieEnValid => subspecieEn.length >= 4;
  String get subspecieEnError {
    if (!showErrors || subspecieEnValid)
      return null;
    else if (subspecieEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Sub Espécie em inglês';
  }

  @observable
  String scientificName = '';

  @action
  void setScientificName(String value) => scientificName = value;

  @computed
  bool get scientificNameValid => scientificName.length >= 4;
  String get scientificNameError {
    if (!showErrors ||scientificNameValid)
      return null;
    else if (scientificName.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Nome científico em português';
  }

  @observable
  String scientificNameEn = '';

  @action
  void setScientificNameEn(String value) => scientificNameEn = value;

  @computed
  bool get scientificNameEnValid => scientificNameEn.length >= 4;
  String get scientificNameEnError {
    if (!showErrors || scientificNameEnValid)
      return null;
    else if (scientificNameEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Nome científico em inglês';
  }

  @observable
  String locations = '';

  @action
  void setLocations(String value) => locations = value;

  @computed
  bool get locationsValid => locations.length >= 4;
  String get locationsError {
    if (!showErrors ||locationsValid)
      return null;
    else if (locations.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Localização em português';
  }

  @observable
  String locationsEn = '';

  @action
  void setLocationsEn(String value) => locationsEn = value;

  @computed
  bool get locationsEnValid => locationsEn.length >= 4;
  String get locationsEnError {
    if (!showErrors || locationsEnValid)
      return null;
    else if (locationsEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Localização em inglês';
  }

  @observable
  String howKnow = '';

  @action
  void setHowKnow(String value) => howKnow = value;

  @computed
  bool get howKnowValid => howKnow.length >= 4;
  String get howKnowError {
    if (!showErrors ||howKnowValid)
      return null;
    else if (howKnow.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Tamanho em português';
  }

  @observable
  String howKnowEn = '';

  @action
  void setHowKnowEn(String value) => howKnowEn = value;

  @computed
  bool get howKnowEnValid => howKnowEn.length >= 4;
  String get howKnowEnError {
    if (!showErrors || howKnowEnValid)
      return null;
    else if (howKnowEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Tamanho em inglês';
  }

  @observable
  String color = '';

  @action
  void setColor(String value) => color = value;

  @computed
  bool get colorValid => color.length >= 1;
  String get colorError {
    if (!showErrors ||colorValid)
      return null;
    else if (color.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Cor em português';
  }

  @observable
  String colorEn = '';

  @action
  void setColorEn(String value) => colorEn = value;

  @computed
  bool get colorEnValid => colorEn.length >= 1;
  String get colorEnError {
    if (!showErrors || colorEnValid)
      return null;
    else if (colorEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Cor em inglês';
  }

  @observable
  String active = '';

  @action
  void setActive(String value) => active = value;

  @computed
  bool get activeValid => active.length >= 4;
  String get activeError {
    if (!showErrors ||activeValid)
      return null;
    else if (active.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Ativa em português';
  }

  @observable
  String activeEn = '';

  @action
  void setActiveEn(String value) => activeEn = value;

  @computed
  bool get activeEnValid => activeEn.length >= 4;
  String get activeEnError {
    if (!showErrors || activeEnValid)
      return null;
    else if (activeEn.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Ativa em inglês';
  }

  @observable
  String lat = '';

  @action
  void setLat(String value) => lat = value;

  @computed
  bool get latValid => lat.length >= 4;
  String get latError {
    if (!showErrors ||latValid)
      return null;
    else if (lat.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Latitude';
  }

  @observable
  String long = '';

  @action
  void setLong(String value) => long = value;

  @computed
  bool get longValid => long.length >= 4;
  String get longError {
    if (!showErrors || longValid)
      return null;
    else if (long.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Longitude';
  }

  @computed
  bool get formValid =>
                imgValid &&
                nomeValid &&
                nomeEnValid &&
                reproductionsValid &&
                reproductionsEnValid &&
                youKnowValid &&
                youKnowEnValid &&
                specieValid &&
                specieEnValid &&
                subspecieValid &&
                subspecieEnValid &&
                scientificNameValid &&
                scientificNameEnValid &&
                locationsValid &&
                locationsEnValid &&
                howKnowValid &&
                howKnowEnValid &&
                colorValid &&
                colorEnValid &&
                activeValid &&
                activeEnValid &&
                latValid &&
                longValid;

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
  bool saveSub = false;

  @action
  Future<void> _send() async {

    subEspecie.img = img;
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
    subEspecie.lat = lat;
    subEspecie.long = long;

    loading = true;
      await SubEspecie().save(subEspecie);
      saveSub = true;
    loading = false;
  }

}