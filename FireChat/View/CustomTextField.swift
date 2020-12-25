//
//  CustomTextField.swift
//  FireChat
//
//  Created by Dayton on 25/12/20.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeHolder:String) {
        super.init(frame: .zero)
        
        borderStyle = .none
        font = .systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor : UIColor.white])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
