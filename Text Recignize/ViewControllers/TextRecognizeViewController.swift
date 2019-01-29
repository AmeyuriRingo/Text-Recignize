//
//  TextRecognizeViewController.swift
//  Text Recignize
//
//  Created by Ringo_02 on 12/9/18.
//  Copyright © 2018 Ringo_02. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseMLVision
import CoreData

class TextRecognizeViewController: UIViewController {
    
    @IBOutlet weak var recognizedText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var imagePicker = UIImagePickerController()
    private var imagePickingCompletion: ((UIImage?) -> Void)?
    
    var saveData = SaveData()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        keybordManager()
        
        imagePicker.delegate = self
    }
    
    func keybordManager() {
        
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
    
    @IBAction func importFromCamera(_ sender: UIBarButtonItem) {
        
        let alert = Alert()
        openCamera { [weak self] image in
            guard let `self` = self, let newImage = image else { return }
            TextRecognizer.textRecognize(image: newImage) { [weak self] text in
                self?.recognizedText.text = text
                if (self?.recognizedText.text.isEmpty)! {
                    self?.present((alert.alert(errorText: "Text can't be recognized or not found")), animated: true, completion: nil)
                }
            }
            self.imageView.image = newImage
            UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
        }
        self.saveData.localStorageSave(text: recognizedText.text ?? "", image: imageView.image ?? UIImage())
    }
    
    @IBAction func importFromLibrary(_ sender: UIBarButtonItem) {
        
        let alert = Alert()
        openLibrary { [weak self] image in
            guard let `self` = self, let newImage = image else { return }
//            self.activityIndicator.startAnimating()
            TextRecognizer.textRecognize(image: newImage) { [weak self] text in
                self?.activityIndicator.startAnimating()
                self?.recognizedText.text = text
                if (self?.recognizedText.text.isEmpty)! {
                    self?.present((alert.alert(errorText: "Text can't be recognized or not found")), animated: true, completion: nil)
                } else {
                    self!.saveData.localStorageSave(text: text ?? "", image: newImage)
                }
            }
            self.imageView.image = image
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        
       guard Auth.auth().currentUser != nil else { return }
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out", signOutError)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    private func openLibrary(completionHandler: @escaping (UIImage?) -> Void) {
        
        imagePickingCompletion = completionHandler
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func openCamera(completionHandler: @escaping (UIImage?) -> Void) {
        
        let alert = Alert()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePickingCompletion = completionHandler
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            present(alert.alert(errorText: "Camera isn't available"), animated: true, completion: nil)
        }
    }
}

extension TextRecognizeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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


