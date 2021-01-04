//
//  ProfileHeader.swift
//  FireChat
//
//  Created by Dayton on 04/01/21.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate:class {
    func dismissController()
}

class ProfileHeader: UIView {
    
    weak var delegate:ProfileHeaderDelegate?
    
    var user:User? {
        didSet {
            populateUserData()
        }
    }
    
    //MARK: - Properties
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        
        return button
    }()
    
    private let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4.0
        
        return imageView
    }()
    
    private let fullnameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Eddie Brock"
        
        return label
    }()
    
    private let usernameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "@venom"
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // Somehow The addSublayer call needs to be made from the main-thread
        DispatchQueue.main.async {
            self.configureGradientLayer()
            self.configureUI()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleDismissal() {
        delegate?.dismissController()
    }
    
    //MARK: - Helpers
    
    func configureUI() {

        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: topAnchor, paddingTop: 96)
        profileImageView.setDimensions(height: 200, width: 200)
        profileImageView.roundCorners(corners: .allCorners, radius: 200 / 2)
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: profileImageView.bottomAnchor, paddingTop: 16)
        
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12)
        dismissButton.setDimensions(height: 48, width: 48)
    }
    
    func configureGradientLayer() {
            let gradient = CAGradientLayer()
           gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
           gradient.locations = [0, 1]
            self.layer.addSublayer(gradient)
            gradient.frame = self.bounds
    }
    
    func populateUserData() {
        guard let user = user else {return}
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = "@" + user.username
        
        guard let url = URL(string: user.profileImageUrl) else {return}
        
        profileImageView.sd_setImage(with: url)
    }
}
