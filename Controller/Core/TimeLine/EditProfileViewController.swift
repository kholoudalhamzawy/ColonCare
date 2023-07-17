//
//  EditProfileViewController.swift
//  colonCancer
//
//  Created by KH on 05/07/2023.
//

import UIKit
import PhotosUI
import Combine

class EditProfileViewController: UIViewController {
    
    private var viewModel = profileViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true //very important when initilizing scrollviews it shows that the content can be scrollable
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
       private let hintLabel: UILabel = {
          
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Update your profile"
           label.font = .systemFont(ofSize: 32, weight: .bold)
           label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
           return label
       }()
       
       
       private let avatarPlaceholderImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.clipsToBounds = true
           imageView.layer.masksToBounds = true
           imageView.layer.cornerRadius = 60
           imageView.backgroundColor = .lightGray
           imageView.image = UIImage(systemName: "camera.fill")
           imageView.tintColor = .gray
           imageView.isUserInteractionEnabled = true
           imageView.contentMode = .scaleAspectFill
           return imageView
       }()
    
     private let displayNameTextField: UITextField = {
         let textField = UITextField()
         textField.tag = 0
         textField.translatesAutoresizingMaskIntoConstraints = false
         textField.keyboardType = .default
         textField.leftViewMode = .always //so this gives the placeholder text a padding
         textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         textField.layer.masksToBounds = true
         textField.layer.cornerRadius = 8
         textField.attributedPlaceholder = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
         textField.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).withAlphaComponent(0.1)
         textField.font = UIFont(name: "Poppins-Regular", size: 16)
         textField.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
         textField.layer.borderWidth = 0.5
         return textField
     }()
     
     
     private let usernameTextField: UITextField = {
         let textField = UITextField()
         textField.tag = 1
         textField.translatesAutoresizingMaskIntoConstraints = false
         textField.keyboardType = .default
         textField.leftViewMode = .always
         textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         textField.layer.masksToBounds = true
         textField.layer.cornerRadius = 8
         textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         textField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
         textField.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).withAlphaComponent(0.1)
         textField.font = UIFont(name: "Poppins-Regular", size: 16)
         textField.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
         textField.layer.borderWidth = 0.5
         return textField
     }()
    
       private let bioTextView: UITextView = {
          
           let textView = UITextView()
           textView.tag = 0
           textView.translatesAutoresizingMaskIntoConstraints = false
           textView.layer.masksToBounds = true
           textView.layer.cornerRadius = 8
           textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
           textView.text = "Tell the world about yourself"
           textView.font = .systemFont(ofSize: 16)
           textView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).withAlphaComponent(0.1)
           textView.font = UIFont(name: "Poppins-Regular", size: 16)
           textView.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
           textView.layer.borderWidth = 0.5
           textView.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
           return textView
       }()
       
       
       private let submitButton: UIButton = {
           let button = UIButton(type: .system)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Update", for: .normal)
           button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
           button.titleLabel?.textAlignment = .center
           button.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
           button.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
           button.layer.borderWidth = 0.5
           button.layer.masksToBounds = true
           button.layer.cornerRadius = 25
           button.isEnabled = false
           button.setTitleColor(.white.withAlphaComponent(0.5), for: .disabled)
           return button
       }()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colors.setBackGround(view)
        view.addSubview(scrollView)
        isModalInPresentation = true //makes the scrollview undissmisable
        
        scrollView.addSubview(hintLabel)
        scrollView.addSubview(avatarPlaceholderImageView)
        scrollView.addSubview(displayNameTextField)
        scrollView.addSubview(usernameTextField)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(submitButton)
        
        displayNameTextField.delegate = self
        usernameTextField.delegate = self
        bioTextView.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))

        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        
        avatarPlaceholderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload))) //adding an action for a view like a button
        
        bindViews()
        configureConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
              view.addGestureRecognizer(tapGesture)
              
        
    }
    

    override func viewWillAppear(_ animated: Bool) {//viewWillAppear is better than view did appear to show the view more instantly
        super.viewWillAppear(animated)
        viewModel.retrieveUser()
    }

  

        
    @objc func handleTap() {
        view.endEditing(true) // Dismiss the keyboard by resigning the first responder status
    }
    
    
    @objc private func didTapSubmit() {
          ProfileDataFormViewViewModel.viewModel.uploadAvatar()
        navigationController?.popViewController(animated: true)
      }
    
    @objc private func didUpdateDisplayName() {
          ProfileDataFormViewViewModel.viewModel.displayName = displayNameTextField.text
          ProfileDataFormViewViewModel.viewModel.validateUserProfileForm() //we check if the form is valid evry time anything in it is changed so we can enable the button
      }
      
      @objc private func didUpdateUsername() {
          ProfileDataFormViewViewModel.viewModel.username = usernameTextField.text
          ProfileDataFormViewViewModel.viewModel.validateUserProfileForm()  //we check if the form is valid evry time anything in it is changed so we can enable the button
      }
      
      private func bindViews() {
          //we add a target to a textfield to make it ike a button
          displayNameTextField.addTarget(self, action: #selector(didUpdateDisplayName), for: .editingChanged)
          usernameTextField.addTarget(self, action: #selector(didUpdateUsername), for: .editingChanged)
          
//          we subscribe to the viewModel published variables,
//          whenever the $isFormValid changes, the closure is excuted,
//          then the subscription is stored so it gets cancelled when the application dies.
          ProfileDataFormViewViewModel.viewModel.$isFormValid.sink { [weak self] buttonState in
              self?.submitButton.isEnabled = buttonState
          }
          .store(in: &subscriptions)
          
          
          viewModel.$user.sink { [weak self] user in
              guard let user = user else {return}
              self?.displayNameTextField.text = user.displayName
              self?.usernameTextField.text = "@\(user.username)"
              
              self?.bioTextView.text = user.bio
              self?.avatarPlaceholderImageView.sd_setImage(with: URL(string: user.avatarPath))
          }
          .store(in: &subscriptions)
          
      }
    
    
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images //accepts only images
        configuration.selectionLimit = 1 //aceepts one image
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func didTapToDismiss() {
        view.endEditing(true)
    }
    
    
    private func configureConstraints() {
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        
        let hintLabelConstraints = [
            hintLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hintLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30)
        ]
        
        
        let avatarPlaceholderImageViewConstraints = [
            avatarPlaceholderImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarPlaceholderImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarPlaceholderImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarPlaceholderImageView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 30)
        ]
        
        let displayNameTextFieldConstraints = [
            displayNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            displayNameTextField.topAnchor.constraint(equalTo: avatarPlaceholderImageView.bottomAnchor, constant: 40),
            displayNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let usernameTextFieldConstraints = [
            usernameTextField.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
            usernameTextField.topAnchor.constraint(equalTo: displayNameTextField.bottomAnchor, constant: 20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let bioTextViewConstraints = [
            bioTextView.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
            bioTextView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            bioTextView.heightAnchor.constraint(equalToConstant: 130)
        ]
        
        let submitButtonConstraints = [
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20) //this always makes the button appear on top of the keyboard so it doesnt hide it
        ]
        
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(hintLabelConstraints)
        NSLayoutConstraint.activate(avatarPlaceholderImageViewConstraints)
        NSLayoutConstraint.activate(displayNameTextFieldConstraints)
        NSLayoutConstraint.activate(usernameTextFieldConstraints)
        NSLayoutConstraint.activate(bioTextViewConstraints)
        NSLayoutConstraint.activate(submitButtonConstraints)
    }

    


}


extension EditProfileViewController: UITextViewDelegate, UITextFieldDelegate {
   
    //textView delegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 100), animated: true) //this puts the scroll view up so the keyboard is shown without hiding anyhing
        
        if textView.textColor == .lightGray { // to remove the costimized place holder
            textView.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true) //this puts the scroll view down again after dismissing the keyboard
        if textView.text.isEmpty { // to return the costimized place holder
            textView.text = "Tell the world about yourself"
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) { //you cant add a target function on a text view like textfields to make them like buttons, but this delegate method works
        ProfileDataFormViewViewModel.viewModel.bio = textView.text
        ProfileDataFormViewViewModel.viewModel.validateUserProfileForm() //we check if the form is valid evry time anything in it is changed so we can enable the button
    }

    
    //textField delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //this puts the scroll view up so the keyboard is shown without hiding anyhing
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //this puts the scroll view down again after dismissing the keyboard
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
  
}


extension EditProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true) //to seelect the image and dismiss the gallery picked from
        
        for result in results { //although we specified the results to be one image but it returns an array so we iterate throw it
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarPlaceholderImageView.image = image
                        ProfileDataFormViewViewModel.viewModel.imageData = image
                        ProfileDataFormViewViewModel.viewModel.validateUserProfileForm()  //we check if the form is valid evry time anything in it is changed so we can enable the button
                    }
                }
            }
        }
    }



}
