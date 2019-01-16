//
//  ViewController.swift
//  Text Recignize
//
//  Created by Ringo_02 on 12/9/18.
//  Copyright © 2018 Ringo_02. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseMLVision

class ViewController: UIViewController {
    
    @IBOutlet weak var recognizedText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    private var newImage: UIImage!
    private var imagePickingCompletion: ((UIImage?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func importImage(_ sender: AnyObject) {
        openLibrary(vc: ViewController(), completionHandler: imagePickingCompletion!)
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = .photoLibrary
//        present(imagePickerController, animated: true, completion: nil)
//        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
    }
    func openLibrary(vc: UIViewController, completionHandler: @escaping (UIImage?) -> Void) {
        imagePickingCompletion = completionHandler
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        vc.present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let chosenImage = info[.originalImage] as? UIImage else { return }
        imagePicker.dismiss(animated: true, completion: nil)
        imagePickingCompletion?(chosenImage)
        imagePickingCompletion = nil
        newImage = chosenImage
        TextRecognizer.textRecognize(image: newImage) { [weak self] text in
            self?.recognizedText.text = text
        }
        self.imageView.image = newImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
