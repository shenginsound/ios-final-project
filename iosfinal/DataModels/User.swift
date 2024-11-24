//
//  User.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/11/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable{
    @DocumentID var id: String?
    var name: String
    var email: String
    var photoURL: URL?
    
    init(name: String, email: String, photoURL: URL) {
        self.name = name
        self.email = email
        self.photoURL = photoURL
    }
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

