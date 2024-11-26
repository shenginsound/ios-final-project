//
//  EditProfileView.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/23.
//

import UIKit

class EditProfileView: UIView {
    
    //show original profile
    var editProfilePic: UIImageView!
    
    //change photo
    var buttonTakeEditPhoto: UIButton!
    
    //show original username
    var labelUserName: UILabel!
    var textFieldEditUserName: UITextField!
    
    //save edit profile
    var buttonSaveProfile: UIButton!
    
    //cancel button -> go back to profile view
    var buttonCancel: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupEditProfilePic()
        setupButtonTakeEditPhoto()
        setupLabelUserNanme()
        setupTextFieldEditUserName()
        
        setupButtonSaveProfile()
        setupButtonCancel()


        initConstraints()
    }
    func setupEditProfilePic(){
        editProfilePic = UIImageView()
        editProfilePic.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        editProfilePic.contentMode = .scaleToFill
        editProfilePic.clipsToBounds = true
        editProfilePic.layer.masksToBounds = true
        editProfilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editProfilePic)
        
    }
    func setupButtonTakeEditPhoto(){
        buttonTakeEditPhoto = UIButton(type: .system)
        buttonTakeEditPhoto.setTitle("Tap me", for: .normal)
        buttonTakeEditPhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonTakeEditPhoto.contentHorizontalAlignment = .fill
        buttonTakeEditPhoto.contentVerticalAlignment = .fill
        buttonTakeEditPhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakeEditPhoto.showsMenuAsPrimaryAction = true
        buttonTakeEditPhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakeEditPhoto)
    }
    func setupLabelUserNanme(){
        labelUserName = UILabel()
        labelUserName.text = "UserName: "
        labelUserName.font = UIFont.boldSystemFont(ofSize: 14)
        labelUserName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelUserName)
        
    }
    func setupTextFieldEditUserName(){
        textFieldEditUserName = UITextField()
//        textFieldEditUserName.placeholder = "Name"
        textFieldEditUserName.keyboardType = .default
        textFieldEditUserName.borderStyle = .roundedRect
        textFieldEditUserName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEditUserName)
        
    }
    func setupButtonSaveProfile(){
        buttonSaveProfile = UIButton(type: .system)
        buttonSaveProfile.setTitle("Save", for: .normal)
        buttonSaveProfile.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSaveProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSaveProfile)
        
    }
    func setupButtonCancel(){
        buttonCancel = UIButton(type: .system)
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonCancel)
        
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
//
            editProfilePic.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            editProfilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            editProfilePic.widthAnchor.constraint(equalToConstant: 200),
            editProfilePic.heightAnchor.constraint(equalToConstant: 200),
            
            buttonTakeEditPhoto.topAnchor.constraint(equalTo: editProfilePic.bottomAnchor, constant: 16),
            buttonTakeEditPhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                //MARK: setting buttonTakePhoto's height and width..
            buttonTakeEditPhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakeEditPhoto.heightAnchor.constraint(equalToConstant: 100),
            
            labelUserName.topAnchor.constraint(equalTo: buttonTakeEditPhoto.bottomAnchor),
            labelUserName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldEditUserName.topAnchor.constraint(equalTo: labelUserName.bottomAnchor, constant: 16),
            textFieldEditUserName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEditUserName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            
            buttonCancel.topAnchor.constraint(equalTo: textFieldEditUserName.bottomAnchor),
            buttonCancel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 70),
            buttonCancel.widthAnchor.constraint(equalToConstant: 100),
            buttonCancel.heightAnchor.constraint(equalToConstant: 50),
            
            
            buttonSaveProfile.topAnchor.constraint(equalTo: textFieldEditUserName.bottomAnchor),
            buttonSaveProfile.leadingAnchor.constraint(equalTo: buttonCancel.trailingAnchor, constant: 20),
            buttonSaveProfile.centerYAnchor.constraint(equalTo: buttonCancel.centerYAnchor),
            buttonSaveProfile.widthAnchor.constraint(equalToConstant: 100),
            buttonSaveProfile.heightAnchor.constraint(equalToConstant: 50),
            
            

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
