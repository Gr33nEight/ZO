//
//  DataController.swift
//  Zo
//
//  Created by Natanael Jop on 01/02/2022.
//

import Foundation
import SwiftUI
import CoreData

class DataController: NSObject, ObservableObject {
    
    let container = NSPersistentCloudKitContainer(name: "DataModel")
    
    override init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("\(error)")
            }
        }
        
    }
}

let shareDefault = UserDefaults(suiteName: "group.zo")!
