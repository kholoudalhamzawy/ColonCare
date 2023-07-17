//
//  ReminderTableViewCell.swift
//  colonCancer
//
//  Created by KH on 21/05/2023.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    static let identifier = "ReminderTableViewCell"
    
    private let myUIView = reminderTableCellView()
    
    
    func configureMed(name: String, dose: String, amount: String, type: MedType, time: String = "", id: String){
        myUIView.configureMed(name: name, dose: dose, amount: amount, type: type, id: id, time: time)
    }
    
    func toggleCheck(){
        myUIView.togglecheck()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layoutMargins = .zero
        myUIView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(myUIView)
        myUIView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        myUIView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        myUIView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive = true
        myUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18).isActive = true
        myUIView.widthAnchor.constraint(equalToConstant: 355).isActive = true
        myUIView.heightAnchor.constraint(equalToConstant: 71).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
