//
//  ProfileFooter.swift
//  FireChat
//
//  Created by Dayton on 05/01/21.
//

import UIKit

protocol ProfileFooterDelegate:AnyObject {
    func handleLogout()
}

class ProfileFooter: UIView {
    
    weak var delegate:ProfileFooterDelegate?
    
    //MARK: - Properties
    
    private lazy var logoutButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.roundCorners(corners: .allCorners, radius: 5)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
        logoutButton.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 32, paddingRight: 32)
        logoutButton.setHeight(height: 50)
        logoutButton.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleLogout() {
        delegate?.handleLogout()
    }
}
