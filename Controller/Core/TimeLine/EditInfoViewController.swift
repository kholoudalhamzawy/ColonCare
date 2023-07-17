//
//  EditInfoViewController.swift
//  colonCancer
//
//  Created by KH on 05/07/2023.
//

import UIKit
import Combine
import FirebaseAuth

class EditInfoViewController: UIViewController, UITextFieldDelegate {

        
        private let mailStackView = UIStackView()
        private let passwordStackView = UIStackView()
        private let phoneStackView = UIStackView()
        private let nameStackView = UIStackView()
        
        private let genderStackView = UIStackView()
        private let weightStackView = UIStackView()
        private let heightStackView = UIStackView()
        private let ageStackView = UIStackView()

    
        private var viewModel = AuthenticationViewViewModel()

        private var profileViewModel = profileViewViewModel()
    
        private var subscriptions: Set<AnyCancellable> = []
    
        
        // MARK: - password
        private let passwordSign: UIImageView = {
            let sign = UIImageView.init(image: UIImage(named:"ic-lock"))
            sign.contentMode = .scaleToFill
            sign.clipsToBounds = true
            sign.translatesAutoresizingMaskIntoConstraints = false
            return sign
            
        }()
        
        private let passwordTextFeild : UITextField = {
            let txtField = UITextField()
            txtField.tag = 1
            txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
            txtField.textAlignment = .left
            txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
            txtField.font = UIFont(name: "Poppins-Light", size: 16)
            txtField.isSecureTextEntry = true
            txtField.translatesAutoresizingMaskIntoConstraints = false
            txtField.tintColor = .white
            return txtField
            
        }()
        
        
        
        private let isHidden : UIButton = {
            let btn = UIButton()
            btn.setImage(UIImage(named:"ic-unhide"), for: .normal)
            btn.addTarget(self, action: #selector(toggleHidingPassword), for: .touchUpInside)
            btn.contentMode = .scaleToFill
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
            
        }()
        
        
        @objc func toggleHidingPassword() {
            passwordTextFeild.isSecureTextEntry = passwordTextFeild.isSecureTextEntry ? false : true
        }
        
        func configurePasswordStackView(){
            
            passwordStackView.addArrangedSubview(passwordSign)
            passwordStackView.addArrangedSubview(passwordTextFeild)
            passwordStackView.addArrangedSubview(isHidden)
            
            passwordStackView.axis = .horizontal
            passwordStackView.distribution = .fillProportionally
            passwordStackView.spacing = 10
            passwordStackView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(passwordStackView)
            
        }
        
        
        //MARK: - mail
        
        private let mailSign: UIImageView = {
            let sign = UIImageView.init(image: UIImage(named:"ic-at"))
            sign.contentMode = .scaleToFill
            sign.clipsToBounds = true
            sign.translatesAutoresizingMaskIntoConstraints = false
            return sign
            
        }()
        
        private let mailTextFeild : UITextField = {
            let txtField = UITextField()
            txtField.tag = 0
            txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your e_mail", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
            txtField.textAlignment = .left
            txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
            txtField.font = UIFont(name: "Poppins-Light", size: 18)
            txtField.translatesAutoresizingMaskIntoConstraints = false
            txtField.tintColor = .white
            txtField.keyboardType = .emailAddress
            return txtField
        }()
        
        @objc private func didTapToDismiss(){
            view.endEditing(true)
        }
        
        func configuremailStackView(){
            
            mailStackView.addArrangedSubview(mailSign)
            mailStackView.addArrangedSubview(mailTextFeild)
            mailStackView.axis = .horizontal
            mailStackView.distribution = .fillProportionally
            mailStackView.spacing = 15
            mailStackView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(mailStackView)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
            
            
        }
        
        //MARK: - name
        
        private let nameSign: UIImageView = {
            let sign = UIImageView.init(image: UIImage(named:"ic-person"))
            sign.contentMode = .scaleToFill
            sign.clipsToBounds = true
            sign.translatesAutoresizingMaskIntoConstraints = false
            return sign
            
        }()
        
        private let nameTextFeild : UITextField = {
            let txtField = UITextField()
            txtField.tag = 2
            txtField.attributedPlaceholder =  NSAttributedString(string:"Enter your name", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
            txtField.textAlignment = .left
            txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
            txtField.font = UIFont(name: "Poppins-Light", size: 18)
            txtField.translatesAutoresizingMaskIntoConstraints = false
            txtField.tintColor = .white
            return txtField
        }()
        
        func configurenameStackView(){
            nameStackView.addArrangedSubview(nameSign)
            nameStackView.addArrangedSubview(nameTextFeild)
            nameStackView.axis = .horizontal
            nameStackView.distribution = .fillProportionally
            nameStackView.spacing = 15
            nameStackView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(nameStackView)
        }
        
        
        
        //MARK: - phone
        
        private let phoneSign: UIImageView = {
            let sign = UIImageView.init(image: UIImage(named:"ic-phone"))
            sign.contentMode = .scaleToFill
            sign.clipsToBounds = true
            sign.translatesAutoresizingMaskIntoConstraints = false
            return sign
            
        }()
        
        private let phoneTextFeild : UITextField = {
            let txtField = UITextField()
            txtField.tag = 3
            txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your phone number", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
            txtField.textAlignment = .left
            txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
            txtField.font = UIFont(name: "Poppins-Light", size: 18)
            txtField.translatesAutoresizingMaskIntoConstraints = false
            txtField.tintColor = .white //tint color is the color of the curser poiter
            return txtField
        }()
        
        func configurephoneStackView(){
            phoneStackView.addArrangedSubview(phoneSign)
            phoneStackView.addArrangedSubview(phoneTextFeild)
            phoneStackView.axis = .horizontal
            phoneStackView.distribution = .fillProportionally
            phoneStackView.spacing = 15
            phoneStackView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(phoneStackView)
        }
        
    
    //MARK: - gender
    
    private let genderSign: UIImageView = {
        let sign = UIImageView.init(image: UIImage(systemName:"mustache"))
        sign.contentMode = .scaleToFill
        sign.clipsToBounds = true
        sign.translatesAutoresizingMaskIntoConstraints = false
        sign.tintColor = UIColor.secondaryLabel

        return sign
        
    }()
    
    private let genderTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.tag = 3
        txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your gender", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Light", size: 18)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = .white //tint color is the color of the curser poiter
        return txtField
    }()
    
