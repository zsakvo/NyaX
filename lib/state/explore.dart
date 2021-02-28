import 'package:get/state_manager.dart';

class ExploreState {
  RxList<dynamic> modulesList;
  RxList<dynamic> tabsList;
  ExploreState() {
    modulesList = [].obs;
    tabsList = [].obs;
  }
}
