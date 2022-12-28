//
//  SettingsVC.swift
//  CFTtest
//
//  Created by Kovs on 28.12.2022.
//

import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var fontStepper: UIStepper!
    
    var sizeOfFont: Int = 0 {
        didSet {
            fontLabel.text = "Size of the font: \(sizeOfFont)"
        }
    }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.object(forKey: "font") as? Int == nil {
            defaults.set(12, forKey: "font")
            sizeOfFont = defaults.object(forKey: "font") as! Int
        } else {
            sizeOfFont = defaults.object(forKey: "font") as! Int
        }
        
        fontLabel.text = "Size of the font: \(sizeOfFont)"
        fontStepper.addTarget(self, action: #selector(fontChanged), for: .valueChanged)
    }
    
    @objc func fontChanged() {
        sizeOfFont = Int(fontStepper.value)
        
        defaults.set(sizeOfFont, forKey: "font")
    }
    
}
