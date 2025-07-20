import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/module/general/api/api_general.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends ViewModelBase {
  ApiGeneral apiGeneral = ApiGeneral();

  String dayNumber = "";
  String monthYear = "";

  // Tambahan data dinamis
  String progress = "87%";
  String distance = "18.5 km";
  String duration = "3h 45m";
  String rest = "6.5 jam";

  String alertMessage =
      "Hujan deras di area Anda. Berkendara dengan hati-hati.";

  @override
  Future<void> init() async {
    setLoading(true);
    await getInfo();
    final now = DateTime.now();
    dayNumber = DateFormat('d').format(now);
    monthYear = DateFormat('MMMM yyyy').format(now);
    notifyListeners();
    setLoading(false);
  }

  Future<void> getInfo() async {
    try {
      setLoading(true);
      Map response = await apiGeneral.generalInfo();

      if (response['status'] == 'success') {
        print("General Info: ${response['data']}");
      } else {
        print("General Info: $response");
      }
      setLoading(false);
      notifyListeners();
    } catch (e) {
      print("Error fetching general info: $e");
    }
  }
}
