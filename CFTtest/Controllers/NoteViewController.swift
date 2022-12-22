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
    
    @IBOutlet var background: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    lazy var note = Note()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(note.emoji ?? "🤕") \(note.name ?? "Default name?...")"
        
        if image.image == nil {
            image.isHidden = true
        }
        
        textView.delegate = self
        textView.text = note.text
        
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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainerOffline.viewContext
        
        let entity =
        NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        guard let pickedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        note.setValue(pickedImage.toData as? NSData, forKey: "photo")
        note.setValue(Date(), forKey: "lastTimeChanged")
        
        do {
            if managedContext.hasChanges {
                picker.dismiss(animated: true)
                try managedContext.save()
            } else {
                print("No changes with images")
            }
        } catch {
            print("OKay, it crashed somehow")
        }
        
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
