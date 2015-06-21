//
//  MainViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voss on 19.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit
import MessageUI

class MainViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "PhoneBattery"
        
        
        // TODO: Pageable table view header with tutorial
        
        
        
        let descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .Justified
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "PhoneBattery allows you to check your phone's battery life right on your Apple Watch.\n\nTo launch it, simply open the PhoneBattery app on your Apple Watch or add the PhoneBattery Glance to check it even faster."
        descriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(descriptionLabel)
        
        self.view.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 100))
        
        self.view.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: -50))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PRAGMA MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier") as! UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier")
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell!.textLabel!.text = NSLocalizedString("HELP", comment: "")
                cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            } else if indexPath.row == 1 {
                cell!.textLabel!.text = NSLocalizedString("ABOUT", comment: "")
                cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if MFMailComposeViewController.canSendMail() {
                    let mailComposer = MFMailComposeViewController()
                    mailComposer.mailComposeDelegate = self
                    
                    
                    let device = UIDevice.currentDevice()
                    let shortString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
                    let buildString = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
                    
                    let subjectString = String(format: "Support PhoneBattery: %@ (%@)", shortString, buildString)
                    let bodyString = String(format: "\n\n\n----\niOS Version: %@\nDevice: %@\n", device.systemVersion, device.model)
                    mailComposer.setMessageBody(bodyString, isHTML: false)
                    mailComposer.setSubject(subjectString)
                    mailComposer.setToRecipients(["help@marcelvoss.com"])
                    
                    self.presentViewController(mailComposer, animated: true, completion: nil)
                }
            } else if indexPath.row == 1 {
                self.navigationController?.pushViewController(AboutViewController(style: UITableViewStyle.Grouped), animated: true)
            }
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
