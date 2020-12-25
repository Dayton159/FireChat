//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Dayton on 25/12/20.
//

import UIKit

struct LoginViewModel {
    var email:String?
    var password:String?
    
    var formIsValid:Bool {
        // Only returns true if both email and password are empty
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
}
