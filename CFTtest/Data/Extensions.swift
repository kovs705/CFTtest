//
//  Extensions.swift
//  CFTtest
//
//  Created by Kovs on 22.12.2022.
//

import Foundation
import UIKit
import CoreData
import SwiftUI

// Take UIColor from SwiftUI color
func returnColorFromString(nameOfColor: String) -> Color {
    return Color.init(nameOfColor)
}

func returnUIColorFromString(string: String) -> UIColor? {
    // return UIColor.init(Color.init(string))
    return UIColor(named: string)
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
    static func getUIColor(_ name: String) -> UIColor? {
        return UIColor(named: name)
    }
    
}

enum AssetsColor: String {
    case BlueBerry
    case BrownSugar
    case DarkBackground
    case GreenAvocado
    case GreyCloud
    case LightPart
    case PurpleBlackBerry
    case RedStrawBerry
    case RosePink
    case TextForegroundColor
    case YellowLemon
}


// MARK: - Dynamic height for collectionView
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}


// MARK: - View modifications
@IBDesignable extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = cornerRadius > 0
        }
        
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

