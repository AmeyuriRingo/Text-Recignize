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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var newImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func importImage(_ sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
    }
    
    @IBOutlet weak var recognizedText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")

        }
        // Set photoImageView to display the selected image.
        newImage = selectedImage
        image()
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
   
    
    
    func image (){

        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
//        let vision = Vision.vision()
//        let options = VisionCloudTextRecognizerOptions()
//        options.languageHints = ["en", "ro"]
//        let textRecognizer = vision.cloudTextRecognizer(options: options)
        
        let image = VisionImage(image: self.newImage)
        self.imageView.image = self.newImage
        
        textRecognizer.process(image) { result, error in
            guard error == nil, let result = result else {
                return
            }

            // Recognized text
            let resultText = result.text
            //self.recognizedText.accessibilityLanguage = "русский"
            self.recognizedText.text = resultText
            
        }

        }
    }
    





