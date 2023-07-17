//
//  ReminderCollectionViewCell.swift
//  colonCancer
//
//  Created by KH on 22/05/2023.
//

import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "ReminderCollectionViewCell"
    
    private let dayLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Medium", size: 13)
        label.frame = CGRect(x: 0, y: 0, width: 37, height: 20)
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Poppins-Medium", size: 13)
        label.frame = CGRect(x: 0, y: 0, width: 37, height: 20)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(dateLabel)
        
        dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    public func configure(day: String, date: String) {
        dateLabel.text = date
        dayLabel.text = day
    }
    
}
