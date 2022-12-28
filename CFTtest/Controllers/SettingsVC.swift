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
    
    var sizeOfFont: Int = 12 {
        didSet {
            fontLabel.text = "Size of the font: \(sizeOfFont)"
        }
    }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.object(forKey: "font") as? Int == nil {
            defaults.set(16, forKey: "font")
            sizeOfFont = defaults.object(forKey: "font") as! Int
            fontStepper.value = Double(defaults.object(forKey: "font") as! Int)
        } else {
            sizeOfFont = defaults.object(forKey: "font") as! Int
            fontStepper.value = Double(defaults.object(forKey: "font") as! Int)
        }
        print(sizeOfFont)
        fontLabel.text = "Size of the font: \(sizeOfFont)"
        fontStepper.addTarget(self, action: #selector(fontChanged), for: .valueChanged)
    }
    
    @objc func fontChanged() {
        sizeOfFont = Int(fontStepper.value)
        
        defaults.set(sizeOfFont, forKey: "font")
    }
    
}
