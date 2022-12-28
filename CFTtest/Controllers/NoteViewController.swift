//
//  NoteViewController.swift
//  CFTtest
//
//  Created by Kovs on 23.12.2022.
//

import Foundation
import SwiftUI
import UIKit
import CoreData

class NoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    var note = Note()
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.alwaysBounceVertical = true
        
        title = "\(note.emoji ?? "🤕") \(note.name ?? "Default name?...")"
        
        image.image = UIImage(data: (note.photo ?? UIImage(systemName: "figure.roll.runningpace")?.toData)!)
        
        print("Image is hidden: \(image.isHidden)")
        print("Button is hidden: \(imageButton.isHidden)")
        
        if defaults.object(forKey: "font") as? Int == nil {
            defaults.set(12, forKey: "font")
            // настройки не были открыты, так что автоматически мы поставили Вам размер шрифта 12
        }
        
        if note.emoji != "💀" {
            textView.delegate = self
            textView.text = note.text
            textView.isEditable = true
            
            textView.font = UIFont.systemFont(ofSize: CGFloat(defaults.object(forKey: "font") as! Int))
        } else {
            textView.delegate = self
            textView.text = "Oops, you've got a wrong random emoji, try creating another new note😈"
            textView.isEditable = false
        }
        
        image.frame = CGRect(x: 0, y: 0, width: image.bounds.width, height: 250)
        
        if image.image == nil || (UIImage(systemName: "figure.roll.runningpace") != nil) {
            changeButton.isHidden = true
        } else {
            changeButton.isHidden = false
        }
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        showPhotoPicker()
    }
    
    @IBAction func changePhoto(_ sender: UIButton) {
        showPhotoPicker()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if image.image == nil || (UIImage(systemName: "figure.roll.runningpace") != nil) {
            changeButton.isHidden = true
        } else {
            changeButton.isHidden = false
        }
    }
    
    
    // MARK: - ImagePicker
    @objc func showPhotoPicker() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
    }
    
    
    
    // MARK: - TextView
    
    func textViewDidChange(_ textView: UITextView) {
        update(text: textView.text, textView: textView)
    }
    
    func update(text: String, textView: UITextView?) {

/// update the date of the last changing
        note.setValue(Date(), forKey: "lastTimeChanged")
/// update the text of the note
        note.setValue(text, forKey: "text")
        
        delegateSave()
    }
    
//    func textChanged(action: @escaping (String) -> Void) {
//        textChanged = action
//    }
//
//    func textViewDidChange(_ text: UITextView) {
//        textChanged(text.text)
//    }
}

//// MARK: - class UITextViewPadding
//class UITextViewPadding : UITextView {
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
//    }
//}


// MARK: - UIImagePicker
extension NoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("closed")
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let pickedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        let photoData = pickedImage.pngData()
        
        note.setValue(photoData as? NSData, forKey: "photo")
        note.setValue(Date(), forKey: "lastTimeChanged")
        
        delegateSave()
        
        picker.dismiss(animated: true)
        image.isHidden = false
        imageButton.isHidden = true
        
        imageButton.layoutIfNeeded()
        image.layoutIfNeeded()
        
        print("Image is hidden: \(image.isHidden)")
        print("Button is hidden: \(imageButton.isHidden)")
        
        print("Saved")
        print("\(String(describing: note.lastTimeChanged))")
    }
}

// MARK: - Extension UIImage
extension UIImage {
    var toData: Data? {
        return pngData()
    }
    
    func getCropRatio() -> CGFloat {
        let widthRatio = self.size.width / self.size.height
        return widthRatio
    }
}
