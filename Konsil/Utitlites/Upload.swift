//
//  FirebaseUploader.swift
//  Token
//
//  Created by Apple on 10/14/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//
import Foundation
import Firebase
import OpalImagePicker

class FirebaseUploader
{
    static var uid = Shared.user?.id
    static var files: [String]?
    static var images: [String]?
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
    static func uploadToFirebase(viewController:UIViewController ,imagePicker:UIImagePickerController , didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any], completion: ((_ success: Bool ,_ imageURL: String) -> Void)?)
    {
        
        //to upload image to firebase storage
        
        if let image = info[.originalImage] as? UIImage{
            
            var imageData = Data()
            imageData = image.jpegData(compressionQuality: 0.3)!
            
            if let uuid = uid {
                
                let storeRef = Storage.storage().reference().child("\(uuid)/" + randomString(length: 20))
                
                let uploadImageTask = storeRef.putData(imageData, metadata: nil) { metadata, error in
                    if (error != nil) {
                        
                        print("errorrrrrr")
                        
                    } else {
                        
                        storeRef.downloadURL { url, error in
                            if let error = error {
                                print(error)
                            } else {
                                // Here you can get the download URL for 'simpleImage.jpg'
                                print(url?.absoluteString ?? "link")
                                imageURl = url?.absoluteString ?? "link"
                                completion?(true, imageURl ?? "") ?? nil
                            }
                        }
                    }
                }
                
                var alert:UIAlertController?
                
                uploadImageTask.observe(.progress) { snapshot in
                    let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                        / Double(snapshot.progress!.totalUnitCount)
                    
                    alert = UIAlertController(title: "uploading".localized, message: "please wait".localized, preferredStyle: UIAlertController.Style.alert)
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
        }
        
    }
    
    //MARK:- Upload Using Opal ImagePicker
    static func uploadImagesToFirebase(viewController:UIViewController ,imagePicker: OpalImagePickerController , pickedImage: UIImage , completion: ((_ success: Bool, _ images: [String]) -> Void)?)
    {
        
        //to upload image to firebase storage
        let image = pickedImage
        
        var imageData = Data()
        imageData = image.jpegData(compressionQuality: 0.3)!
        
        if let uuid = uid {
            let storeRef = Storage.storage().reference().child("\(uuid)/" + randomString(length: 20))
            
            let uploadImageTask = storeRef.putData(imageData, metadata: nil) { metadata, error in
                if (error != nil) {
                    print("errorrrrrr")
                } else {
                    
                    storeRef.downloadURL { url, error in
                        if let error = error {
                            print(error)
                        } else {
                            print(url?.absoluteString ?? "link")
                            imageURl = url?.absoluteString ?? "link"
                            if images?.count == nil {
                                images = [(imageURl ?? "")]
                            } else {
                                images?.append(imageURl ?? "")
                            }
                            completion?(true , images ?? []) ?? nil
                        }
                    }
                }
            }
            
            var alert:UIAlertController?
            
            uploadImageTask.observe(.progress) { snapshot in
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                
                alert = UIAlertController(title: "uploading".localized, message: "please wait".localized, preferredStyle: UIAlertController.Style.alert)
                
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
    }
    
    
    //MARK:- File Upload
    static func uploadFileToFirebase(viewController: UIViewController , documentPicker: UIDocumentPickerViewController , urls: [URL] , completion: ((_ success: Bool , _ files: [String]) -> Void)?)
    {
        
        //to upload image to firebase storage
        
        if let file = urls.first , let uuid = uid{
            let storeRef = Storage.storage().reference().child("\(uuid)/" + randomString(length: 20))
            let uploadFileTask = storeRef.putFile(from: file, metadata: nil) { (meta, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "erro")
                } else {
                    storeRef.downloadURL { (url, error) in
                        if error != nil {
                            print("Download Link Error \(error?.localizedDescription ?? "er")")
                        } else {
                            if files?.count == nil {
                                files = [(url?.absoluteString ?? "")]
                            } else {
                                files?.append((url?.absoluteString ?? ""))
                            }
                            print(files ?? [])
                            completion?(true ,files ?? []) ?? nil
                        }
                    }
                }
            }
            
            var alert:UIAlertController?
            uploadFileTask.observe(.progress) { snapshot in
                alert = UIAlertController(title: "uploading".localized , message: "please wait".localized , preferredStyle: UIAlertController.Style.alert)
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
            documentPicker.dismiss(animated: true, completion: nil)
        }
    }
    
}
