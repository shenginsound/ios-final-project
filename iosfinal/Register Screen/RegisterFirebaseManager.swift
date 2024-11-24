//
//  RegisterFirebaseManager.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/22.
//

import Foundation
import FirebaseAuth

import FirebaseFirestore
import FirebaseFirestoreSwift

import FirebaseStorage

extension RegisterViewController{
    
    
    func uploadProfilePhotoToStorage(){
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
                                profilePhotoURL = url
                                self.registerUser(photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }else{
            //if the user did not choose a
            registerUserWithoutPhoto()
        }
    }
    
    func registerUser(photoURL: URL?){
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    self.setNameAndPhotoOfTheUserInFirebaseAuth(name: name, email: email, photoURL: photoURL)
                    let theUser = User(name: name, email: email.lowercased(), photoURL: photoURL!)
                    self.saveUserToFirebase(user: theUser)
                }
            })
        }
    }
    func registerUserWithoutPhoto(){
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text{
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    let theUser = User(name: name, email: email.lowercased())
                    self.saveUserToFirebase(user: theUser)
                }
            })
        }
    }
    
    
    func setNameAndPhotoOfTheUserInFirebaseAuth(name: String, email: String, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
        
        print("\(photoURL)")
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func saveUserToFirebase(user: User){
    let collectionContacts = database
        .collection("users").document(user.email)
                do{
                    try collectionContacts.setData(from: user, merge: true, completion: {(error) in
                        if error == nil{
                            print("Save the user to database correctly")
                            
                        }
                    })
                }catch{
                    print("Error adding document!")
                }
    }

    
//    func registerNewAccount(){
//        showActivityIndicator()
//        //MARK: create a Firebase user with email and password...
//        if let name = registerView.textFieldName.text,
//           let email = registerView.textFieldEmail.text,
//           let password = registerView.textFieldPassword.text{
//            //Validations....
//            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
//                if error == nil{
//                    //MARK: the user creation is successful...
//                    self.setNameOfTheUserInFirebaseAuth(name: name)
//                    let theUser = User(name: name, email: email.lowercased())
//                    self.saveUserToFirebase(user: theUser)
//
//                }else{
//                    //MARK: there is a error creating the user...
//                    print(error)
//                }
//            })
//        }
//    }
//
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    
}
