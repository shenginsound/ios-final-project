//
//  BillItem.swift
//  iosfinal
//
//  Created by 鄭家昇 on 2024/12/8.
//

import Foundation
import FirebaseFirestoreSwift

struct BillItem : Codable{
    var id: String
    var amount: Double
    var name: String
    var postedBy: String
    var groupMembers: [String]
    var noofMembers: Int
    var imageUrl: String
}
