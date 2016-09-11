//
//  AppDelegate.swift
//  BeThere
//
//  Created by jared weinstein on 9/10/16.
//  Copyright © 2016 Jared Weinstein. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        registerForPushNotifications(application)
        LocationUtil.sharedInstance.setup()
        
        // Check if launched from notification
        // 1
        if let notification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? [String: AnyObject] {
            // 2
            NSLog("Started from notification")
            //TODO: Open the app to the missed event
            //let aps = notification["aps"] as! [String: AnyObject]
            //createNewNewsItem(aps)
            // 3
            //(window?.rootViewController as? UITabBarController)?.selectedIndex = 1
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: Handling Push Notifications
    func registerForPushNotifications(application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.Badge, .Sound, .Alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        print("Device Token:", tokenString)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register:", error)
    }
    
    //Handle push notifications while the app is open
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        NSLog("Did Recieve Remote Notification")
        let aps = userInfo["aps"] as! [String: AnyObject]
        
        // 1
        if (aps["content-available"] as? NSString)?.integerValue == 1 {
            //Event Began
            let id = userInfo["event_id"] as? String ?? "default"
            
            if UIApplication.sharedApplication().applicationState == .Active {
                NSLog("Refresh in Foreground")
                let lastLocation = LocationUtil.sharedInstance.lastLocation!
                Alamofire.request(.POST, "\(Utilities.getURL())/event/\(id)/location?latitude=\(lastLocation.coordinate.latitude)&longitude=\(lastLocation.coordinate.longitude)")
                    .responseString() { string in
                        NSLog("RESPONSE : \(string.description)")
                        if string.description.containsString("true") {
                            self.displayAlert(title: "Good Work", message: "You made it on time")
                        } else if string.description.containsString("false") {
                            self.displayAlert(title: "Event Missed", message: "Your multiplier has increased")
                        } else {
                            self.displayAlert(title: "Error", message: "you had one job and you fucked it up")
                        }
                }
            } else {
                NSLog("silent refreshing in background")
                LocationUtil.sharedInstance.locationManager.startUpdatingLocation()
                
                //LocationUtil.sharedInstance.uploadNextLocation(){
                LocationUtil.sharedInstance.backgroundFunction = {
                    NSLog("on loc update")
                    completionHandler(.NoData)
                }
            }
        } else  {
            NSLog("normal refresh")
            // Event Missed or Completed
            completionHandler(.NoData)
        }
    }
    
    private func displayAlert(title title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        
        let navController = UIApplication.sharedApplication().keyWindow?.rootViewController?.navigationController
        navController?.presentViewController(alertController, animated: true) {}
    }
}

