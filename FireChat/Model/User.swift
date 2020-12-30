//
//  User.swift
//  FireChat
//
//  Created by Dayton on 30/12/20.
//

import UIKit

struct User {
    let uid:String
    let profileImageUrl:String
    let username:String
    let fullname:String
    let email:String
    
    
    init(dictionary: [String:Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageURL"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
