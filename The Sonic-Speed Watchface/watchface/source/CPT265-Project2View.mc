import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Time.Gregorian;

class CPT265_Project2View extends WatchUi.WatchFace {
    var stepsIcon;
    var myFont;
    var myImage;
    var myImage2;
    var BL1;
    var BL2;
    var BL3;
    var BL4;
    var BL5;

    function initialize() {
        WatchFace.initialize();

        /* stepsIcon = WatchUi.loadResource(Rez.Drawables.StepsIcon);
        stepsIcon = WatchUi.icon */
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));   
        myFont = WatchUi.loadResource(Rez.Fonts.myFont);
        myImage = WatchUi.loadResource(Rez.Drawables.HeartRateIcon);
        myImage2 = WatchUi.loadResource(Rez.Drawables.LogoLabel);
        BL1 = WatchUi.loadResource(Rez.Drawables.BatteryLabel1);
        BL2 = WatchUi.loadResource(Rez.Drawables.BatteryLabel2);
        BL3 = WatchUi.loadResource(Rez.Drawables.BatteryLabel3);
        BL4 = WatchUi.loadResource(Rez.Drawables.BatteryLabel4);
        BL5 = WatchUi.loadResource(Rez.Drawables.BatteryLabel5);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        

        // Get and show the current time
        updateTime();
        updateDate();
        updateHeartRate();
        updateSteps();
        updateBattery();
        View.onUpdate(dc);
    }
        
        function getHeartRate() as Number {
        var heartrateIterator = Toybox.ActivityMonitor.getHeartRateHistory(1, true);
        return heartrateIterator.next().heartRate;
        }

        function getHeartRateString() as String {
            var heartRate = getHeartRate();
            return (heartRate == null) ? "-" : heartRate.format("%d");
        }

        function updateHeartRate() as Void {
            var heartRateString = getHeartRateString();
            var heartRateView = View.findDrawableById("HeartRateLabel") as Text;
            heartRateView.setText(heartRateString);
        }

        function updateTime() as Void {
            var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
            var timeString = Lang.format("$1$:$2$", [today.hour, today.min.format("%02d")]);
            var timeView = View.findDrawableById("TimeLabel") as Text;
            timeView.setText(timeString);
            timeView.setFont(myFont);
        }

        function updateDate() as Void {
            var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
            var dateString = Lang.format("$1$ $2$ $3$", [today.day_of_week, today.month, today.day]);
            var dateView = View.findDrawableById("DateLabel") as Text;
            dateView.setText(dateString);
        }

        function updateSteps() as Void {
            var stepInfo = ActivityMonitor.getInfo();
            var steps = (stepInfo != null) ? stepInfo.steps : 0;
            var stepsView = View.findDrawableById("StepsLabel") as Text;
            if (steps > 0) {
                stepsView.setText(steps.toString());
            } else {
                stepsView.setText("0");
            }
        }

        function updateBattery() as Void {
            var batteryLevel = System.getSystemStats().battery;
            var batteryView = View.findDrawableById("BatteryLabel") as Text;
            batteryView.setText(batteryLevel.format("%d") + "%");

            var batteryLabel1 = View.findDrawableById("BatteryLabel1") as Bitmap;
            var batteryLabel2 = View.findDrawableById("BatteryLabel2") as Bitmap;
            var batteryLabel3 = View.findDrawableById("BatteryLabel3") as Bitmap;
            var batteryLabel4 = View.findDrawableById("BatteryLabel4") as Bitmap;
            var batteryLabel5 = View.findDrawableById("BatteryLabel5") as Bitmap;

            batteryLabel1.setVisible(false);
            batteryLabel2.setVisible(false);
            batteryLabel3.setVisible(false);
            batteryLabel4.setVisible(false);
            batteryLabel5.setVisible(false);

            if (batteryLevel > 75) {
                batteryLabel1.setVisible(true);
            } else if (batteryLevel > 50) {
                batteryLabel2.setVisible(true);
            } else if (batteryLevel > 25) {
                batteryLabel3.setVisible(true);
            } else if (batteryLevel > 5) {
                batteryLabel4.setVisible(true);
            } else {
                batteryLabel5.setVisible(true);
            }
        }
                    
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }


