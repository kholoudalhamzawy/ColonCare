//
//  reminderTableCellView.swift
//  colonCancer
//
//  Created by KH on 22/05/2023.
//

import UIKit

class reminderTableCellView: UIView {
    
    var cellId: String = ""
    
    
    private let medNameLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 248, height: 27)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 18)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let medTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Add")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let medDoseLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 238, height: 17)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        view.font = UIFont(name: "Poppins-Light", size: 11)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let timeLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 248, height: 27)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 18)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkBox : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square"), for: .normal)
        btn.addTarget(self, action: #selector(togglecheck), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
                     
    @objc func togglecheck() {
        ReminderViewViewModel.model.toggleCheck(PrescreptionId: cellId)
        var isCellChecked = ReminderViewViewModel.model.isCellToggled(PrescreptionId: cellId)
        let image = isCellChecked ? UIImage(named:"ic-checkbox") : UIImage(systemName: "square")
        checkBox.setImage(image, for: .normal)

 }
    
    func configureMed(name: String, dose: String, amount: String, type: MedType, id: String ,time: String = ""){
        switch type {
        case .pill:
            medTypeImageView.image = UIImage(named: "ic-pill")
            medDoseLabel.text = "\(amount) pill - \(dose) mg"
        case .tablet:
            medTypeImageView.image = UIImage(named: "ic-tablets")
            medDoseLabel.text = "\(amount) tablet - \(dose) mg"

        case .injection:
            medTypeImageView.image = UIImage(named: "ic-injection")
            medDoseLabel.text = "\(amount) cm - \(dose) mg"
        }
        medNameLabel.text = name
        timeLabel.text = time
        if !time.isEmpty {
            timeLabel.text = time
        }
        cellId = id
        var isCellChecked = ReminderViewViewModel.model.isCellToggled(PrescreptionId: cellId)
        let image = isCellChecked ? UIImage(named:"ic-checkbox") : UIImage(systemName: "square")
        checkBox.setImage(image, for: .normal)
    }
    
    
    private func configureConstraints() {
        
        let medTypeImageViewConstraints = [
            medTypeImageView.widthAnchor.constraint(equalToConstant: 32),
            medTypeImageView.heightAnchor.constraint(equalToConstant: 32),
            medTypeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            medTypeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]
        let medNameLabelConstraints = [
            medNameLabel.leadingAnchor.constraint(equalTo: medTypeImageView.trailingAnchor, constant: 20),
            medNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.5)
        ]
        let medDoseLabelConstraints = [
            medDoseLabel.leadingAnchor.constraint(equalTo: medTypeImageView.trailingAnchor, constant: 20),
            medDoseLabel.topAnchor.constraint(equalTo: medNameLabel.bottomAnchor, constant: 6)
        ]
        let timeLabelConstraints = [
            timeLabel.trailingAnchor.constraint(equalTo: checkBox.leadingAnchor, constant: -20),
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        let checkBoxConstraints = [
            checkBox.widthAnchor.constraint(equalToConstant: 20),
            checkBox.heightAnchor.constraint(equalToConstant: 20),
            checkBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18)
        ]
        NSLayoutConstraint.activate(medTypeImageViewConstraints)
        NSLayoutConstraint.activate(medNameLabelConstraints)
        NSLayoutConstraint.activate(medDoseLabelConstraints)
        NSLayoutConstraint.activate(checkBoxConstraints)
        NSLayoutConstraint.activate(timeLabelConstraints)


    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(medTypeImageView)
        addSubview(medNameLabel)
        addSubview(medDoseLabel)
        addSubview(checkBox)
        addSubview(timeLabel)
        
        configureConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.frame = bounds //this is wrong, it mess up the view, the cell alredy will have its view
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.09)
        self.layer.cornerRadius = 13
       
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    



}
