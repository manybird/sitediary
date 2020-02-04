import 'package:json_annotation/json_annotation.dart';
import 'package:sitediary/datas/eform/eform.dart';
part 'state_eform.g.dart';

@JsonSerializable()
class EFormState {
  EForm currentEForm;
  EFormState( this.currentEForm);

  factory EFormState.initial(){
    return EFormState( EForm() );
  }

  factory EFormState.fromJson(Map<String, dynamic> json) {
    return _$EFormStateFromJson(json);
  }

  dynamic toJson()=> _$EFormStateToJson (this);

  @override
  String toString() {
    return 'EFormState: ${this.currentEForm.eFormKey}';
  }

}