//
//  ProfileTableViewCell.swift
//  colonCancer
//
//  Created by KH on 20/04/2023.
//


import UIKit
import PhotosUI


protocol ProfileTableViewHeaderDelegate: AnyObject {
    func didTapEditInfo()
    func didTapEditProfile()

}

class ProfileTableViewHeader: UIView {
    
    private enum SectionTabs: String {
        case Tweets
        case tweetsAndReplies = "Tweets & Replies"
        case Media
        case Likes
        var index: Int {
            switch self {
            case .Tweets:
                return 0
            case .tweetsAndReplies:
                return 1
            case .Media:
                return 2
            case .Likes:
                return 3
            }
        }
    }
    var delegate: ProfileTableViewHeaderDelegate?
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        return view
    }()
    
    private var selectedTab: Int = 0 {
        didSet{
            for i in 0..<tabs.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [weak self] in
                  //sets the the tabs colors [tweets .. tweets&likes .. etc]
                    self?.sectionStack.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                 //sets the line indicator under the selected tap
                    self?.leadingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.trailingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.layoutIfNeeded() //updates the ui animation
                    
                } completion: { _ in
                }
            }
        }
    }
    
//    private var tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"]
    private var tabs: [UIButton] = ["Your Stories"]
        .map { buttonTitle in
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.tintColor = .label
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    private lazy var sectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
 
    var joinedDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let joinDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var userBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .label
        return label
    }()
    
    var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    var displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label //adjusts to dark mode or any other mode
        return label
    }()
    
    private let profileHeaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(named: "header")
//        imageView.image = UIImage(systemName: "tray.and.arrow.up")
//        imageView.tintColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        imageView.backgroundColor = .secondaryLabel
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true

        return imageView
    }()
  var profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
//        imageView.image = UIImage(systemName: "person")
//        imageView.backgroundColor = .purple
        imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let editProfileBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15.2)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(.label, for: .normal)
        btn.layer.borderWidth = 0.3
        btn.setTitle("Edit Profile", for: .normal)
        btn.addTarget(self, action: #selector(didTapToEditProfile), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    
    @objc func didTapToEditProfile(){
        delegate?.didTapEditProfile()
        
    }
    
    
    private let editInfoBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15.2)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(.label, for: .normal)
        btn.layer.borderWidth = 0.3
        btn.setTitle("Edit Info", for: .normal)
        btn.addTarget(self, action: #selector(didTapToeditInfo), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    
    @objc func didTapToeditInfo(){
        delegate?.didTapEditInfo()
        
    }
    
    
//    @objc private func didTapToUploadAvatar() {
//        var configuration = PHPickerConfiguration()
//        configuration.filter = .images //accepts only images
//        configuration.selectionLimit = 1 //aceepts one image
//
//        let picker = PHPickerViewController(configuration: configuration)
//        picker.delegate = self
//        present(picker, animated: true)
//    }
//    @objc private func didTapToUploadHeader() {
//        var configuration = PHPickerConfiguration()
//        configuration.filter = .images //accepts only images
//        configuration.selectionLimit = 1 //aceepts one image
//
//        let picker = PHPickerViewController(configuration: configuration)
//        picker.delegate = self
//        present(picker, animated: true)
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(userBioLabel)
        addSubview(joinDataImageView)
        addSubview(joinedDataLabel)
        addSubview(editProfileBtn)
        addSubview(editInfoBtn)
        
        
        addSubview(sectionStack)
        addSubview(indicator)
        
//
//        profileAvatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUploadAvatar)))
//
//        profileHeaderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUploadHeader))) //adding an action for a view like a button
//
        configureConstraints()
        configureStackButton()
    }
    
    private func configureStackButton(){
        for (i, button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else {return}
            if i == selectedTab {
                button.tintColor = .label
            } else {
                button.tintColor = .secondaryLabel
            }
            
            
            button.addTarget(self, action: #selector(didTapTap), for: .touchUpInside)
        }
    }
    
    @objc private func didTapTap(_ sender: UIButton){
        guard let label = sender.titleLabel?.text else {return}
        switch label {
        case SectionTabs.Tweets.rawValue:
            selectedTab = SectionTabs.Tweets.index
        case SectionTabs.tweetsAndReplies.rawValue:
            selectedTab = SectionTabs.tweetsAndReplies.index
        case SectionTabs.Media.rawValue:
            selectedTab = SectionTabs.Media.index
        case SectionTabs.Likes.rawValue:
            selectedTab = SectionTabs.Likes.index
        default:
            selectedTab = 0

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func configureConstraints(){
        
        for i in 0..<tabs.count {
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
         let profileHeaderImageViewConstraints = [
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 150)
         ]
        
        let profileAvatarImageViewConstraints = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 10),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let displayNameLabelConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 20)
        ]
        
        let usernameLabelConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5)
        ]
        
        //we set all the leading anchors to displayNameLabel so when we want to change them all we just chane displayNameLabel leading anchor
        let userBioLabelConstraints = [
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5)
        ]
        
        let joinDataImageViewConstraints = [
            joinDataImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDataImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 5)
        ]
        
        let joinedDataLabelConstraints = [
            joinedDataLabel.leadingAnchor.constraint(equalTo: joinDataImageView.trailingAnchor, constant: 5),
            joinedDataLabel.bottomAnchor.constraint(equalTo: joinDataImageView.bottomAnchor)
        ]
        
        let editProfileBtnConstraints = [
            editProfileBtn.widthAnchor.constraint(equalToConstant: 130),
            editProfileBtn.heightAnchor.constraint(equalToConstant: 40),
            editProfileBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            editProfileBtn.topAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 18)
        ]
        let editInfoBtnConstraints = [
            editInfoBtn.widthAnchor.constraint(equalToConstant: 130),
            editInfoBtn.heightAnchor.constraint(equalToConstant: 40),
            editInfoBtn.trailingAnchor.constraint(equalTo: editProfileBtn.leadingAnchor, constant: -7),
            editInfoBtn.topAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 18)
        ]
        
       
        let sectionStackConstraint = [
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sectionStack.topAnchor.constraint(equalTo: joinedDataLabel.bottomAnchor,constant: 5),
            sectionStack.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let indicatorConstraints = [
            leadingAnchors[0],
            trailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStack.arrangedSubviews[0].bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ]
        
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
        NSLayoutConstraint.activate(userBioLabelConstraints)
        NSLayoutConstraint.activate(joinDataImageViewConstraints)
        NSLayoutConstraint.activate(joinedDataLabelConstraints)
        NSLayoutConstraint.activate(editProfileBtnConstraints)
        NSLayoutConstraint.activate(editInfoBtnConstraints)
        NSLayoutConstraint.activate(sectionStackConstraint)
        NSLayoutConstraint.activate(indicatorConstraints)




    }
    

}
//
//extension ProfileTableViewHeader: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//
//        picker.dismiss(animated: true)
//        for result in results {
//            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
//                if let image = object as? UIImage {
//                    DispatchQueue.main.async {
//                        self?.profileHeaderImageView.image = image
//                        ProfileDataFormViewViewModel.viewModel.HeaderData = image
//                    }
//                }
//            }
//        }
//    }
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//
//        picker.dismiss(animated: true)
//        for result in results {
//            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
//                if let image = object as? UIImage {
//                    DispatchQueue.main.async {
//                        self?.profileAvatarImageView.image = image
//                        ProfileDataFormViewViewModel.viewModel.imageData = image
//                    }
//                }
//            }
//        }
//    }
//}
