//
//  ViewController.swift
//  CFTtest
//
//  Created by Kovs on 22.12.2022.
//

import Foundation
import UIKit
import CoreData
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet var background: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var noteCV: UICollectionView!
    
    let identifierforNote = "note"
    
    var notes: [NSManagedObject] = []
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteCV.allowsSelection = true
        noteCV.dataSource = self
        noteCV.delegate = self
        
        fetchData()
        
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        
    }
    
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext       = appDelegate.persistentContainerOffline.viewContext
        let fetchRequest      = NSFetchRequest<NSManagedObject>(entityName: "Note")
        let sort              = NSSortDescriptor(key: "number", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            return notes = try viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.notes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let note = self.notes[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierforNote, for: indexPath as IndexPath) as! noteCell
        
        cell.setNoteName(label: note.value(forKey: "name") as? String ?? "default name")
        cell.setBackground(color: note.value(forKey: "color") as? String ?? "GreenAvocado")
        
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Animation
        // cell.alpha = 0
        // cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfGroupsPerRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfGroupsPerRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfGroupsPerRow))
        
        return CGSize(width: size, height: size)
        
            // return CGSize(width: 165, height: 165)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicked")
    }

}
