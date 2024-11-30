//
//  RegisterFirebaseManager.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/22.
//

import UIKit
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
        if let name = registerView.textFieldName.text, !name.isEmpty,
           let email = registerView.textFieldEmail.text, !email.isEmpty,
           let password = registerView.textFieldPassword.text, !password.isEmpty,
           let passwordCheck = registerView.textFieldPasswordCheck.text, !passwordCheck.isEmpty{
            if isValidEmail(email){
                if password == passwordCheck{
                    let email = email.lowercased()
                    Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                        if error == nil{
                            self.setNameAndPhotoOfTheUserInFirebaseAuth(name: name, email: email, photoURL: photoURL)
                            let theUser = User(name: name, email: email.lowercased(), photoURL: photoURL!)
                            self.saveUserToFirebase(user: theUser)
                        }else{
                            if let errCode = AuthErrorCode.Code(rawValue: error!._code) {
                                if errCode == .emailAlreadyInUse {
                                    self.showExistUserError()
                                    self.hideActivityIndicator()
                                } else {
                                    self.showUnknownRegisterError()
                                    self.hideActivityIndicator()
                                    
                                }
                            }
                        }
                    })
                    
                }else{
                    self.showPasswordNotEqualError()
                    self.hideActivityIndicator()
                }
                
                
            }else{
                self.showEmailError()
                self.hideActivityIndicator()
            }
           
        }else{
            self.showEmptyError()
            self.hideActivityIndicator()
        }
    }
    func registerUserWithoutPhoto(){
        if let name = registerView.textFieldName.text, !name.isEmpty,
           let email = registerView.textFieldEmail.text, !email.isEmpty,
           let password = registerView.textFieldPassword.text, !password.isEmpty,
           let passwordCheck = registerView.textFieldPasswordCheck.text, !passwordCheck.isEmpty{
            if isValidEmail(email){
                if password == passwordCheck{
                    Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                        if error == nil{
                            self.setNameOfTheUserInFirebaseAuth(name: name)
                            let theUser = User(name: name, email: email.lowercased())
                            self.saveUserToFirebase(user: theUser)
                        }else{
                            if let errCode = AuthErrorCode.Code(rawValue: error!._code) {
                                if errCode == .emailAlreadyInUse {
                                    self.showExistUserError()
                                    self.hideActivityIndicator()
                                } else {
                                    self.showUnknownRegisterError()
                                    self.hideActivityIndicator()
                                    
                                }
                            }
                            
                        }
                    })
                }else{
                    self.showPasswordNotEqualError()
                    self.hideActivityIndicator()
                    
                }
                
            }else{
                self.showEmailError()
                self.hideActivityIndicator()
                
            }
           
        }else{
            self.showEmptyError()
            self.hideActivityIndicator()
            
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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func showEmptyError(){
        let alert = UIAlertController(title: "Error!", message: "Text Field must not be empty!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
        }
    
    func showEmailError(){
        let alert = UIAlertController(title: "Error!", message: "Email Field must be vaild!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
        }
    
    
    func showExistUserError(){
        let alert = UIAlertController(title: "Error!", message: "The User Account has been register, please log in ", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
        
    }
    
    func showPasswordNotEqualError(){
        let alert = UIAlertController(title: "Error!", message: "Your Password is not equal to your password Check field ", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
        
    }
    func showUnknownRegisterError(){
        let alert = UIAlertController(title: "Error!", message: "Sorry We can't register your account now, please come back later ", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
        
    }
    
    
}
