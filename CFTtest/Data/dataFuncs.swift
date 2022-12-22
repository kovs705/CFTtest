//
//  dataFuncs.swift
//  CFTtest
//
//  Created by Kovs on 22.12.2022.
//

import Foundation
import CoreData
import UIKit

func sortNotesByNumber(_ notes: [Note]) -> [Note] {
    notes.sorted { noteA, noteB in
        noteA.number < noteB.number
    }
}
