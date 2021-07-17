
// START BACKGROUND TASK USING API CALLS
//UNCOMMENT THE CODE AND COPY AND PASE IT TO YOUR MAIN.DART FILE



/*  import 'package:http/http.dart';
import 'package:sms/sms.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackground = "fetchBackground";
Workmanager _workmanager = new Workmanager();
void callbackDispatcher() {
  _workmanager.executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        try {
          Response response = await get(Uri.parse("xxx"));
          Map data = jsonDecode(response.body);
          String card = data["sim"].toString();
          String messsage = data["message"].toString();
          List numbers = data["numbers"];
        }
        catch(e){
          throw e;
        }
        break;
    }
    return Future.value(true);
  });
} */


// THIS GOES IN main.dart FILE

/*     void main() {

// needs to be initialized before using workmanager package
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Workmanager with the function which you want to invoke after any periodic time
  _workmanager.initialize(callbackDispatcher);

  // Periodic task registration
  _workmanager.registerPeriodicTask(
    "2",
    // use the same task name used in callbackDispatcher function for identifying the task
    // Each task must have a unique name if you want to add multiple tasks;
    fetchBackground,
    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change your frequency to 15 min if you have configured a lower frequency than 15 minutes.
    frequency: Duration(hours: 1), // change duration according to your needs
  );       */