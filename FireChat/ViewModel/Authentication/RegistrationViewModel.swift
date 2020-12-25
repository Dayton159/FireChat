//
//  RegistrationViewModel.swift
//  FireChat
//
//  Created by Dayton on 26/12/20.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid:Bool { get }
}

struct RegistrationViewModel:AuthenticationProtocol {
    var email:String?
    var password:String?
    var fullname:String?
    var username:String?
    
    var formIsValid:Bool {
        // Only returns true if both email and password are empty
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
    }
}
