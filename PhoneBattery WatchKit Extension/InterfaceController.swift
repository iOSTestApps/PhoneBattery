//
//  InterfaceController.swift
//  PhoneBattery WatchKit Extension
//
//  Created by Marcel Voss on 19.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    let device = UIDevice.currentDevice()
    var batteryLevel : Float?
    var batteryState : UIDeviceBatteryState!

    @IBOutlet weak var percentageLabel: WKInterfaceLabel!
    @IBOutlet weak var statusLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        device.batteryMonitoringEnabled = true
        batteryLevel = device.batteryLevel
        batteryState = device.batteryState
        
        // KVO for oberserving battery level and state
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryLevelChanged:", name: UIDeviceBatteryLevelDidChangeNotification, object: device)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryStateChanged:", name: UIDeviceBatteryStateDidChangeNotification, object: device)

        percentageLabel.setText(String(format: "%.f%%", batteryLevel! * 100))
        statusLabel.setText(self.stringForBatteryState(batteryState))
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func stringForBatteryState(batteryState: UIDeviceBatteryState) -> String {
        if batteryState == UIDeviceBatteryState.Full {
            return NSLocalizedString("FULL", comment: "")
        } else if batteryState == UIDeviceBatteryState.Charging {
            return NSLocalizedString("CHARGING", comment: "")
        } else if batteryState == UIDeviceBatteryState.Unplugged {
            return NSLocalizedString("REMAINING", comment: "")
        } else {
            // State is unknown
            return NSLocalizedString("UNKNOWN", comment: "")
        }
    }
    
    func batteryLevelChanged(notification: NSNotification) {
        batteryLevel = device.batteryLevel
        
        statusLabel.setText(String(format: "%.f%%", batteryLevel! * 100))
    }
    
    func batteryStateChanged(notification: NSNotification) {
        batteryState = device.batteryState
        
        if batteryState == UIDeviceBatteryState.Full {
            
        } else if batteryState == UIDeviceBatteryState.Charging {
            
        } else if batteryState == UIDeviceBatteryState.Unplugged {
            
        } else {
            // State is unknown
            
        }
        
    }

}
