//
//  AboutViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voss on 21.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UITableViewController, MFMailComposeViewControllerDelegate, UIScrollViewDelegate {
    
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
        
        let device = UIDevice.currentDevice()
        var batteryLevel : Float?
        var batteryState : UIDeviceBatteryState!
        
        device.batteryMonitoringEnabled = true
        batteryLevel = device.batteryLevel
        batteryState = device.batteryState
        
        let level = batteryLevel! * 100
        println(batteryLevel! * 100)
        println(Int(level))

        self.title = NSLocalizedString("WELCOME", comment: "")
        self.navigationController?.navigationBar.tintColor = UIColor(red:0, green:0.86, blue:0.55, alpha:1)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.view.window?.tintColor = UIColor(red:0, green:0.86, blue:0.55, alpha:1)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "sharePressed:")
        
        var headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 130))
        let backgroundImageView = UIImageView(image: UIImage(named: "BackgroundImage"))
        backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, headerView.frame.size.height)
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFit
        headerView.addSubview(backgroundImageView)
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(visualEffectView)
        
        let appIconImageView = UIImageView(image: UIImage(named: "MaskedIcon"))
        appIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        appIconImageView.contentMode = UIViewContentMode.ScaleAspectFit
        visualEffectView.addSubview(appIconImageView)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Right, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterX, multiplier: 1.0, constant: -20))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 75))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 75))
        
        
        let nameLabel = UILabel()
        nameLabel.text = "PhoneBattery"
        nameLabel.font = UIFont.boldSystemFontOfSize(17)
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView.addSubview(nameLabel)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .CenterY, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterY, multiplier: 1.0, constant: -7))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Left, relatedBy: .Equal, toItem: appIconImageView, attribute: .Right, multiplier: 1.0, constant: 20))
        
        
        let shortString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let buildString = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        
        let versionLabel = UILabel()
        versionLabel.text = String(format: "Version %@ (%@)", shortString, buildString)
        versionLabel.font = UIFont.systemFontOfSize(13)
        versionLabel.textColor = UIColor.whiteColor()
        versionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView.addSubview(versionLabel)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: versionLabel, attribute: .Top, relatedBy: .Equal, toItem: nameLabel, attribute: .Bottom, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: versionLabel, attribute: .Left, relatedBy: .Equal, toItem: nameLabel, attribute: .Left, multiplier: 1.0, constant: 0))
        
        self.tableView.tableHeaderView = headerView
        
        
        if NSUserDefaults.standardUserDefaults().boolForKey("hasLaunchedBefore") {
            self.showIntroduction()
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLaunchedBefore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showIntroduction() {
        let blurEffect = UIBlurEffect(style: .Dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = UIScreen.mainScreen().bounds
        visualEffectView.alpha = 0
        self.navigationController?.view.window?.addSubview(visualEffectView)
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        let scrollView = UIScrollView()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.view.frame.size.height - 50)
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView.addSubview(scrollView)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .CenterX, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .CenterY, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Width, relatedBy: .Equal, toItem: visualEffectView, attribute: .Width, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: self.view.frame.size.height - 50))
        
        
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView.addSubview(pageControl)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .CenterX, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 5))
        
        
        
        let imageView1 = UIImageView(image: UIImage(named: "WatchImage1"))
        imageView1.frame = CGRectMake(150, scrollView.frame.origin.y + 50, 200, 200)
        imageView1.contentMode = UIViewContentMode.ScaleAspectFit
        scrollView.addSubview(imageView1)
    
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            visualEffectView.alpha = 1
        }) { (finished) -> Void in
            
        }
    }
    
    func sharePressed(barButton: UIBarButtonItem) {
        let activityVC = UIActivityViewController(activityItems: [NSLocalizedString("SHARE_TITLE", comment: ""), NSURL(string: "https://itunes.apple.com/us/app/phonebattery-your-phones-battery/id1009278300?ls=1&mt=8")!], applicationActivities: nil)
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return 3
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("GENERAL", comment: "").uppercaseString
        } else if section == 1 {
            return NSLocalizedString("WHO_MADE_THIS", comment: "").uppercaseString
        } else if section == 2 {
            return NSLocalizedString("MORE", comment: "").uppercaseString
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            var headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 20))
            
            let thanksLabel = UILabel()
            thanksLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            thanksLabel.text = NSLocalizedString("THANKS_DOWNLOADING", comment: "")
            thanksLabel.textAlignment = .Center
            thanksLabel.font = UIFont.systemFontOfSize(12)
            thanksLabel.numberOfLines = 0
            thanksLabel.textColor = UIColor(red:0.48, green:0.48, blue:0.5, alpha:1)
            headerView.addSubview(thanksLabel)
            
            headerView.addConstraint(NSLayoutConstraint(item: thanksLabel, attribute: .CenterX, relatedBy: .Equal, toItem: headerView, attribute: .CenterX, multiplier: 1.0, constant: 0))
            
            headerView.addConstraint(NSLayoutConstraint(item: thanksLabel, attribute: .Top, relatedBy: .Equal, toItem: headerView, attribute: .Top, multiplier: 1.0, constant: 5))
            
            headerView.addConstraint(NSLayoutConstraint(item: thanksLabel, attribute: .Width, relatedBy: .Equal, toItem: headerView, attribute: .Width, multiplier: 1.0, constant: -50))
            
            return headerView
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 75
            }
        }
        return 44
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier") as! UITableViewCell?
        var cell2 = tableView.dequeueReusableCellWithIdentifier("cellidentifier2") as! CreatorTableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier")
            cell2 = CreatorTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier2")
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0   {
                cell?.textLabel?.text = NSLocalizedString("SUPPORT", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = NSLocalizedString("INTRODUCTION", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            } else if indexPath.row == 2 {
                cell?.textLabel?.text = NSLocalizedString("RATE_ON_STORE", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell2?.nameLabel.text = "Marcel Voss"
                cell2?.jobLabel.text = NSLocalizedString("JOB_TITLE", comment: "")
                cell2?.avatarImageView.image = UIImage(named: "MarcelAvatar")
                return cell2!
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell?.textLabel?.text = NSLocalizedString("AVAILABLE_GITHUB", comment: "")
                cell?.accessoryType = .DisclosureIndicator
            }
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                if MFMailComposeViewController.canSendMail() {
                    let mailComposer = MFMailComposeViewController()
                    mailComposer.mailComposeDelegate = self
                    mailComposer.navigationBar.tintColor = UIColor(red:0, green:0.86, blue:0.55, alpha:1)
                    
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
                self.showIntroduction()
            } else if indexPath.row == 2 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/us/app/phonebattery-your-phones-battery/id1009278300?ls=1&mt=8")!)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                UIApplication.sharedApplication().openURL(NSURL(string: "http://twitter.com/uimarcel")!)
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/marcelvoss/PhoneBattery")!)
            }
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
