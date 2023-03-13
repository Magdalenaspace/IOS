//
//  ViewController.swift
//  SeeFood-CoreML
//
//  Created by Angela Yu on 27/06/2017.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import CoreML
import Vision
//Vision is going to help us process images more easily and allow us to use images to work with CoreML without writing a whole lot of code.

import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var classificationResults : [VNClassificationObservation] = []
    let imagePicker = UIImagePickerController()
    //0creating new obj -> set the delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //0Do any additional setup after loading the view.
        imagePicker.delegate = self
        //interpretations using that model.
        
        
    }
    
    func detect(image: CIImage) {
        
        // Load the ML model through its generated class
        ////3 load th model ->
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load ML model")
        }
        //-> create request to ask model to classify whatever data ia being passed - and if error than print
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            if topResult.identifier.contains("hotdog") {
                //identifier as  the propery  that voperty of 
                //here we print
                DispatchQueue.main.async {
                    self.navigationItem.title = "Hotdog!"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                }
            }
            else {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Not Hotdog!"
                    self.navigationController?.navigationBar.barTintColor = UIColor.red
                    self.navigationController?.navigationBar.isTranslucent = false
                }
            }
        }
       // data passed is being  defined over
        //using a handler let handler
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            //perform the request of classifying the image
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }

    //1 we use the image  users picks and convert it to ciaImage
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            
            imageView.image = image
            imagePicker.dismiss(animated: true, completion: nil)
            //CIImage which stands for Core Image image
            //and that's a special type of image that allow
            //we invert  UIimage to CIImage CoreImageImagae
            //if this part fails we will trigger fatal errror so we will know problem cause
            guard let ciImage = CIImage(image: image) else { //what if we cant confird the UIimage to CIImage
               //2 past that ciiImage into detect image
                fatalError("couldn't convert uiimage to CIImage")
            }
            //method that will process that CIImage and get an interpretation or classification out of it.
            detect(image: ciImage)
          
        }
    }
    
   
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary//.camera //photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
