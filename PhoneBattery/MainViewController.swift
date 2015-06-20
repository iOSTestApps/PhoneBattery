//
//  MainViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voss on 19.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let device = UIDevice.currentDevice()
    var batteryLevel : Float?
    var batteryState : UIDeviceBatteryState!

    override func viewDidLoad() {
        super.viewDidLoad()

        device.batteryMonitoringEnabled = true
        batteryLevel = device.batteryLevel
        batteryState = device.batteryState
        
        // KVO for oberserving battery level and state
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryLevelChanged:", name: UIDeviceBatteryLevelDidChangeNotification, object: device)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryStateChanged:", name: UIDeviceBatteryStateDidChangeNotification, object: device)
        
        
        let percentageLabel = UILabel()
        percentageLabel.textAlignment = .Center
        percentageLabel.text = String(format: "%.f%%", batteryLevel! * 100)
        percentageLabel.font = UIFont.systemFontOfSize(20)
        percentageLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(percentageLabel)
        
        self.view.addConstraint(NSLayoutConstraint(item: percentageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: percentageLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
        
        
        
        
        
        /*
        let aboutButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        aboutButton.setTitle("", forState: UIControlState.Normal)
        aboutButton.layer.cornerRadius = 20
        aboutButton.backgroundColor = UIColor.blackColor()
        aboutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view .addSubview(aboutButton)
        
        self.view.addConstraint(NSLayoutConstraint(item: aboutButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -30))
        
        self.view.addConstraint(NSLayoutConstraint(item: aboutButton, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: -100))
        
        self.view.addConstraint(NSLayoutConstraint(item: aboutButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 50))
        
        self.view.addConstraint(NSLayoutConstraint(item: aboutButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))*/
        
        
        
        //percentageLabel.addConstraint(NSLayoutConstraint(ite)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func batteryLevelChanged(notification: NSNotification) {
        batteryLevel = device.batteryLevel
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
