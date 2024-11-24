//
//  ProfileScreenView.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/23.
//

import UIKit

class ProfileScreenView: UIView {
    var profilePic: UIImageView!
    var labelTitle: UILabel!
    var labelUserName: UILabel!
    var buttonEditProfile: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupProfilePic()
        setupLabelTitle()
        setupLabelUserName()
        setupButtonEditProfile()
        initConstraints()
    }
    func setupProfilePic(){
        profilePic = UIImageView()
        profilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleToFill
        profilePic.clipsToBounds = true
        profilePic.layer.masksToBounds = true
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePic)
        
    }
    func setupLabelTitle(){
        labelTitle = UILabel()
        labelTitle.font = .boldSystemFont(ofSize: 20)
        labelTitle.text = "Profile Photo"
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
        
        
    }
    func setupLabelUserName(){
        labelUserName = UILabel()
        labelUserName.font = .boldSystemFont(ofSize: 20)
        labelUserName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelUserName)
        
    }
    func setupButtonEditProfile(){
        buttonEditProfile = UIButton(type: .system)
        buttonEditProfile.titleLabel?.font = .boldSystemFont(ofSize: 24)
        buttonEditProfile.setTitle("Edit Profile", for: .normal)
        buttonEditProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEditProfile)
        
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 100),
            labelTitle.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            profilePic.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            profilePic.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
            profilePic.widthAnchor.constraint(equalToConstant: 200),
            profilePic.heightAnchor.constraint(equalToConstant: 200),
            profilePic.topAnchor.constraint(equalTo:labelTitle.bottomAnchor, constant: 8),
            
            labelUserName.centerXAnchor.constraint(equalTo: profilePic.centerXAnchor),
            labelUserName.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 16),
            
            buttonEditProfile.centerXAnchor.constraint(equalTo: labelUserName.centerXAnchor),
            buttonEditProfile.topAnchor.constraint(equalTo: labelUserName.bottomAnchor, constant: 16),
            

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
