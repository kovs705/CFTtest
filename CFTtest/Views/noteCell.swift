//
//  noteCell.swift
//  CFTtest
//
//  Created by Kovs on 22.12.2022.
//

import UIKit

class noteCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var noteName: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    
    func setBackground(color: String) {
        containerView.backgroundColor = UIColor.appColor(AssetsColor(rawValue: color)!)
    }
    func setNoteName(label: String) {
        noteName.text = label
    }
    
    func setEmoji(emoji: String) {
        emojiLabel.text = emoji
    }
    
}
