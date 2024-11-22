//
//  MainScreenView.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/21.
//

import UIKit

class MainScreenView: UIView {
    
    var labelText: UILabel!
    var floatingButtonLogIn: UIButton!
    var floatingButtonSignUp: UIButton!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            
            //setupProfilePic()
            setupLabelText()
            setupFloatingButtonLogIn()
            //setupTableViewContacts()
            setupFloatingButtonSignUp()
            initConstraints()
        }
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 20)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
        
        
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
    func initConstraints(){
            NSLayoutConstraint.activate([
//                profilePic.widthAnchor.constraint(equalToConstant: 32),
//                profilePic.heightAnchor.constraint(equalToConstant: 32),
//                profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
//                profilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//
                labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
                labelText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                
                floatingButtonLogIn.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
                floatingButtonLogIn.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: 8),
                
                floatingButtonSignUp.centerXAnchor.constraint(equalTo: floatingButtonLogIn.centerXAnchor),
                floatingButtonSignUp.topAnchor.constraint(equalTo: floatingButtonLogIn.bottomAnchor, constant: 8),
                


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
