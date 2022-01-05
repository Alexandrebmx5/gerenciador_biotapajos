import 'package:gerenciador_aquifero/models/about_me/partner_institutions.dart';
import 'package:gerenciador_aquifero/stores/about_me_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'edit_partner_institutions_store.g.dart';

class EditPartnerInstitutionsStore = _EditPartnerInstitutionsStore with _$EditPartnerInstitutionsStore;

abstract class _EditPartnerInstitutionsStore with Store {

  _EditPartnerInstitutionsStore({this.partnerInstitutions}){
    img = partnerInstitutions.img.asObservable();
  }

  final PartnerInstitutions partnerInstitutions;

  ObservableList img = ObservableList();

  @computed
  bool get imgValid => img.isNotEmpty;
  String get imgError {
    if (!showErrors || imgValid)
      return null;
    else
      return 'Insira imagens';
  }

  @computed
  bool get formValid => imgValid;

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
  bool savePartners = false;

  @action
  Future<void> _send() async {

    partnerInstitutions.img = img;

    loading = true;
    try {
      await PartnerInstitutions().editPartnerInstitutions(partnerInstitutions);
      savePartners = true;
    } catch (e) {
      error = e;
    }
    loading = false;
  }


}