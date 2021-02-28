import 'package:get/state_manager.dart';

class ExploreState {
  RxList<dynamic> modulesList;
  ExploreState() {
    modulesList = [].obs;
  }
}
