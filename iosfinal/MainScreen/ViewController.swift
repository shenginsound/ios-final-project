//
//  ViewController.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/20.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    let mainScreen = MainScreenView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
            view = mainScreen
        mainScreen.floatingButtonLogIn.addTarget(self, action: #selector(onButtonLogInTapped), for: .touchUpInside)

                    
        
        mainScreen.floatingButtonSignUp.addTarget(self, action: #selector(onButtonSignUpTapped), for: .touchUpInside)
        
        mainScreen.buttonSeeMyProfile.addTarget(self, action: #selector(onButtonSeeMyProfileTapped), for: .touchUpInside)
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
            handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
                if user == nil{
                    //MARK: not signed in...
                    self.currentUser = nil
                    self.mainScreen.labelText.text = "Please log in/sign up to Bill Divide"
                    self.mainScreen.floatingButtonLogIn.isEnabled = true
                    self.mainScreen.floatingButtonSignUp.isEnabled = true
                   
                    self.mainScreen.floatingButtonLogIn.isHidden = false
                    self.mainScreen.floatingButtonSignUp.isHidden = false
                    
                    self.mainScreen.logoImage.isHidden = false
                    
                    self.mainScreen.buttonYourGroups.isEnabled = false
                    self.mainScreen.buttonCreateGroups.isEnabled = false
                    self.mainScreen.buttonJoinAGroup.isEnabled = false
                    self.mainScreen.buttonSeeMyProfile.isEnabled = false
                    
                    
                    self.mainScreen.buttonYourGroups.isHidden = true
                    self.mainScreen.buttonCreateGroups.isHidden = true
                    self.mainScreen.buttonJoinAGroup.isHidden = true
                    self.mainScreen.buttonSeeMyProfile.isHidden = true
                    
                    
                    
                    
                    
                    self.setupRightBarButton(isLoggedin: false)
                    
                }else{
                    //MARK: the user is signed in...
                    self.currentUser = user
                    self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                    self.mainScreen.floatingButtonLogIn.isEnabled = false
                    self.mainScreen.floatingButtonSignUp.isEnabled = false
                   
                    self.mainScreen.floatingButtonLogIn.isHidden = true
                    self.mainScreen.floatingButtonSignUp.isHidden = true
                    
                    self.mainScreen.buttonYourGroups.isEnabled = true
                    self.mainScreen.buttonCreateGroups.isEnabled = true
                    self.mainScreen.buttonJoinAGroup.isEnabled = true
                    self.mainScreen.buttonSeeMyProfile.isEnabled = true
                    self.mainScreen.logoImage.isHidden = true
                    
                    
                    self.mainScreen.buttonYourGroups.isHidden = false
                    self.mainScreen.buttonCreateGroups.isHidden = false
                    self.mainScreen.buttonJoinAGroup.isHidden = false
                    self.mainScreen.buttonSeeMyProfile.isHidden = false
                    
                    
                    self.setupRightBarButton(isLoggedin: true)
                    
                }
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Bill Divide"
               
               //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
               
               //MARK: Put the floating button above all the views...
        view.bringSubviewToFront(mainScreen.floatingButtonLogIn)
        view.bringSubviewToFront(mainScreen.floatingButtonSignUp)
    }
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            Auth.auth().removeStateDidChangeListener(handleAuth!)
        }
    @objc func onButtonLogInTapped(){
        let signInAlert = UIAlertController(
                title: "Sign In / Register",
                message: "Please sign in to continue.",
                preferredStyle: .alert)
            
            //MARK: setting up email textField in the alert...
            signInAlert.addTextField{ textField in
                textField.placeholder = "Enter email"
                textField.contentMode = .center
                textField.keyboardType = .emailAddress
            }
            
            //MARK: setting up password textField in the alert...
            signInAlert.addTextField{ textField in
                textField.placeholder = "Enter password"
                textField.contentMode = .center
                textField.isSecureTextEntry = true
            }
            
            //MARK: Sign In Action...
            let signInAction = UIAlertAction(title: "Sign In", style: .default, handler: {(_) in
                if let email = signInAlert.textFields![0].text,
                   let password = signInAlert.textFields![1].text{
                    //MARK: sign-in logic for Firebase...
                    self.signInToFirebase(email: email, password: password)
                    
                }
            })
            
            //MARK: Register Action...
            let registerAction = UIAlertAction(title: "Register", style: .default, handler: {(_) in
                //MARK: logic to open the register screen...
                let registerViewController = RegisterViewController()
                self.navigationController?.pushViewController(registerViewController, animated: true)
                
            })
            
            //MARK: action buttons...
            signInAlert.addAction(signInAction)
            signInAlert.addAction(registerAction)
            
            self.present(signInAlert, animated: true, completion: {() in
                //MARK: hide the alerton tap outside...
                signInAlert.view.superview?.isUserInteractionEnabled = true
                signInAlert.view.superview?.addGestureRecognizer(
                    UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlertInViewController))
                )
            })
        
    }
    @objc func onTapOutsideAlertInViewController(){
        self.dismiss(animated: true)
    }
    @objc func onButtonSignUpTapped(){
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
    }
    func signInToFirebase(email: String, password: String){
        //MARK: can you display progress indicator here?
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...
                //MARK: can you hide the progress indicator here?
            }else{
                //MARK: alert that no user found or password wrong..
                self.showWrongUserError()
            }
        })
    }
    @objc func onButtonSeeMyProfileTapped(){
        let profileViewController = ProfileScreenViewController()
        profileViewController.currentUser = self.currentUser
        self.navigationController?.pushViewController(profileViewController, animated: true)
        
        
    }
    func showWrongUserError(){
        let alert = UIAlertController(title: "Error!", message: "Your Email or password is wrong, please go to check and login again", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
        }


}
    

