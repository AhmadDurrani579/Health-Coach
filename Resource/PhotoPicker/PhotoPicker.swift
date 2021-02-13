//
//  PhotoPicker.swift
//  
//
//  Created by Asif Bilal on 23/05/2016.
//  Copyright © 2016 Asif Bilal. All rights reserved.
//

import UIKit

public class PhotoPicker: NSObject {
    
    public enum PickerSourceType: Int {
        case Camera = 0,
        PhotoLibrary,
        CameraAndPhotoLibrary
    }
    

    var successBlock:((_ originalPhoto:UIImage?,_ editedPhoto: UIImage?) -> ())!
    
    public func pick(allowsEditing:Bool = false,
              pickerSourceType: PickerSourceType = .PhotoLibrary,
              controller: UIViewController,
              successBlock success:@escaping (_ originalPhoto:UIImage?, _ editedPhoto: UIImage?) -> ())
    {
        
        if pickerSourceType == .CameraAndPhotoLibrary {
            
           let alertController = UIAlertController(title: "Select", message: "Source Type", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                print("User pressed Cancel")
            }))
            
            alertController.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { action in
                self.pick(allowsEditing: allowsEditing, pickerSourceType: .Camera, controller: controller, successBlock: success)
            }))
            
            alertController.addAction(UIAlertAction(title: "Choose photo", style: .default, handler: { action in
                self.pick(allowsEditing: allowsEditing, pickerSourceType: .PhotoLibrary, controller: controller, successBlock: success)
            }))
            
            controller.present(alertController, animated: true, completion: nil)
            
            return
            
        }
        var sourceType:UIImagePickerController.SourceType!
        
        switch pickerSourceType {
        case .Camera:
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                sourceType = .camera
            } else {
                sourceType = .savedPhotosAlbum
            }
            
        case .PhotoLibrary:
            sourceType = .photoLibrary
        default:
            sourceType = .savedPhotosAlbum
            
        }
        
        let picker = UIImagePickerController()
        
        picker.sourceType = sourceType
        picker.allowsEditing = allowsEditing
        
        picker.delegate = self
        
        self.successBlock = success
        
        controller.present(picker, animated: true, completion: nil)
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
//            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
//            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }

    
}

extension PhotoPicker: UINavigationControllerDelegate {

}

extension PhotoPicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
   public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
     {
        var editedPhoto:UIImage = UIImage()
        var originalPhoto:UIImage = UIImage()
        
        if let phots  = info[.editedImage] {
            editedPhoto = phots as! UIImage
            
        } else{
            print("Something went wrong")
        }
        
        
//        UIImageWriteToSavedPhotosAlbum(editedPhoto, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

        if let photos = info[.originalImage] {
            originalPhoto = photos as! UIImage
            if picker.sourceType.rawValue == 1  {
                UIImageWriteToSavedPhotosAlbum(originalPhoto , self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

   }

        }else{
            print("Something went wrong")
        }
        successBlock(originalPhoto, editedPhoto)
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
