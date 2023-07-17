//
//  AppDelegate.swift
//  colonCancer
//
//  Created by KH on 16/03/2023.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
//        let db = Firestore.firestore()
//        print (db)
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                  print("Notification authorization granted.")
                  // Perform any additional actions when authorization is granted
              } else {
                  print("Notification authorization denied.")
                  // Perform any actions when authorization is denied or not determined
              }
        }
            // Handle authorization result
        return true
    }
    
    // Handle foreground notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        // Get the topmost view controller
        if let topViewController = UIApplication.shared.topViewController() {
            if let navigationController = topViewController.navigationController {
                let AlertViewController = AlertViewController(TitleLbl:  notification.request.content.title, BodyLbl:  notification.request.content.body, viewController: topViewController)
                let vc = UINavigationController(rootViewController:AlertViewController)
                navigationController.present(vc, animated: true)
            }
            //            topViewController.present(alertController, animated: true, completion: nil)
        }
        
//
//        let alertController = UIAlertController(title: notification.request.content.title,
//                                                message: notification.request.content.body,
//                                                preferredStyle: .alert)
//
//        let okAction = UIAlertAction(title: "OK", style: .default)
//
//        alertController.addAction(okAction)
//
    }
    
    // Handle background or inactive notifications
       func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
           // Retrieve the notification content
            let content = response.notification.request.content
            
           // Make an alert
//            let alertController = UIAlertController(title: content.title,
//                                                   message: content.body,
//                                                   preferredStyle: .alert)
//
//            let okAction = UIAlertAction(title: "OK", style: .default)
//
//            alertController.addAction(okAction)
         
            // Get the identifier of the action tapped by the user (if any)
            let actionIdentifier = response.actionIdentifier
            
            // Check the action identifier to determine the user's response
            if actionIdentifier == UNNotificationDefaultActionIdentifier {
                // User tapped on the notification itself
                // Handle the action, for example, navigate to a specific view controller
                let viewController = ReminderViewController()
                // Configure the view controller if needed
                
                // Access the root view controller
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let keyWindow = scene.windows.first(where: { $0.isKeyWindow }),
                   let rootViewController = keyWindow.rootViewController {
                    let AlertViewController = AlertViewController(TitleLbl:  content.title, BodyLbl: content.body, viewController: rootViewController)
                    let vc = UINavigationController(rootViewController:AlertViewController)
                    rootViewController.present(vc, animated: true)
                }
            } else if actionIdentifier == UNNotificationDismissActionIdentifier {
                // User dismissed the notification without taking any action
                // Handle the dismiss action if needed
            } else {
                // User tapped on a custom action (if any)
                // Handle the custom action if needed
            }
            
            // Call the completion handler when you're done
            completionHandler()
       }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "colonCancer")
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


extension UIApplication {
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
