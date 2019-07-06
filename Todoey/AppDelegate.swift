//
//  AppDelegate.swift
//  Todoey
//
//  Created by Jonathan Smith on 28/6/19.
//  Copyright © 2019 Jonathan Smith. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing new Realm, \(error)")
        }
        

        return true
    }

}
