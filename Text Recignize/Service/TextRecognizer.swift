//
//  Model.swift
//  Text Recignize
//
//  Created by Ringo_02 on 1/8/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import FirebaseMLVision
import Firebase

class TextRecognizer {
    
    static func textRecognize(image: UIImage, completion: @escaping (String?) -> Void) {
        let vision = Vision.vision()
        let options = VisionCloudTextRecognizerOptions()
        options.languageHints = ["en", "ru"]
        let textRecognizer = vision.cloudTextRecognizer(options: options)
        
        let image = VisionImage(image: image)
        
        textRecognizer.process(image) { result, error in
            if error != nil {
                completion(error?.localizedDescription)
            } else {
                guard error == nil, let result = result else {
                    completion(error?.localizedDescription)
                    return
                }
                completion(result.text)
            }
        }
    }
}
