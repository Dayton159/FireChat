//
//  ChatViewController.swift
//  FireChat
//
//  Created by Dayton on 30/12/20.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class ChatViewController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let user:User
    private var messages = [Message]()
    var fromCurrentUser = false
    
    
    private lazy var customInputView:CustomInputAccesoryView = {
        let inputView = CustomInputAccesoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        inputView.delegate = self
        
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
        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
    }
}

extension ChatViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        
        return cell
    }
}

extension ChatViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

extension ChatViewController:CustomInputAccessoryViewDelegate {
    func inputView(_ inputView: CustomInputAccesoryView, wantsToSend message: String) {
        
        Service.uploadMessage(message, to: user) { error in
            if let error = error {
                print("DEBUG: Failed to upload messages with error \(error.localizedDescription)")
                return
            }
            
            inputView.messageInputTextView.text = nil
        }
    }
}
