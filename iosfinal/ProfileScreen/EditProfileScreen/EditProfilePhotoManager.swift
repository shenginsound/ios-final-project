//
//  EditProfilePhotoManager.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/25.
//

import Foundation


import UIKit
import PhotosUI

//MARK: adopting required protocols for PHPicker...
extension EditProfileViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(
                    ofClass: UIImage.self,
                    completionHandler: { (image, error) in
                        DispatchQueue.main.async{
                            if let uwImage = image as? UIImage{
                                
//                                self.editProfileView.buttonTakeEditPhoto.setImage(
//                                    uwImage.withRenderingMode(.alwaysOriginal),
//                                    for: .normal
//                                )
                                self.pickedImage = uwImage
                                self.editProfileView.editProfilePic.image = uwImage
                                self.editProfileView.editProfilePic.setNeedsDisplay()
                            }
                        }
                    }
                )
            }
        }
    }
}

//MARK: adopting required protocols for UIImagePicker...
extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editProfileView.buttonTakeEditPhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
            self.editProfileView.editProfilePic.image = image
            self.editProfileView.editProfilePic.setNeedsDisplay()

        }else{
            // Do your thing for No image loaded...
        }
    }
}

