//
//  MainScreenView.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/21.
//

import UIKit

class MainScreenView: UIView {
    
    var labelText: UILabel!
    var logoImage: UIImageView!
    var floatingButtonLogIn: UIButton!
    var floatingButtonSignUp: UIButton!
    
    var buttonYourGroups: UIButton!
    var buttonCreateGroups: UIButton!
    var buttonJoinAGroup: UIButton!
    var buttonSeeMyProfile: UIButton!
    
    
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            
            //setupProfilePic()
            setupLabelText()
            setupFloatingButtonLogIn()
            //setupTableViewContacts()
            setupFloatingButtonSignUp()
            setuplogoImage()
            
            setupButtonYourGroups()
            setupButtonCreateGroups()
            setupButtonJoinAGroup()
            setupButtonSeeMyProfile()
            
            initConstraints()
        }
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 20)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
        
        
    }
    func setuplogoImage(){
        logoImage = UIImageView()
        logoImage.image = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
        logoImage.contentMode = .scaleToFill
        logoImage.clipsToBounds = true
        logoImage.layer.masksToBounds = true
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoImage)
        
        
    }
    func setupFloatingButtonLogIn(){
        floatingButtonLogIn = UIButton(type: .system)
        floatingButtonLogIn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        floatingButtonLogIn.setTitle("Log in", for: .normal)
        floatingButtonLogIn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonLogIn)
        
        
    }
    func setupFloatingButtonSignUp(){
        floatingButtonSignUp = UIButton(type: .system)
        floatingButtonSignUp.titleLabel?.font = .boldSystemFont(ofSize: 16)
        floatingButtonSignUp.setTitle("Sign Up", for: .normal)
        floatingButtonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonSignUp)
        
        
        
    }
    func setupButtonYourGroups(){
        buttonYourGroups = UIButton(type: .system)
        buttonYourGroups.titleLabel?.font = .boldSystemFont(ofSize: 20)
        buttonYourGroups.setTitle("My Groups", for: .normal)
        buttonYourGroups.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonYourGroups)
        
        
    }
    func setupButtonCreateGroups(){
        buttonCreateGroups = UIButton(type: .system)
        buttonCreateGroups.titleLabel?.font = .boldSystemFont(ofSize: 20)
        buttonCreateGroups.setTitle("Create a Group", for: .normal)
        buttonCreateGroups.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonCreateGroups)
        
        
    }
    func setupButtonJoinAGroup(){
        buttonJoinAGroup = UIButton(type: .system)
        buttonJoinAGroup.titleLabel?.font = .boldSystemFont(ofSize: 20)
        buttonJoinAGroup.setTitle("Join a Group", for: .normal)
        buttonJoinAGroup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonJoinAGroup)
        
        
    }
    func setupButtonSeeMyProfile(){
        buttonSeeMyProfile = UIButton(type: .system)
        buttonSeeMyProfile.titleLabel?.font = .boldSystemFont(ofSize: 20)
        buttonSeeMyProfile.setTitle("See/Edit Profile", for: .normal)
        buttonSeeMyProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSeeMyProfile)
        
        
    }
    
    func initConstraints(){
            NSLayoutConstraint.activate([
//                profilePic.widthAnchor.constraint(equalToConstant: 32),
//                profilePic.heightAnchor.constraint(equalToConstant: 32),
//                profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
//                profilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//
                labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
                labelText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                logoImage.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
                logoImage.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 24),
                
                floatingButtonLogIn.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
                floatingButtonLogIn.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 8),
                
                floatingButtonSignUp.centerXAnchor.constraint(equalTo: floatingButtonLogIn.centerXAnchor),
                floatingButtonSignUp.topAnchor.constraint(equalTo: floatingButtonLogIn.bottomAnchor, constant: 8),
                
                buttonYourGroups.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
                buttonYourGroups.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 16),
                
                buttonCreateGroups.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
                buttonCreateGroups.topAnchor.constraint(equalTo: buttonYourGroups.bottomAnchor, constant: 16),
                
                buttonJoinAGroup.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
                buttonJoinAGroup.topAnchor.constraint(equalTo: buttonCreateGroups.bottomAnchor, constant: 16),
                
                buttonSeeMyProfile.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
                buttonSeeMyProfile.topAnchor.constraint(equalTo: buttonJoinAGroup.bottomAnchor, constant: 16),
                
                


            ])
        }
    
   
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
