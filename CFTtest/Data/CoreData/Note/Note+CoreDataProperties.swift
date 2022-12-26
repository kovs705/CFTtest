//
//  Note+CoreDataProperties.swift
//  CFTtest
//
//  Created by Kovs on 22.12.2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var emoji: String?
    @NSManaged public var text: String?
    
    @NSManaged public var lastTimeChanged: Date?
    
    @NSManaged public var photo: Data?
}

extension NSManagedObject {
    func addObject(value: NSManagedObject, forKey key: String) {
        let note = self.mutableSetValue(forKey: key)
        note.add(value)
    }
    func removeObject(value: NSManagedObject, forKey key: String) {
        let note = self.mutableSetValue(forKey: key)
        note.remove(value)
    }
}

extension Note : Identifiable {

}
