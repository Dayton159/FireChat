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
        print("DEBUG: User in chat with \(user.username)")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
    }
}
