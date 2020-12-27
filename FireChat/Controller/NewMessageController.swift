//
//  NewMessageController.swift
//  FireChat
//
//  Created by Dayton on 28/12/20.
//

import UIKit

class NewMessageController:UITableViewController {
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemPink
    }
}
