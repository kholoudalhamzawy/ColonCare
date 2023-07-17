//
//  TweetTableViewCell.swift
//  colonCancer
//
//  Created by KH on 20/04/2023.
//

import UIKit

protocol tweetTableViewCellDelegate: AnyObject {
    func tweetTableViewCellDidTapReply()
    func tweetTableViewCellDidTapRetweet()
    func tweetTableViewCellDidTapLike()
    func tweetTableViewCellDidTapShare()
}

class TweetTableViewCell: UITableViewCell {
    
    static let identifier = "TweetTableViewCell"
    private let actionSpacing : CGFloat = 60
    
    weak var delegate: tweetTableViewCellDelegate?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25 //circular because wisth and height are 50
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
//        imageView.image = UIImage(systemName: "person")
//        imageView.backgroundColor = .purple
            return imageView
        
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tweetTextContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "this is my MokeUp tweet. it's gonna be multiple lines. i believe some more Text is enough but lets add some more anyway.. halliloighah !!!"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    
    }()
  
//   }()
   
  
    @objc private func didTapLike(){
        delegate?.tweetTableViewCellDidTapLike()
    }
   
    private func configureButtons(){
      
      //  likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        
    }
    
    func configureTweet(with displayName: String, username: String, tweetTextContent: String, avatarPath: String){
        displayNameLabel.text = displayName
        usernameLabel.text = "@\(username)"
        tweetTextContentLabel.text = tweetTextContent
        avatarImageView.sd_setImage(with: URL(string: avatarPath))
    }
    
    
    private func configureConstraints() {
        let avatarImageViewConstraints = [
        avatarImageView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor,constant:20),
        avatarImageView.topAnchor.constraint (equalTo: contentView.topAnchor, constant: 14),
        avatarImageView.heightAnchor.constraint (equalToConstant: 50),
        avatarImageView.widthAnchor.constraint (equalToConstant: 50)
        ]
        let displayNameLabelConstraints = [
        displayNameLabel.leadingAnchor.constraint (equalTo: avatarImageView.trailingAnchor, constant: 20),
        displayNameLabel.topAnchor.constraint (equalTo: contentView.topAnchor, constant: 20)
        ]
        let usernameLabelConstraints = [
        usernameLabel.leadingAnchor.constraint (equalTo: displayNameLabel.trailingAnchor, constant: 10),
        usernameLabel.centerYAnchor.constraint (equalTo: displayNameLabel.centerYAnchor)
        ]
        let tweetTextContentLabelConstraints = [
            tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            tweetTextContentLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10),
            tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            tweetTextContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
    
//        let likeButtonConstraints = [
//            likeButton.leadingAnchor.constraint(equalTo: tweetTextContentLabel.leadingAnchor),
//            likeButton.topAnchor.constraint(equalTo: tweetTextContentLabel.bottomAnchor, constant: 20),
//            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ]
        
            
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
        NSLayoutConstraint.activate(tweetTextContentLabelConstraints)
//        NSLayoutConstraint.activate(likeButtonConstraints)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetTextContentLabel)
//        contentView.addSubview(likeButton)
//        configureButtons()
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()


        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
