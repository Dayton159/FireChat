//
//  ChatViewController.swift
//  FireChat
//
//  Created by Dayton on 30/12/20.
//

import UIKit

class ChatViewController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let user:User
    
    
    private lazy var customInputView:CustomInputAccesoryView = {
        let inputView = CustomInputAccesoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        return inputView
    }()
    
    //MARK: - Lifecycle
    
    init(user:User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return customInputView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
    }
}
