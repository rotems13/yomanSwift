//
//  AppDelegate.swift
//  yoman
//
//  Created by רותם שיין on 22/11/2017.
//  Copyright © 2017 רותם שיין. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps


var internetConnection : Bool = true

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //status bar style
        // UIApplication.shared.statusBarStyle = .lightContent
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)){
            statusBar.backgroundColor = UIColor(red: 55.0/255.0, green: 71.0/255.0, blue: 79.0/255.0, alpha: 1.0)
        }
        UIApplication.shared.statusBarStyle = .lightContent
        


        //google map key
        GMSServices.provideAPIKey("AIzaSyC3DWMJLZPvRp36Wnxb0-AhxU3xq1kDau4")
        
        //intetnet connection
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
        updateUserInterface()
        do {
            Network.reachability = try Reachability(hostname: "www.google.com")
            do {
                try Network.reachability?.start()
            } catch let error as Network.Error {
                print(error)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        return true
    }
    
    func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        if(!(Network.reachability?.isReachable)!){
            print("no Internet!!!!!")
            internetConnection = false
            print(internetConnection)
            let ac = UIAlertController.init(title: "title", message: "msg", preferredStyle: .actionSheet)
            ac.view.tintColor = UIColor.blue
            
            ac.addAction(UIAlertAction.init(title: "OK",
                                            style: .default, handler: nil))
            self.window?.rootViewController?.present(ac, animated: true, completion: nil)
            
        }else {internetConnection = true}
        
        
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
        
        
        //        if dontRemindKey != nil {
        //            ac.addAction(UIAlertAction.init(title: "Don't Remind",
        //                                            style: .default, handler: { (aa) in
        //                                                UserDefaults.standard.set(true, forKey: dontRemindKey!)
        //                                                UserDefaults.standard.synchronize()
        //            }))
        //        }
        
        
    }
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
        
        // Access the storyboard and fetch an instance of the view controller
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        //        let viewController: welcomeScreen = storyboard.instantiateViewController(withIdentifier: "welcomeScreen") as! welcomeScreen;
        //
        //        self.window.rootViewController = MainStoryboard.instantiateInitialViewController()
        
        
        //
        //        // Then push that view controller onto the navigation stack
        //        let rootViewController = self.window!.rootViewController as! UIViewController!;
        //        rootViewController.pushViewController(viewController, animated: true);
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "yoman")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

