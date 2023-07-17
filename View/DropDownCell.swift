//
//  DropDownCell.swift
//  colonCancer
//
//  Created by KH on 25/05/2023.
//

import UIKit



class DropdownTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DropdownTableViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        label.textColor = .label
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        backgroundColor = .clear
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func set(_ text: String) {
        label.text = text
    }
 
}
