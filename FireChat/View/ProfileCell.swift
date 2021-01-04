//
//  ProfileCell.swift
//  FireChat
//
//  Created by Dayton on 04/01/21.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    var viewModel:ProfileViewModel? {
        didSet{
            configure()
        }
    }
    
    //MARK: - Properties
    
    private lazy var iconView:UIView = {
        let view = UIView()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.centerY(inView: view)
        
        view.backgroundColor = .systemPurple
        view.setDimensions(height: 40, width: 40)
        view.roundCorners(corners: .allCorners, radius: 40 / 2)
        
        return view
    }()
    
    private let iconImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setDimensions(height: 28, width: 28)
        imageView.tintColor = .white
        
        return imageView
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.spacing = 8
        stack.axis = .horizontal
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configure() {
        guard let viewModel = viewModel else {return}
        
        iconImage.image = UIImage(systemName: viewModel.iconImages)
        titleLabel.text = viewModel.description
    }
}
