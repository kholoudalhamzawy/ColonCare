//
//  ProfileViewController.swift
//  colonCancer
//
//  Created by KH on 20/04/2023.
//


import UIKit
import Combine
import SDWebImage

class ProfileViewController: UIViewController, ProfileTableViewHeaderDelegate {
    
    func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapEditInfo() {
        let vc = EditInfoViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private var viewModel = profileViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private var isStatueBarHidden: Bool = true
    
    private let statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        return view
    }()
    
   private lazy var headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 380)) //lazy bacuse we're using profileTableView in the initilization so we assure it will be created when the app loads

    private let BackGroundView = backGroundView()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
//        navigationItem.title = "Profile"
        view.addSubview(profileTableView)
        view.addSubview(statusBar)
        headerView.delegate = self
        profileTableView.delegate = self
        profileTableView.dataSource = self
//        navigationController?.navigationBar.isHidden = true
        profileTableView.tableHeaderView = headerView
        //allows the view to fully appear when you're scrolling not put that foggy header
        profileTableView.contentInsetAdjustmentBehavior = .never
        profileTableView.backgroundView = BackGroundView
        configureConstraints()
        bindViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {//viewWillAppear is better than view did appear to show the view more instantly
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
        viewModel.retrieveUser()
    }
    
    private func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else {return}
            self?.headerView.displayNameLabel.text = user.displayName
            self?.headerView.usernameLabel.text = "@\(user.username)"
            
            self?.headerView.userBioLabel.text = user.bio
            self?.headerView.profileAvatarImageView.sd_setImage(with: URL(string: user.avatarPath))
            self?.headerView.joinedDataLabel.text =  "joined \(self?.viewModel.getFormattedData(with: user.createdOn) ?? "")"
        }
        .store(in: &subscriptions)
        
        viewModel.$tweets.sink{ [weak self] _ in
            DispatchQueue.main.async {
                self?.profileTableView.reloadData()
            }
        }.store(in: &subscriptions)
    }
    
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func configureConstraints(){
        let profileTableViewConstraints = [
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let statusBarConstraints = [
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: view.bounds.height > 800 ? 40 : 20)
            //the iphone 8 and below dont have a notch so the height is set to 20, iphone 10 and above is set to 40
        ]
        
        NSLayoutConstraint.activate(profileTableViewConstraints)
        NSLayoutConstraint.activate(statusBarConstraints)
    }


}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        let tweetModel = viewModel.tweets[indexPath.row]
        cell.configureTweet(with: tweetModel.author.displayName,
                            username: tweetModel.author.username,
                            tweetTextContent: tweetModel.tweetContent,
                            avatarPath: tweetModel.author.avatarPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //gets the exact y Postion of the scrollView
        let yPosition = scrollView.contentOffset.y
//        print (yPosition)
        
        if yPosition > 150 && isStatueBarHidden {
            isStatueBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in //what hapens in the animation
                self?.statusBar.layer.opacity = 1
            } completion: { _ in }
        } else if yPosition < 0 && !isStatueBarHidden {
            isStatueBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in //what hapens in the animation
                self?.statusBar.layer.opacity = 0
            } completion: { _ in }
        }
        
    }
    
}

