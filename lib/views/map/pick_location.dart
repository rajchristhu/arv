
import '../../google_maps_place_picker/src/models/pick_result.dart';

class SelectedLocation {
  PickResult? locationInfo;
  String? landMark;

  SelectedLocation._();

  static final SelectedLocation instance = SelectedLocation._();
}
