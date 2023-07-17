//
//  TweetComposeViewViewModel.swift
//  colonCancer
//
//  Created by KH on 20/04/2023.
//

import UIKit
import Combine

class TweetComposeViewController: UIViewController {
    
    private var viewModel = TweetComposeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    
    private let tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        button.layer.borderWidth = 0.5
        button.layer.masksToBounds = true
        button.setTitle("Publish", for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.isEnabled = false
        //the differance between this and button.tintColor = .white is that tint color is dimmed automatically when it's disabled
        button.setTitleColor(.white.withAlphaComponent(0.4), for: .disabled) //this makes the button dim when it's disabaled
        button.addTarget(self, action: #selector(didTapToTweet), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapToTweet(){
        viewModel.dispatchTweet()
    }
    
    private let tweetContentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 21
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "what's happening"
        textView.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        textView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).withAlphaComponent(0.1)
        textView.font = UIFont(name: "Poppins-Regular", size: 16)
        textView.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        textView.layer.borderWidth = 0.5
        return textView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colors.setBackGround(view)
        title = "Tweet"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        tweetContentTextView.delegate = self
        view.addSubview(tweetButton)
        view.addSubview(tweetContentTextView)
        bindViews()
        configureConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
              view.addGestureRecognizer(tapGesture)
              
        
    }
    @objc func handleTap() {
        view.endEditing(true) // Dismiss the keyboard by resigning the first responder status
    }


    
    private func bindViews(){
        
        viewModel.$isValidToTweet.sink{ [weak self] state in
            self?.tweetButton.isEnabled = state
        }.store(in: &subscriptions)
        
        viewModel.$shouldDismissComposer.sink { [weak self] success in
            if success {
                self?.dismiss(animated: true)
            }
        }.store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true)
    }
    private func configureConstraints() {
        let tweetButtonConsytaints = [
            tweetButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetButton.widthAnchor.constraint(equalToConstant: 120),
            tweetButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        let tweetContentTextViewConstraints = [
            tweetContentTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetContentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tweetContentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tweetContentTextView.bottomAnchor.constraint(equalTo: tweetButton.topAnchor, constant: -10)
            
        ]
        NSLayoutConstraint.activate(tweetButtonConsytaints)
        NSLayoutConstraint.activate(tweetContentTextViewConstraints)

    }
    
    
}

extension TweetComposeViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1) { // to remove the costimized place holder
            textView.textColor = .white
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty { // to return the costimized place holder
            textView.text = "what's happening"
            textView.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.tweetContent = textView.text
        viewModel.validateToTweet()
    }
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
}

