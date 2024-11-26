//
//  ProfileScreenViewController.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/23.
//

import UIKit
import FirebaseAuth

class ProfileScreenViewController: UIViewController {
    let profileScreen = ProfileScreenView()
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = profileScreen
        
        }
    

    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        if let url = self.currentUser?.photoURL{
            self.profileScreen.profilePic.loadRemoteImage(from: url)
        }
        if let username = self.currentUser?.displayName{
            self.profileScreen.labelUserName.text = "User Name: \(username)"
            
        }
        profileScreen.buttonEditProfile.addTarget(self, action: #selector(onButtonEditProfileTapped), for: .touchUpInside)
       
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
        }
    
    @objc func onButtonEditProfileTapped(){
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.currentUser = self.currentUser
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
        
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
