//
//  textViewStuff.swift
//  CFTtest
//
//  Created by Kovs on 23.12.2022.
//

import Foundation
import CoreData
import UIKit

func delegateSave() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    let managedContext = appDelegate.persistentContainerOffline.viewContext
    
    do {
        if managedContext.hasChanges {
            try managedContext.save()
        } else {
            print("Wrong on updating the note")
        }
    } catch let error as NSError {
        print("Could not update. \(error), \(error.userInfo)")
    }
}

