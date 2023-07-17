//
//  DropDownView.swift
//  colonCancer
//
//  Created by KH on 25/05/2023.
//

import UIKit

protocol DropDownButtonDelegate: AnyObject {
    func didSelectDays(_ index: Int)
    func didSelectType(_ index: Int)

}

class DropDownButton: UIView {

//    var days:[String] = []
    lazy var type: MedType = .pill
    var checkmarkStates = [false,false,false,false,false,false,false]

    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.contentHorizontalAlignment = .trailing
        return button
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        table.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        table.layer.borderWidth = 1.2
        table.layer.borderColor = UIColor.gray.cgColor
        table.layer.cornerRadius = 10
        table.register(DropdownTableViewCell.self, forCellReuseIdentifier: DropdownTableViewCell.reuseIdentifier)
        return table
    }()

    var dataSource: [String] = [] {
        didSet {
            updateTableDataSource()
        }
    }
//
//    var title: String = "" {
//        didSet {
//            button.setTitle(title, for: .normal)
//        }
//    }

    var delegate: DropDownButtonDelegate?

    var tableViewHeight: NSLayoutConstraint?

    var buttonHeightConstraint: NSLayoutConstraint?
    var buttonHeight: CGFloat = 38 {
        didSet {
            buttonHeightConstraint?.constant = buttonHeight
            updateTableDataSource()
        }
    }

    func didMakeTableViewHiden(){
        tableView.isHidden = true
    }
   
    
    var maxVisibleCellsAmount: Int = 4 {
        didSet {
            updateTableDataSource()
        }
    }

    var buttonBottomConstraint: NSLayoutYAxisAnchor {
        button.bottomAnchor
    }
    var medType: Bool = false

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
       

    }

    func setup() {
        addSubview(stackView)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo:topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: buttonHeight)
        buttonHeightConstraint?.isActive = true
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeight?.isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
    }
    

       func didTapTohide(){
            tableView.isHidden = true
        }


    func updateTableDataSource() {
        if dataSource.count >= maxVisibleCellsAmount {
            tableViewHeight?.constant = CGFloat(maxVisibleCellsAmount) * buttonHeight
        } else {
            tableViewHeight?.constant = CGFloat(dataSource.count) * buttonHeight
        }
        tableView.reloadData()
    }

    @objc private func buttonTapped() {
        tableView.isHidden.toggle()
    }
    private var tapGestureRecognizer: UITapGestureRecognizer!


}

extension DropDownButton: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropdownTableViewCell.reuseIdentifier, for: indexPath) as? DropdownTableViewCell else { return UITableViewCell() }
        let isChecked = checkmarkStates[indexPath.row]
        cell.accessoryType = isChecked ? .checkmark : .none
        cell.set(dataSource[indexPath.row])
        
        return cell
      

    }

}

extension DropDownButton: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        button.setTitle(dataSource[indexPath.row], for: .normal)

        tableView.deselectRow(at: indexPath, animated: true)
        if let myCell = tableView.cellForRow(at: indexPath) as? DropdownTableViewCell {
            if let displayLbl = myCell.label.text {
                if medType {
                    
                    delegate?.didSelectType(indexPath.row)
                    
                    for cell in tableView.visibleCells {
                       cell.accessoryType = .none
                    }
                   myCell.accessoryType = .checkmark
                    if let typeFtomRawValue =  MedType(rawValue: displayLbl){
                        type = typeFtomRawValue
                    } else {
                        print("No matching enum value for raw value: \(displayLbl)")
                        type = .pill
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        tableView.isHidden = true
                    }
                } else {
                    
                    delegate?.didSelectDays(indexPath.row)
                    
                    
//                    if myCell.accessoryType == .none {
//                        days.append(displayLbl)
//                    } else {
//                        if let index = days.firstIndex(of: displayLbl) {
//                            days.remove(at: index)
//                        }
//                    }
                    myCell.accessoryType = myCell.accessoryType == .checkmark ? .none : .checkmark
                    checkmarkStates[indexPath.row] = !checkmarkStates[indexPath.row]

                }
            }
            
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return buttonHeight
    }
}
