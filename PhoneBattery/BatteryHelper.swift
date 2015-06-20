//
//  BatteryHelper.swift
//  PhoneBattery
//
//  Created by Marcel Voss on 20.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit

class BatteryHelper: NSObject {
    
    let device = UIDevice.currentDevice()
    var batteryLevel : Float?
    var batteryState : UIDeviceBatteryState!
    
    func setup() {
        device.batteryMonitoringEnabled = true
        batteryLevel = device.batteryLevel
        batteryState = device.batteryState
        
        // KVO for oberserving battery level and state
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryLevelChanged:", name: UIDeviceBatteryLevelDidChangeNotification, object: device)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryStateChanged:", name: UIDeviceBatteryStateDidChangeNotification, object: device)
    }
    
    func batteryLevelChanged() {
        batteryLevel = device.batteryLevel
    }
    
    func batteryStateChanged() {
        batteryState = device.batteryState
        
        if batteryState == UIDeviceBatteryState.Full {
            
        } else if batteryState == UIDeviceBatteryState.Charging {
            
        } else if batteryState == UIDeviceBatteryState.Unplugged {
            
        } else {
            // State is unknown
            
        }
    }
    
}
