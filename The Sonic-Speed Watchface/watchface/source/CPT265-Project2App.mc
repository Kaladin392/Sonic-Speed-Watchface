import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class CPT265_Project2App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new CPT265_Project2View() ];
    }

}

function getApp() as CPT265_Project2App {
    return Application.getApp() as CPT265_Project2App;
}