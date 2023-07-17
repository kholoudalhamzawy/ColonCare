//
//  signUpViewController.swift
//  colonCancer
//
//  Created by KH on 20/03/2023.
//

import UIKit
import Combine


class signUpViewController: UIViewController,UITextFieldDelegate {
    
    private let mailStackView = UIStackView()
    private let passwordStackView = UIStackView()
    private let phoneStackView = UIStackView()
    private let nameStackView = UIStackView()
    
    private var viewModel = AuthenticationViewViewModel()
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
        txtField.font = UIFont(name: "Poppins-Light", size: 16)
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
        mailStackView.spacing = 10
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
        txtField.font = UIFont(name: "Poppins-Light", size: 16)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = .white
        return txtField
    }()
    
    func configurenameStackView(){
        nameStackView.addArrangedSubview(nameSign)
        nameStackView.addArrangedSubview(nameTextFeild)
        nameStackView.axis = .horizontal
        nameStackView.distribution = .fillProportionally
        nameStackView.spacing = 10
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
        txtField.font = UIFont(name: "Poppins-Light", size: 16)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = .white //tint color is the color of the curser poiter
        return txtField
    }()
    
    func configurephoneStackView(){
        phoneStackView.addArrangedSubview(phoneSign)
        phoneStackView.addArrangedSubview(phoneTextFeild)
        phoneStackView.axis = .horizontal
        phoneStackView.distribution = .fillProportionally
        phoneStackView.spacing = 10
        phoneStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(phoneStackView)
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
    
    //MARK: - lbls & btns
    
    
    private let signUpLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 32)
        view.textAlignment = .center
        view.text = "Sign Up"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let getInfoLbl: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.881, green: 0.882, blue: 0.882, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 11)
        view.text = "Enter your information and get notified by email"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
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
        viewModel.validateAuthenticationsignUpForm()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    private func bindViews(){
        
        viewModel.$isAuthenticationFormValid.sink{ [weak self] validationState in
            if validationState {
                self?.viewModel.createUser()

            }
        }
        .store(in: &subscriptions)
        
        viewModel.$user.sink{ [weak self] user in //when we get a user from the view model
            guard user != nil else {return}
            
            self?.viewModel.updateUserData()
            ProfileDataFormViewViewModel.viewModel.name = self?.viewModel.name
            guard let vc = self?.navigationController?.viewControllers.first as? logInViewController else {return}
            vc.dismiss(animated: true)
            
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
    
    
    
    private func applyConstarints(){
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let signUplblConstraints = [
            signUpLbl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            signUpLbl.widthAnchor.constraint(equalToConstant: 123),
            signUpLbl.heightAnchor.constraint(equalToConstant: 48),
            signUpLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ]
        let getInfoLblConstraints = [
            getInfoLbl.widthAnchor.constraint(equalToConstant: 290),
            getInfoLbl.heightAnchor.constraint(equalToConstant: 17),
            getInfoLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            getInfoLbl.topAnchor.constraint(equalTo: signUpLbl.bottomAnchor, constant: 10)
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
            nameValidationLbl.topAnchor.constraint(equalTo: getInfoLbl.bottomAnchor, constant: 23),
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
        
        let submitBtnConstraints = [
            submitBtn.widthAnchor.constraint(equalToConstant: 177),
            submitBtn.heightAnchor.constraint(equalToConstant: 40),
            submitBtn.topAnchor.constraint(equalTo: line4.bottomAnchor, constant: 80),
            submitBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            //            submitBtn.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20) //this always makes the button appear on top of the keyboard so it doesnt hide it
        ]
        
        
        
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(getInfoLblConstraints)
        NSLayoutConstraint.activate(signUplblConstraints)
        
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
        
        NSLayoutConstraint.activate(submitBtnConstraints)
        
    }
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true //very important when initilizing scrollviews it shows that the content can be scrollable
        //  scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors.setBackGround(view)
        view.addSubview(scrollView)
        
        isModalInPresentation = true //makes the scrollview undissmisable
        
        
        
        scrollView.addSubview(signUpLbl)
        scrollView.addSubview(getInfoLbl)
        
        configurenameStackView()
        configuremailStackView()
        configurePasswordStackView()
        configurephoneStackView()
        
        scrollView.addSubview(line1)
        scrollView.addSubview(line2)
        scrollView.addSubview(line3)
        scrollView.addSubview(line4)
        
        scrollView.addSubview(nameValidationLbl)
        scrollView.addSubview(mailValidationLbl)
        scrollView.addSubview(passwordValidationLbl)
        scrollView.addSubview(phoneValidationLbl)
        
        scrollView.addSubview(submitBtn)
        
        applyConstarints()
        bindViews()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        
        nameTextFeild.delegate = self
        mailTextFeild.delegate = self
        passwordTextFeild.delegate = self
        phoneTextFeild.delegate = self
//
//        nameTextFeild.text = "Ahmed Hany"
//        mailTextFeild.text = "AhmedHany@gmail.com"
//        passwordTextFeild.text = "Kh123456"
//        phoneTextFeild.text = "01445678900"
        
//        nameTextFeild.text = "Talya Gamal"
//        mailTextFeild.text = "TalyaGamal@gmail.com"
//        passwordTextFeild.text = "Kh123456"
//        phoneTextFeild.text = "01445678910"
        
        nameTextFeild.text = "Ali Asem"
        mailTextFeild.text = "AliAsem@gmail.com"
        passwordTextFeild.text = "Kh123456"
        phoneTextFeild.text = "01445679910"
        
        
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
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 300)
            self.isExpand = false
        }
        
    }
    
    
    
    
}

