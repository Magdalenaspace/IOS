//
//  AppDelegate.swift
//  Transformation Progress App
//
//  Created by Magdalena Samuel on 2/21/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        ///print and to prove to you that our data has been saved somewhere, even though it's  not showing up. this gets saved in pilist
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true).last! as String)
        return true
    }
 
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
          }
          
          // MARK: - Core Data stack
          
          lazy var persistentContainer: NSPersistentContainer = {

              let container = NSPersistentContainer(name: "DataModel")
              container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                  if let error = error as NSError? {

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

                      let nserror = error as NSError
                      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                  }
              }
          }



      }



//app enters the background, it still keeps a hold of that data in
//
//    the memory of the phone.
//
//    So when I reopen it, you can see that it still exists.
//
//    Now, the problem occurs when the app doesn't just enter the background, but actually terminates.
//
//    So all of scenarios where this might happen is, A: you're operating system trying to reclaim resources
//
//    because the user is trying to use like a really memory intensive app,
//
//    second option is if the user force quit your app.
//
//    Third option: if you installed an update to your app.
//
//    Fourth option: if the user updated their operating system. There are so many cases where your app is probably
//
//    going to end up terminating.
//
//    And when that happens,
    
    
//    it's gone from the memory of the phone.
//
//    And if we click on it again, you can see that new item that we added is now gone.
//
//    And this is because we don't have any form of persistent data storage.
//
//    We're only adding and appending to our array and that array is only going to be held in memory for as
//
//    long as this TodoListViewController exists.
//
//    And it's going to disappear and be destroyed if the application gets terminated.
//
//    So this is why we need persistent memory storage.
    
//    small bits of
//
//    data, and that's through using NSUserDefaults.