    func configuregenderStackView(){
        genderStackView.addArrangedSubview(genderSign)
        genderStackView.addArrangedSubview(genderTextFeild)
        genderStackView.axis = .horizontal
        genderStackView.distribution = .fillProportionally
        genderStackView.spacing = 15
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(genderStackView)
    }
    
    //MARK: - weight
    
    private let weightSign: UIImageView = {
        let sign = UIImageView.init(image: UIImage(systemName: "scalemass"))
        sign.contentMode = .scaleToFill
        sign.clipsToBounds = true
        sign.translatesAutoresizingMaskIntoConstraints = false
        sign.tintColor = UIColor.secondaryLabel
        return sign
        
    }()
    
    private let weightTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.tag = 3
        txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your weight", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Light", size: 18)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = .white //tint color is the color of the curser poiter
        return txtField
    }()
    
    func configureweightStackView(){
        weightStackView.addArrangedSubview(weightSign)
        weightStackView.addArrangedSubview(weightTextFeild)
        weightStackView.axis = .horizontal
        weightStackView.distribution = .fillProportionally
        weightStackView.spacing = 15
        weightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(weightStackView)
    }
    
    //MARK: - height
    
    private let heightSign: UIImageView = {
        let sign = UIImageView.init(image: UIImage(systemName:"ruler"))
        sign.contentMode = .scaleToFill
        sign.clipsToBounds = true
        sign.translatesAutoresizingMaskIntoConstraints = false
        sign.tintColor = UIColor.secondaryLabel
        return sign
        
    }()
    
    private let heightTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.tag = 3
        txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your height", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Light", size: 18)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = .white //tint color is the color of the curser poiter
        return txtField
    }()
    
    func configureheightStackView(){
        heightStackView.addArrangedSubview(heightSign)
        heightStackView.addArrangedSubview(heightTextFeild)
        heightStackView.axis = .horizontal
        heightStackView.distribution = .fillProportionally
        heightStackView.spacing = 15
        heightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(heightStackView)
    }
    
    //MARK: - age
    
    private let ageSign: UIImageView = {
        let sign = UIImageView.init(image: UIImage(systemName: "tortoise"))
        sign.tintColor = UIColor.secondaryLabel
        sign.contentMode = .scaleToFill
        sign.clipsToBounds = true
        sign.translatesAutoresizingMaskIntoConstraints = false
        return sign
        
    }()
    
    private let ageTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.tag = 3
        txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your age", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Light", size: 18)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = .white //tint color is the color of the curser poiter
        return txtField
    }()
    
    func configureageStackView(){
        ageStackView.addArrangedSubview(ageSign)
        ageStackView.addArrangedSubview(ageTextFeild)
        ageStackView.axis = .horizontal
        ageStackView.distribution = .fillProportionally
        ageStackView.spacing = 15
        ageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(ageStackView)
    }
        
        //MARK: - lines
        
        
        private let line1: UIImageView = {
            let line = UIImageView.init(image: UIImage(named:"ic-line"))
            line.contentMode = .scaleToFill
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()
        private let line2: UIImageView = {
            let line = UIImageView.init(image: UIImage(named:"ic-line"))
            line.contentMode = .scaleToFill
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()
        private let line3: UIImageView = {
            let line = UIImageView.init(image: UIImage(named:"ic-line"))
            line.contentMode = .scaleToFill
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()
        private let line4: UIImageView = {
            let line = UIImageView.init(image: UIImage(named:"ic-line"))
            line.contentMode = .scaleToFill
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()
    
        private let line5: UIImageView = {
            let line = UIImageView.init(image: UIImage(named:"ic-line"))
            line.contentMode = .scaleToFill
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()

        private let line6: UIImageView = {
            let line = UIImageView.init(image: UIImage(named:"ic-line"))
            line.contentMode = .scaleToFill
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()

        private let line7: UIImageView = {
            let line = UIImageView.init(image: UIImage(named:"ic-line"))
            line.contentMode = .scaleToFill
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()

        private let line8: UIImageView = {
            let line = UIImageView.init(image: UIImage(named:"ic-line"))
            line.contentMode = .scaleToFill
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()

    
        //MARK: - lbls & btns
        
        
        private let signUpLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
            view.font = UIFont(name: "Poppins-Medium", size: 16)
            view.textAlignment = .center
            view.text = "Your Info"
            view.numberOfLines = 0
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
      
        private let submitBtn: UIButton = {
            let btn = UIButton()
            btn.layer.cornerRadius = 21
            btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
            btn.titleLabel?.textAlignment = .center
            btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
            btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
            btn.layer.borderWidth = 0.5
            btn.setTitle("Submit", for: .normal)
            btn.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        
        @objc func didTapSubmit(){
            viewModel.password = passwordTextFeild.text
            viewModel.email = mailTextFeild.text
            viewModel.name = nameTextFeild.text
            viewModel.phoneNumber = phoneTextFeild.text
            viewModel.gender = genderTextFeild.text
            viewModel.height = heightTextFeild.text
            viewModel.age = ageTextFeild.text
            viewModel.weight = weightTextFeild.text
            viewModel.validateEditForm()
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            return true
        }
      
        
        //    private func presentAlert(with error: String) {
        //        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        //        let okayButton = UIAlertAction(title: "ok", style: .default)
        //        alert.addAction(okayButton)
        //        present(alert, animated: true)
        //    }
        
        
        
        
        
        //    @objc func toggleHiddenErrors(){
        //        nameValidationLbl.isHidden.toggle()
        //        mailValidationLbl.isHidden.toggle()
        //        passwordValidationLbl.isHidden.toggle()
        //        phoneValidationLbl.isHidden.toggle()
        //    }
        
        
        //MARK: - TEXT VALIDATION
        
        private let mailValidationLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
            view.font = UIFont(name: "Poppins-Light", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            return view
        }()
        private let phoneValidationLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
            view.font = UIFont(name: "Poppins-Light", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            return view
        }()
        private let nameValidationLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
            view.font = UIFont(name: "Poppins-Light", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            return view
        }()
        private let passwordValidationLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
            view.font = UIFont(name: "Poppins-Light", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            
            return view
        }()
        private let ageValidationLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
            view.font = UIFont(name: "Poppins-Light", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            
            return view
        }()
        private let weightValidationLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
            view.font = UIFont(name: "Poppins-Light", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            
            return view
        }()
        private let heightValidationLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
            view.font = UIFont(name: "Poppins-Light", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            
            return view
        }()
        private let genderValidationLbl: UILabel = {
            var view = UILabel()
            view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
            view.font = UIFont(name: "Poppins-Light", size: 12)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .left
            
            return view
        }()
            
        func configureNavigationBar(){
            let size: CGFloat = 24
            
            let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            navigationItem.titleView = middleView
            
            let ReminderView = UILabel()
            ReminderView.font = UIFont(name: "Poppins-Medium", size: 24)
            ReminderView.textColor = .label
            ReminderView.text = "your Info"
            navigationItem.titleView = ReminderView
            navigationItem.backButtonTitle = ""
            
            let doneButton = UIBarButtonItem(title: "Done", style: .done , target: self, action: #selector(doneBtnTapped))
                
            navigationItem.rightBarButtonItem = doneButton
            
        }
    
        @objc func doneBtnTapped() {
            viewModel.password = passwordTextFeild.text
            viewModel.email = mailTextFeild.text
            viewModel.name = nameTextFeild.text
            viewModel.phoneNumber = phoneTextFeild.text
            viewModel.gender = genderTextFeild.text
            viewModel.height = heightTextFeild.text
            viewModel.age = ageTextFeild.text
            viewModel.weight = weightTextFeild.text
            viewModel.validateEditForm()
        }
        
        private func applyConstarints(){
            
            let scrollViewConstraints = [
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
           
            //MARK: - NAME CONSTRAINTS
            
            let nameSignConstraints = [
                nameSign.widthAnchor.constraint(equalToConstant: 25),
                nameSign.heightAnchor.constraint(equalToConstant: 25),
                
            ]
            let nameTxtFieldConstraints = [
                nameTextFeild.widthAnchor.constraint(equalToConstant: 287),
                nameTextFeild.heightAnchor.constraint(equalToConstant: 28),
                
            ]
            
            let nameStackViewConstraints = [
                nameStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                nameStackView.topAnchor.constraint(equalTo: nameValidationLbl.bottomAnchor, constant: 5),
                nameStackView.heightAnchor.constraint(equalToConstant: 28)
                
            ]
            let nameValidationLblConstraints = [
                nameValidationLbl.widthAnchor.constraint(equalToConstant: 287),
                nameValidationLbl.heightAnchor.constraint(equalToConstant: 28),
                nameValidationLbl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
                nameValidationLbl.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor)
            ]
            
            //MARK: - MAIL CONSTRAINTS
            
            let mailSignConstraints = [
                mailSign.widthAnchor.constraint(equalToConstant: 28),
                mailSign.heightAnchor.constraint(equalToConstant: 28)
            ]
            let mailTxtFieldConstraints = [
                mailTextFeild.widthAnchor.constraint(equalToConstant: 287),
                mailTextFeild.heightAnchor.constraint(equalToConstant: 28)
            ]
            
            let mailStackViewConstraints = [
                mailStackView.topAnchor.constraint(equalTo: mailValidationLbl.bottomAnchor, constant: 5),
                mailStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                mailStackView.heightAnchor.constraint(equalToConstant: 28)
                
            ]
            
            let mailValidationLblConstraints = [
                mailValidationLbl.widthAnchor.constraint(equalToConstant: 287),
                mailValidationLbl.heightAnchor.constraint(equalToConstant: 28),
                mailValidationLbl.leadingAnchor.constraint(equalTo: mailStackView.leadingAnchor),
                mailValidationLbl.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 5)
            ]
            
            //MARK: - PASSWORD CONSTRAINTS
            
            let passwordSignConstraints = [
                passwordSign.widthAnchor.constraint(equalToConstant: 20),
                passwordSign.heightAnchor.constraint(equalToConstant: 25)
            ]
            let passwordTextfieldConstraints = [
                passwordTextFeild.widthAnchor.constraint(equalToConstant: 263),
                passwordTextFeild.heightAnchor.constraint(equalToConstant: 28)
            ]
            let ishiddenBtnConstraints = [
                isHidden.widthAnchor.constraint(equalToConstant: 20),
                isHidden.heightAnchor.constraint(equalToConstant: 25)
            ]
            let passwordStackViewConstraints = [
                passwordStackView.topAnchor.constraint(equalTo: passwordValidationLbl.bottomAnchor, constant: 5),
                passwordStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                passwordStackView.heightAnchor.constraint(equalToConstant: 28)
                
            ]
            
            let paswsordValidationLblConstraints = [
                passwordValidationLbl.widthAnchor.constraint(equalToConstant: 350),
                passwordValidationLbl.heightAnchor.constraint(equalToConstant: 28),
                passwordValidationLbl.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor),
                passwordValidationLbl.topAnchor.constraint(equalTo: line2.bottomAnchor,constant: 5)
                
            ]
            
            //MARK: - PHONE CONSTRAINTS
            
            let phoneSignConstraints = [
                phoneSign.widthAnchor.constraint(equalToConstant: 25),
                phoneSign.heightAnchor.constraint(equalToConstant: 25)
            ]
            let phoneTxtFieldConstraints = [
                phoneTextFeild.widthAnchor.constraint(equalToConstant: 287),
                phoneTextFeild.heightAnchor.constraint(equalToConstant: 28)
            ]
            
            let phoneStackViewConstraints = [
                phoneStackView.topAnchor.constraint(equalTo: phoneValidationLbl.bottomAnchor, constant: 5),
                phoneStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                phoneStackView.heightAnchor.constraint(equalToConstant: 28)
            ]
            let phoneValidationLblConstraints = [
                phoneValidationLbl.widthAnchor.constraint(equalToConstant: 287),
                phoneValidationLbl.heightAnchor.constraint(equalToConstant: 28),
                phoneValidationLbl.leadingAnchor.constraint(equalTo: phoneStackView.leadingAnchor),
                phoneValidationLbl.topAnchor.constraint(equalTo: line3.bottomAnchor,constant: 5)
                
            ]
            
            //MARK: - gender CONSTRAINTS
            
            let genderSignConstraints = [
                genderSign.widthAnchor.constraint(equalToConstant: 25),
                genderSign.heightAnchor.constraint(equalToConstant: 25)
            ]
            let genderTxtFieldConstraints = [
                genderTextFeild.widthAnchor.constraint(equalToConstant: 287),
                genderTextFeild.heightAnchor.constraint(equalToConstant: 28)
            ]
            
            let genderStackViewConstraints = [
                genderStackView.topAnchor.constraint(equalTo: genderValidationLbl.bottomAnchor, constant: 5),
                genderStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                genderStackView.heightAnchor.constraint(equalToConstant: 28)
            ]
            let genderValidationLblConstraints = [
                genderValidationLbl.widthAnchor.constraint(equalToConstant: 287),
                genderValidationLbl.heightAnchor.constraint(equalToConstant: 28),
                genderValidationLbl.leadingAnchor.constraint(equalTo: genderStackView.leadingAnchor),
                genderValidationLbl.topAnchor.constraint(equalTo: line4.bottomAnchor,constant: 5)
                
            ]
            
            //MARK: - age CONSTRAINTS
            
            let ageSignConstraints = [
                ageSign.widthAnchor.constraint(equalToConstant: 25),
                ageSign.heightAnchor.constraint(equalToConstant: 25)
            ]
            let ageTxtFieldConstraints = [
                ageTextFeild.widthAnchor.constraint(equalToConstant: 287),
                ageTextFeild.heightAnchor.constraint(equalToConstant: 28)
            ]
            
            let ageStackViewConstraints = [
                ageStackView.topAnchor.constraint(equalTo: ageValidationLbl.bottomAnchor, constant: 5),
                ageStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                ageStackView.heightAnchor.constraint(equalToConstant: 28)
            ]
            let ageValidationLblConstraints = [
                ageValidationLbl.widthAnchor.constraint(equalToConstant: 287),
                ageValidationLbl.heightAnchor.constraint(equalToConstant: 28),
                ageValidationLbl.leadingAnchor.constraint(equalTo: ageStackView.leadingAnchor),
                ageValidationLbl.topAnchor.constraint(equalTo: line5.bottomAnchor,constant: 5)
                
            ]
            
            //MARK: - weight CONSTRAINTS
            
            let weightSignConstraints = [
                weightSign.widthAnchor.constraint(equalToConstant: 25),
                weightSign.heightAnchor.constraint(equalToConstant: 25)
            ]
            let weightTxtFieldConstraints = [
                weightTextFeild.widthAnchor.constraint(equalToConstant: 287),
                weightTextFeild.heightAnchor.constraint(equalToConstant: 28)
            ]
            
            let weightStackViewConstraints = [
                weightStackView.topAnchor.constraint(equalTo: weightValidationLbl.bottomAnchor, constant: 5),
                weightStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                weightStackView.heightAnchor.constraint(equalToConstant: 28)
            ]
            let weightValidationLblConstraints = [
                weightValidationLbl.widthAnchor.constraint(equalToConstant: 287),
                weightValidationLbl.heightAnchor.constraint(equalToConstant: 28),
                weightValidationLbl.leadingAnchor.constraint(equalTo: weightStackView.leadingAnchor),
                weightValidationLbl.topAnchor.constraint(equalTo: line6.bottomAnchor,constant: 5)
                
            ]
            
            //MARK: - height CONSTRAINTS
            
            let heightSignConstraints = [
                heightSign.widthAnchor.constraint(equalToConstant: 25),
                heightSign.heightAnchor.constraint(equalToConstant: 25)
            ]
            let heightTxtFieldConstraints = [
                heightTextFeild.widthAnchor.constraint(equalToConstant: 287),
                heightTextFeild.heightAnchor.constraint(equalToConstant: 28)
            ]
            
            let heightStackViewConstraints = [
                heightStackView.topAnchor.constraint(equalTo: heightValidationLbl.bottomAnchor, constant: 5),
                heightStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                heightStackView.heightAnchor.constraint(equalToConstant: 28)
            ]
            let heightValidationLblConstraints = [
                heightValidationLbl.widthAnchor.constraint(equalToConstant: 287),
                heightValidationLbl.heightAnchor.constraint(equalToConstant: 28),
                heightValidationLbl.leadingAnchor.constraint(equalTo: heightStackView.leadingAnchor),
                heightValidationLbl.topAnchor.constraint(equalTo: line7.bottomAnchor,constant: 5)
                
            ]
            
            //MARK: - LINES CONSTRAINTS
            
            let line1Constraints = [
                line1.topAnchor.constraint(equalTo:nameStackView.bottomAnchor, constant: 18),
                line1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                line1.widthAnchor.constraint(equalToConstant: 323),
                line1.heightAnchor.constraint(equalToConstant: 1)
                
            ]
            let line2Constraints = [
                line2.topAnchor.constraint(equalTo: mailStackView.bottomAnchor, constant: 13),
                line2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                line2.widthAnchor.constraint(equalToConstant: 323),
                line2.heightAnchor.constraint(equalToConstant: 1)
            ]
            let line3Constraints = [
                line3.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 18),
                line3.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                line3.widthAnchor.constraint(equalToConstant: 323),
                line3.heightAnchor.constraint(equalToConstant: 1)
            ]
            let line4Constraints = [
                line4.topAnchor.constraint(equalTo: phoneStackView.bottomAnchor, constant: 18),
                line4.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                line4.widthAnchor.constraint(equalToConstant: 323),
                line4.heightAnchor.constraint(equalToConstant: 1)
            ]
            let line5Constraints = [
                line5.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 18),
                line5.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                line5.widthAnchor.constraint(equalToConstant: 323),
                line5.heightAnchor.constraint(equalToConstant: 1)
            ]
            let line6Constraints = [
                line6.topAnchor.constraint(equalTo: ageStackView.bottomAnchor, constant: 18),
                line6.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                line6.widthAnchor.constraint(equalToConstant: 323),
                line6.heightAnchor.constraint(equalToConstant: 1)
            ]
            let line7Constraints = [
                line7.topAnchor.constraint(equalTo: weightStackView.bottomAnchor, constant: 18),
                line7.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                line7.widthAnchor.constraint(equalToConstant: 323),
                line7.heightAnchor.constraint(equalToConstant: 1)
            ]
            let line8Constraints = [
                line8.topAnchor.constraint(equalTo: heightStackView.bottomAnchor, constant: 18),
                line8.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                line8.widthAnchor.constraint(equalToConstant: 323),
                line8.heightAnchor.constraint(equalToConstant: 1)
            ]
            
            let submitBtnConstraints = [
                submitBtn.widthAnchor.constraint(equalToConstant: 177),
                submitBtn.heightAnchor.constraint(equalToConstant: 40),
                submitBtn.topAnchor.constraint(equalTo: line8.bottomAnchor, constant: 80),
                submitBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                submitBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
            ]
            
            
            
            
            NSLayoutConstraint.activate(scrollViewConstraints)
            
            NSLayoutConstraint.activate(nameValidationLblConstraints)
            NSLayoutConstraint.activate(nameSignConstraints)
            NSLayoutConstraint.activate(nameTxtFieldConstraints)
            NSLayoutConstraint.activate(nameStackViewConstraints)
            
            NSLayoutConstraint.activate(line1Constraints)
            
            
            NSLayoutConstraint.activate(mailValidationLblConstraints)
            NSLayoutConstraint.activate(mailSignConstraints)
            NSLayoutConstraint.activate(mailTxtFieldConstraints)
            NSLayoutConstraint.activate(mailStackViewConstraints)
            
            NSLayoutConstraint.activate(line2Constraints)
            
            NSLayoutConstraint.activate(paswsordValidationLblConstraints)
            NSLayoutConstraint.activate(passwordTextfieldConstraints)
            NSLayoutConstraint.activate(passwordSignConstraints)
            NSLayoutConstraint.activate(ishiddenBtnConstraints)
            NSLayoutConstraint.activate(passwordStackViewConstraints)
            
            NSLayoutConstraint.activate(line3Constraints)
            
            NSLayoutConstraint.activate(phoneValidationLblConstraints)
            NSLayoutConstraint.activate(phoneSignConstraints)
            NSLayoutConstraint.activate(phoneTxtFieldConstraints)
            NSLayoutConstraint.activate(phoneStackViewConstraints)
            
            NSLayoutConstraint.activate(line4Constraints)
            
            NSLayoutConstraint.activate(genderValidationLblConstraints)
            NSLayoutConstraint.activate(genderSignConstraints)
            NSLayoutConstraint.activate(genderTxtFieldConstraints)
            NSLayoutConstraint.activate(genderStackViewConstraints)
            
            NSLayoutConstraint.activate(line5Constraints)
            
            NSLayoutConstraint.activate(ageValidationLblConstraints)
            NSLayoutConstraint.activate(ageSignConstraints)
            NSLayoutConstraint.activate(ageTxtFieldConstraints)
            NSLayoutConstraint.activate(ageStackViewConstraints)
            
            NSLayoutConstraint.activate(line6Constraints)
            
            NSLayoutConstraint.activate(weightValidationLblConstraints)
            NSLayoutConstraint.activate(weightSignConstraints)
            NSLayoutConstraint.activate(weightTxtFieldConstraints)
            NSLayoutConstraint.activate(weightStackViewConstraints)
            
            NSLayoutConstraint.activate(line7Constraints)
            
            NSLayoutConstraint.activate(heightValidationLblConstraints)
            NSLayoutConstraint.activate(heightSignConstraints)
            NSLayoutConstraint.activate(heightTxtFieldConstraints)
            NSLayoutConstraint.activate(heightStackViewConstraints)
            
            NSLayoutConstraint.activate(line8Constraints)
            
//            NSLayoutConstraint.activate(submitBtnConstraints)
            
        }
        private let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.alwaysBounceVertical = true //very important when initilizing scrollviews it shows that the content can be scrollable
            //  scrollView.keyboardDismissMode = .onDrag
            return scrollView
        }()
        
        
        
        override func viewWillAppear(_ animated: Bool) {//viewWillAppear is better than view did appear to show the view more instantly
            super.viewWillAppear(animated)
            profileViewModel.retrieveUser()
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            colors.setBackGround(view)
            view.addSubview(scrollView)
            configureNavigationBar()
            
            isModalInPresentation = true //makes the scrollview undissmisable
                        
            configurenameStackView()
            configuremailStackView()
            configurePasswordStackView()
            configurephoneStackView()
            
            configuregenderStackView()
            configureageStackView()
            configureweightStackView()
            configureheightStackView()
            
            scrollView.addSubview(line1)
            scrollView.addSubview(line2)
            scrollView.addSubview(line3)
            scrollView.addSubview(line4)
            scrollView.addSubview(line5)
            scrollView.addSubview(line6)
            scrollView.addSubview(line7)
            scrollView.addSubview(line8)

            scrollView.addSubview(nameValidationLbl)
            scrollView.addSubview(mailValidationLbl)
            scrollView.addSubview(passwordValidationLbl)
            scrollView.addSubview(phoneValidationLbl)
            
            scrollView.addSubview(genderValidationLbl)
            scrollView.addSubview(ageValidationLbl)
            scrollView.addSubview(weightValidationLbl)
            scrollView.addSubview(heightValidationLbl)

            
//            scrollView.addSubview(submitBtn)
            
            applyConstarints()
            bindViews()
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            
            
            nameTextFeild.delegate = self
            mailTextFeild.delegate = self
            passwordTextFeild.delegate = self
            phoneTextFeild.delegate = self
            
            ageTextFeild.delegate = self
            heightTextFeild.delegate = self
            genderTextFeild.delegate = self
            weightTextFeild.delegate = self
            

//            nameTextFeild.text = "khaoloudz"
//            mailTextFeild.text = "khoaloudz@kh.com"
//            passwordTextFeild.text = "Kh123456"
//            phoneTextFeild.text = "01445678900"
            
            
        }
    
        
        private func bindViews(){
            
            profileViewModel.$user.sink { [weak self] user in
                guard let user = user else {return}
                self?.nameTextFeild.text = user.name
                self?.passwordTextFeild.text = "********"
                
                self?.mailTextFeild.text = Auth.auth().currentUser?.email
                self?.phoneTextFeild.text = user.phoneNumber
                self?.genderTextFeild.text = user.gender?.rawValue
                self?.ageTextFeild.text = String(user.age)
                self?.weightTextFeild.text = String(user.weight)
                self?.heightTextFeild.text = String(user.height)

            }
            .store(in: &subscriptions)
            
            viewModel.$isEditFormValid.sink{ [weak self] validationState in
                if validationState {
                    self?.navigationController?.popViewController(animated: true)

                }
            }
            .store(in: &subscriptions)
            
            viewModel.$error.sink{ [weak self] errorString in
                guard let error = errorString else { return }
                //            self?.presentAlert(with: error)
            }
            .store(in: &subscriptions)
            
            viewModel.$nameError.sink{  [weak self] errorString in
                guard let error = errorString else { return }
                self?.nameValidationLbl.text = error
            }.store(in: &subscriptions)
            
            viewModel.$emailError.sink{  [weak self] errorString in
                guard let error = errorString else { return }
                self?.mailValidationLbl.text = error
            }.store(in: &subscriptions)
            
            viewModel.$passwordError.sink{  [weak self] errorString in
                guard let error = errorString else { return }
                self?.passwordValidationLbl.text = error
            }.store(in: &subscriptions)
            
            viewModel.$phoneError.sink{  [weak self] errorString in
                guard let error = errorString else { return }
                self?.phoneValidationLbl.text = error
            }.store(in: &subscriptions)
            
            viewModel.$genderError.sink{  [weak self] errorString in
                guard let error = errorString else { return }
                self?.genderValidationLbl.text = error
            }.store(in: &subscriptions)
            
            viewModel.$heightError.sink{  [weak self] errorString in
                guard let error = errorString else { return }
                self?.heightValidationLbl.text = error
            }.store(in: &subscriptions)
            
            viewModel.$weightError.sink{  [weak self] errorString in
                guard let error = errorString else { return }
                self?.weightValidationLbl.text = error
            }.store(in: &subscriptions)
            
            viewModel.$ageError.sink{  [weak self] errorString in
                guard let error = errorString else { return }
                self?.ageValidationLbl.text = error
            }.store(in: &subscriptions)
        }
        
        
        var isExpand : Bool = false
        @objc func keyboardApear(){
            print("Call")
            if !isExpand {
                print("Call = EXECUTE")
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 300)
                isExpand = true
            }
        }
        
        @objc func keyboardDisapear(){
            if isExpand {
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 100)
                self.isExpand = false
            }
            
        }
        
        
        
        
    


}
