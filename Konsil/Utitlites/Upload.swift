//
//  FirebaseUploader.swift
//  Token
//
//  Created by Apple on 10/14/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//
import Foundation
import Firebase
class FirebaseUploader
{
    static var imageURl: String?
    static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    static func uploadToFirebase(viewController:UIViewController,imagePicker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) -> String
    {
        
        //to upload image to firebase storage
        
        var final: String?
            
            if let image = info[.originalImage] as? UIImage{
                
                var imageData = Data()
                imageData = image.jpegData(compressionQuality: 0.5)!
                
                
                let storeRef = Storage.storage().reference().child("images/" + randomString(length: 20))
                
                let uploadImageTask = storeRef.putData(imageData, metadata: nil) { metadata, error in
                    if (error != nil) {
                        
                        print("error")
                        
                    } else {
                        
                        storeRef.downloadURL { url, error in
                            if let error = error {
                                
                                print(error)
                                
                            } else {
                                // Here you can get the download URL for 'simpleImage.jpg'
                                print(url?.absoluteString ?? "link")
                                final = url?.absoluteString ?? "link"
                            }
                        }
                        
                    }
                }
                
                var alert:UIAlertController?
                
                uploadImageTask.observe(.progress) { snapshot in
                    let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                        / Double(snapshot.progress!.totalUnitCount)
                    
                    alert = UIAlertController(title: "Upliading", message: "Please Wait", preferredStyle: UIAlertController.Style.alert)
                    
                    viewController.present(alert!, animated: true, completion: nil)
                    
                    print(percentComplete)
                }
                
                uploadImageTask.observe(.success) { snapshot in
                    
                    print("done")
                    viewController.dismiss(animated: true, completion: nil)
                }
            
            //dismiss(animated: true, completion: nil)
            imagePicker.dismiss(animated: true, completion: nil)
        }
        
        return final ?? ""
        
    }
    
    static func uploadFileToFirebase(viewController: UIViewController , documentPicker: UIDocumentPickerViewController , urls: [URL] , uid: String)
    {
        
        //to upload image to firebase storage
        
        var _: String?
        
        if let file = urls.first {
            
            let storeRef = Storage.storage().reference().child("\(uid)/" + randomString(length: 20))
            
            let uploadFileTask = storeRef.putFile(from: file, metadata: nil) { (meta, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "erro")
                } else {
                    storeRef.downloadURL { (url, error) in
                        if error != nil {
                            print("Download Link Error \(error?.localizedDescription ?? "er")")
                        } else {
                            print(url?.absoluteString ?? "url")
                        }
                    }
                }
            }
            var alert:UIAlertController?
            
            uploadFileTask.observe(.progress) { snapshot in
                
                alert = UIAlertController(title: "uploading", message: "please wait", preferredStyle: UIAlertController.Style.alert)
                viewController.present(alert!, animated: true, completion: nil)
                
                var percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount){
                    didSet{
                        alert?.message = "please wait \(percentComplete)"
                    }
                }
                print(percentComplete)
            }
            
            uploadFileTask.observe(.success) { snapshot in
                print("done")
                viewController.dismiss(animated: true, completion: nil)
            }
            
            //dismiss(animated: true, completion: nil)
            documentPicker.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
