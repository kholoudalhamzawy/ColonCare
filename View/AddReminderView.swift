//
//  ReminderTableHeaderView.swift
//  colonCancer
//
//  Created by KH on 21/05/2023.
//

import UIKit


protocol AddReminderViewDelegate: AnyObject {
    func didTapAdd()
}


class AddReminderView: UIView {
    
    weak var delegate: AddReminderViewDelegate?
    
    private let NewPerscriptionLabel: UILabel = {
        var View = UILabel()
        View.frame = CGRect(x: 0, y: 0, width: 208, height: 30)
        View.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        View.font = UIFont(name: "Poppins-Medium", size: 18)
        View.text = "New Prescription "
        View.textAlignment = .center
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    
    private let AddImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Add")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let FirstaidImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Firstaid")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAdd)))
        addSubview(NewPerscriptionLabel)
        addSubview(AddImageView)
        addSubview(FirstaidImageView)
        applyConstraints()
    }
    @objc func didTapAdd(){
        delegate?.didTapAdd()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.frame = bounds
        self.backgroundColor = UIColor(red: 0.673, green: 0.391, blue: 0.954, alpha: 0.7)
        self.layer.cornerRadius = 15

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    private func applyConstraints(){
        
        let AddImageViewConstraints = [
            AddImageView.widthAnchor.constraint(equalToConstant: 55),
            AddImageView.heightAnchor.constraint(equalToConstant: 30),
            AddImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            AddImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ]
        let FirstaidImageViewConstraints = [
            FirstaidImageView.widthAnchor.constraint(equalToConstant: 43),
            FirstaidImageView.heightAnchor.constraint(equalToConstant: 43),
            FirstaidImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            FirstaidImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
        ]
        let NewPerscriptionLabelConstraints = [
            NewPerscriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            NewPerscriptionLabel.leadingAnchor.constraint(equalTo: FirstaidImageView.trailingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(AddImageViewConstraints)
        NSLayoutConstraint.activate(FirstaidImageViewConstraints)
        NSLayoutConstraint.activate(NewPerscriptionLabelConstraints)
        
    }
    
    
}
