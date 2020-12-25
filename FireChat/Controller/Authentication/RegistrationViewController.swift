//
//  RegistrationViewController.swift
//  FireChat
//
//  Created by Dayton on 24/12/20.
//

import UIKit

class RegistrationViewController:UIViewController {
    
    //MARK: -  Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let plusPhotoButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusphoto"), for:  .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var emailContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "mail"),
                                               textField: emailTextField)
    }()
    
    private lazy var fullnameContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "person"),
                                               textField: fullnameTextField)
    }()
    
    private lazy var usernameContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "person"),
                                               textField: usernameTextField)
    }()
    
    private lazy var passwordContainerView:InputContainerView = {
        return InputContainerView(image: UIImage(named: "passLock"),
                                               textField: passwordTextField)
    }()
    
    private let emailTextField:CustomTextField = CustomTextField(placeHolder: "Email")
    private let fullnameTextField:CustomTextField = CustomTextField(placeHolder: "Full Name")
    private let usernameTextField:CustomTextField = CustomTextField(placeHolder: "Username")
    
    private let passwordTextField:CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private let signUpButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.roundCorners(corners: .allCorners, radius: 5)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.isEnabled = false
        
        return button
    }()
    
    private let alreadyHaveAccButton:UIButton = {
        let button = UIButton(type: .system)
        
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?   ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Log in", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    //MARK: - Selectors
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender:UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender ==  fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        
        checkFormStatus()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,fullnameContainerView, usernameContainerView, passwordContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccButton)
        alreadyHaveAccButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

//MARK: -  UIImagePickerControllerDelegate

extension RegistrationViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        
        plusPhotoButton.roundCorners(corners: .allCorners, radius: 200 / 2)
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationViewController:AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
