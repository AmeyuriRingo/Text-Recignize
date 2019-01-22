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
import GoogleSignIn
import CoreData

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
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()

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
        openCamera { [weak self] image in
            guard let `self` = self, let newImage = image else { return }
            TextRecognizer.textRecognize(image: newImage) { [weak self] text in
                self?.recognizedText.text = text
            }
            self.imageView.image = image
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
    }
    
    @IBAction func importFromLibrary(_ sender: UIBarButtonItem) {
        openLibrary { [weak self] image in
            guard let `self` = self, let newImage = image else { return }
            TextRecognizer.textRecognize(image: newImage) { [weak self] text in
                self?.recognizedText.text = text
            }
            self.imageView.image = image
        }
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        if let nextViewController = TableViewController.storyboardInstance() {
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    
    }
    
    static func storyboardInstance() -> ViewController? {
        let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
        return storyboard.instantiateInitialViewController() as? ViewController
    }
    
    func openLibrary(completionHandler: @escaping (UIImage?) -> Void) {
        imagePickingCompletion = completionHandler
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera(completionHandler: @escaping (UIImage?) -> Void) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
        imagePickingCompletion = completionHandler
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        } else {
            recognizedText.text = "Camera is not available"
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, GIDSignInUIDelegate {
    
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


