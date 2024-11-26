//
//  EditProfileViewController.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

import FirebaseFirestoreSwift

class EditProfileViewController: UIViewController {
    
    let editProfileView = EditProfileView()
    var currentUser:FirebaseAuth.User?
    var pickedImage:UIImage?
    let storage = Storage.storage()
    let database = Firestore.firestore()
    
    
    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileView.buttonCancel.addTarget(self, action: #selector(onButtonCancelTapped), for: .touchUpInside)
        editProfileView.textFieldEditUserName.text = self.currentUser?.displayName
        
        if let url = self.currentUser?.photoURL{
            self.editProfileView.editProfilePic.loadRemoteImage(from: url)
        }
        editProfileView.buttonTakeEditPhoto.menu = getMenuImagePicker()
        
        editProfileView.buttonSaveProfile.addTarget(self, action: #selector(onButtonSaveTapped), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    @objc func onButtonCancelTapped(){
        self.navigationController?.popViewController(animated: true)
        
    }
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                    self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                    self.pickPhotoFromGallery()
            })
            ]
            
            return UIMenu(title: "Select source", children: menuItems)
        }
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        //MARK: Photo from Gallery...
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    @objc func onButtonSaveTapped(){
        if let editName = self.editProfileView.textFieldEditUserName.text{
            self.changeAndUploadProfilePhotoToStorage(editName: editName)
            
        }else{
            print("save unsuccessfully")
        }
    }
    func changeAndUploadProfilePhotoToStorage(editName: String){
        var profilePhotoURL:URL?
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedImage{
            if let jpegData = image.jpegData(compressionQuality: 80){
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("imagesUsers")
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                if let url = url {
                                    
                                    print(type(of: url))
                                    profilePhotoURL = url
                                    self.ChangeNameAndPhotoOfTheUserInFirebaseAuth(editName: editName, photoURL: profilePhotoURL)
                                    print("change name and photo successfully")
                                    
                                    
                                    self.updateNameAndPhotoURLInFirebaseDatabase(editName: editName, editPhotoURL: profilePhotoURL)
                                    print("change name and photo in database succefully")
                                    
                                }else{
                                    print("Wrong: uel type is: ")
                                    print(type(of: url))
                                }
                                
                                
                            }
                        })
                    }
                })
            }
        }else{
            //if the user did not choose a
            //registerUserWithoutPhoto()
            self.ChangeNameOfTheUserInFirebaseAuth(editName: editName)
            print("change Name successfully")
            self.updateNameInFirebaseDatabase(editName: editName)
            print("change name in database succefully")
        }
    }
    func ChangeNameAndPhotoOfTheUserInFirebaseAuth(editName: String, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = editName
        changeRequest?.photoURL = photoURL
        
        print("\(photoURL)")
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
//                self.hideActivityIndicator()
//                self.navigationController?.popViewController(animated: true)
                self.currentUser?.reload()
                print("change photo and name successfully")
            }
        })
    }
    func ChangeNameOfTheUserInFirebaseAuth(editName: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = editName
  
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
//                self.hideActivityIndicator()
//                self.navigationController?.popViewController(animated: true)
                self.currentUser?.reload()
                print("change name successfully")
            }
        })
    }
    
    func updateNameAndPhotoURLInFirebaseDatabase(editName: String, editPhotoURL: URL?){
        if let userEmail = self.currentUser?.email, let photoURLString = editPhotoURL?.absoluteString {
            let updateUserNameAndPhotoURLRequest = database
                .collection("users")
                .document(userEmail)
            let userEditData: [String: Any] = [
                        "name": editName,
                        "photoURL": photoURLString
                    ]
            updateUserNameAndPhotoURLRequest.setData(userEditData, merge: true) { error in
                    if let error = error {
                        print("Error updating user: \(error.localizedDescription)")
                    } else {
                        print("User fields updated successfully!")
                    }
                }
            
        }else{
            print("currentUser name: \(self.currentUser?.email)")
            print("unsuccessfully change name in database")
        }
        
        
    }
    func updateNameInFirebaseDatabase(editName: String){
        if let userEmail = self.currentUser?.email{
            let updateUserNameAndPhotoURLRequest = database
                .collection("users")
                .document(userEmail)
            updateUserNameAndPhotoURLRequest.updateData([
                    "name": editName,
                ]) { error in
                    if let error = error {
                        print("Error updating user: \(error.localizedDescription)")
                    } else {
                        print("User fields updated successfully!")
                    }
                }
            
        }else{
            print("currentUser name: \(self.currentUser?.email)")
            print("unsuccessfully change name in database")
        }
        
        
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
