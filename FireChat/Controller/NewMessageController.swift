//
//  NewMessageController.swift
//  FireChat
//
//  Created by Dayton on 28/12/20.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: class {
    func controller(_ controller:NewMessageController, wantsToChatWith user: User)
}

class NewMessageController:UITableViewController {
    
    //MARK: - Properties
    
    private var users = [User]()
    
    private var filteredUser = [User]()
    
    weak var delegate: NewMessageControllerDelegate?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode:Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
        configureSearchController()
    }
    
    //MARK: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - API
    
    func fetchUsers() {
        showLoader(true)
        
        Service.fetchUser { (users) in
            self.showLoader(false)
            
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        definesPresentationContext = false
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .systemPurple
            textfield.backgroundColor = .white
        }
    }
}

    //MARK: - UITableViewDataSource

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUser.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.users = inSearchMode ? filteredUser[indexPath.row] : users[indexPath.row]
        
        return cell
    }
    
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUser[indexPath.row] : users[indexPath.row]
        
        delegate?.controller(self, wantsToChatWith: user)
    }
}


extension NewMessageController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        
        filteredUser = users.filter({ user -> Bool in
            return user.username.contains(searchText) || user.fullname.contains(searchText)
           
        })
        self.tableView.reloadData()
    }
}
