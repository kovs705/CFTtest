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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
}

//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewFlowLayout {
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
