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
    
    private var imagePicker = UIImagePickerController()
    private var imagePickingCompletion: ((UIImage?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        imagePicker.delegate = self
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
        openLibrary { [weak self] image in
            guard let `self` = self, let newImage = image else { return }
            TextRecognizer.textRecognize(image: newImage) { [weak self] text in
                self?.recognizedText.text = text
            }
            self.imageView.image = image
        }
    }
    func openLibrary(completionHandler: @escaping (UIImage?) -> Void) {
        imagePickingCompletion = completionHandler
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let chosenImage = info[.originalImage] as? UIImage else { return }
        imagePicker.dismiss(animated: true, completion: nil)
        imagePickingCompletion?(chosenImage)
        imagePickingCompletion = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
