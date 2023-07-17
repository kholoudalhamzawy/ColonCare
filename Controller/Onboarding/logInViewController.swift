//
//  logInViewController.swift
//  colonCancer
//
//  Created by KH on 17/03/2023.
//

import UIKit
import Combine



class logInViewController: UIViewController, UITextFieldDelegate {
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
  

    
    private let passwordTextFeild : UITextField = {
        let txtField = UITextField()
        txtField.tag = 1
        txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your Password", attributes:
        [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
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
   
    private let mailValidationLbl: UILabel = {
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
    
    
    //MARK:- mail
    
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
        txtField.attributedPlaceholder =  NSAttributedString(string: "Enter your e_mail", attributes:
        [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
        txtField.textAlignment = .left
        txtField.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        txtField.font = UIFont(name: "Poppins-Light", size: 16)
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.tintColor = .white
        txtField.keyboardType = .emailAddress
        return txtField
    }()
    
    
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
    
    private let rememberMeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.font = UIFont(name: "Poppins-ExtraLight", size: 13)
        lbl.text = "Remember me"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let isChecked : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square"), for: .normal)
        btn.addTarget(self, action: #selector(togglecheck), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
                     
    @objc func togglecheck( _ sender: UIButton ) {
        let image = sender.currentImage == UIImage(systemName: "square") ? UIImage(named:"ic-checkbox") : UIImage(systemName: "square")
        sender.setImage(image, for: .normal)
 }
    
    private let logInBtn : UIButton = {
//        let view = UIView()
//        view.addSubview(btn)
        
        //btn.backgroundColor = .white
//
//        let layer0 = CAGradientLayer()
//        layer0.frame = btn.bounds

//        layer0.colors = [
//            UIColor(red: 0.427, green: 0.351, blue: 0.608, alpha: 0.7).cgColor,
//          UIColor(red: 0.355, green: 0.244, blue: 0.621, alpha: 0).cgColor
////            UIColor.clear.cgColor,
////            UIColor.systemMint.cgColor
//        ]
//        layer0.locations = [0, 1]
//        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
//        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
//        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0.01, tx: 1, ty: -0.01))
//        layer0.bounds = btn.bounds.insetBy(dx: -0.5*btn.bounds.size.width, dy: -0.5*btn.bounds.size.height)
//        layer0.position = btn.center
//        btn.layer.addSublayer(layer0)
        
        //        btn.addTarget(self, action: #selector(togglecheck), for: .touchUpInside)
        //        btn.applyGradient(Colors: [colors.UIColorFromRGB(0x2B95CE).cgColor,colors.UIColorFromRGB(0x2ECAD5).cgColor])
        //        btn.applyGradient(Colors: [colors.UIColorFromRGB(0x6D599B).cgColor,colors.UIColorFromRGB(0xFFFFFF).cgColor])
        //        view.translatesAutoresizingMaskIntoConstraints = false
        //        btn.frame = view.bounds

        //        return view

        

        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.layer.borderWidth = 0.5
        btn.setTitle( "Log In", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(logIn), for: .touchUpInside)
//        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            if let touch = touches.first {
//                // ...
//            }
//            super.touchesBegan(touches, with: event)
//        }
        return btn

    }()
    
    private func bindViews(){
       
        viewModel.$isAuthenticationFormValid.sink{ [weak self] validationState in
            if validationState {
                self?.viewModel.logInUser()

            }
        }
        .store(in: &subscriptions)
        
        viewModel.$user.sink{ [weak self] user in //when we get a user from the view model
            guard user != nil else {return}
            guard let vc = self?.navigationController?.viewControllers.first as? logInViewController else {return}
            vc.dismiss(animated: true)
        }
        .store(in: &subscriptions)
        
        viewModel.$error.sink{ [weak self] errorString in 
            guard let error = errorString else { return } //guard let cause $error is an optional
            self?.errorLbl.text = error
                                
        }
        .store(in: &subscriptions)
        
        viewModel.$emailError.sink{  [weak self] errorString in
            guard let error = errorString else { return }
            self?.mailValidationLbl.text = error
        }.store(in: &subscriptions)

        viewModel.$passwordError.sink{  [weak self] errorString in
            guard let error = errorString else { return }
            self?.passwordValidationLbl.text = error
        }.store(in: &subscriptions)
    }
    
    @objc func logIn(){
        viewModel.password = passwordTextFeild.text
        viewModel.email = mailTextFeild.text
        viewModel.validateAuthenticationLogInForm()
    }
    var errorLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        view.sizeToFit() //not working
        return view
        }()

  
    
    private let forgetPassLbl : UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-ExtraLight", size: 11)
        view.textAlignment = .center
        view.text = "Did you forget your password"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    
    private let resetPassLbl: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.597, green: 0.381, blue: 0.812, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 13)
        view.textAlignment = .center
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Reset password", attributes: underlineAttribute)
        view.attributedText = underlineAttributedString

        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    private let signUpBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 25)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.setTitle( "Sign Up", for: .normal)
        btn.addTarget(self, action: #selector(gotoSignUpScreen), for: .touchUpInside) 
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
       

    }()
    
    @objc func gotoSignUpScreen(){
        let nextScreen = signUpViewController()
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    
    
    private let mailStackView = UIStackView()
    private let passwordStackView = UIStackView()
    private let rememberMeStackView = UIStackView()
    private let resetPassStackView = UIStackView()
    private let forgetResetPassStackView = UIStackView()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors.setBackGround(view)
        navigationItem.backButtonTitle = "log in"

        
        configuremailStackView()
        configurePasswordStackView()
        view.addSubview(line1)
        view.addSubview(line2)
        configureRememberMeStack()
        view.addSubview(logInBtn)
        configureforgetResetPassStackView()
        view.addSubview(mailValidationLbl)
        view.addSubview(passwordValidationLbl)
        view.addSubview(signUpBtn)
        view.addSubview(errorLbl)
        applyConstarints()
        
        mailTextFeild.text = "khoaloudz@kh.com"
        passwordTextFeild.text = "Kh123456"
//        mailTextFeild.text = "Rr@rr.rr"
//        passwordTextFeild.text = "Rr11111111"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        bindViews()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        mailTextFeild.delegate = self
        passwordTextFeild.delegate = self
        

    }
    
    @objc private func didTapToDismiss(){
        view.endEditing(true)
    }
    
    var isExpand : Bool = false
    @objc func keyboardApear(){
        print("Call")
        if !isExpand {
            print("Call = EXECUTE")
           // self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 300)
            isExpand = true
        }
    }
    
    @objc func keyboardDisapear(){
        if isExpand {
        //    self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 300)
            self.isExpand = false
        }
        
    }
    
    private func applyConstarints(){
        
        let passwordSignConstraints = [
            passwordSign.widthAnchor.constraint(equalToConstant: 20),
            passwordSign.heightAnchor.constraint(equalToConstant: 25)
        ]
        let passwordTextfieldConstraints = [
            passwordTextFeild.widthAnchor.constraint(equalToConstant: 263),
            passwordTextFeild.heightAnchor.constraint(equalToConstant: 28)
        ]
        let ishiddenBtnConstraints = [
            isHidden.widthAnchor.constraint(equalToConstant: 15),
            isHidden.heightAnchor.constraint(equalToConstant: 20)
            //  isHidden.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ]
        let passwordStackViewConstraints = [
            passwordStackView.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 32),
            passwordStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
           
        ]
        let mailSignConstraints = [
            mailSign.widthAnchor.constraint(equalToConstant: 25),
            mailSign.heightAnchor.constraint(equalToConstant: 25)
        ]
        let mailTxtFieldConstraints = [
            mailTextFeild.widthAnchor.constraint(equalToConstant: 287),
            mailTextFeild.heightAnchor.constraint(equalToConstant: 28)
         ]
       
        let mailStackViewConstraints = [
            mailStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70), //was 140
            mailStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let line1Constraints = [
            line1.topAnchor.constraint(equalTo: mailStackView.bottomAnchor, constant: 16),
            line1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            line1.widthAnchor.constraint(equalToConstant: 323),
            line1.heightAnchor.constraint(equalToConstant: 1)
            
        ]
        let line2Constraints = [
            line2.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 16),
            line2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            line2.widthAnchor.constraint(equalToConstant: 323),
            line2.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let checkBoxConstraints = [
            isChecked.widthAnchor.constraint(equalToConstant: 20),
            isChecked.heightAnchor.constraint(equalToConstant: 20)
        ]
        let rememberMeLblConstraints = [
            rememberMeLabel.widthAnchor.constraint(equalToConstant: 290),
            rememberMeLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        let rememberMeStackConstraints = [
            rememberMeStackView.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 24),
            rememberMeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let logInBtnConstraints = [
            logInBtn.widthAnchor.constraint(equalToConstant: 177),
            logInBtn.heightAnchor.constraint(equalToConstant: 40),
//            logInBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 430)
            logInBtn.topAnchor.constraint(equalTo: rememberMeStackView.bottomAnchor, constant: 46),
            logInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let forgetPassLblConstraints = [
            forgetPassLbl.widthAnchor.constraint(equalToConstant: 160),
            forgetPassLbl.heightAnchor.constraint(equalToConstant: 20)
        ]
        let resetPassLblConstraints = [
            resetPassLbl.widthAnchor.constraint(equalToConstant: 123),
            resetPassLbl.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let forgetResetPassStackConstraints = [
            forgetResetPassStackView.topAnchor.constraint(equalTo: logInBtn.bottomAnchor, constant: 23),
            forgetResetPassStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let signUpBtnConstraints = [
            signUpBtn.topAnchor.constraint(equalTo: forgetResetPassStackView.bottomAnchor, constant: 48),
            signUpBtn.widthAnchor.constraint(equalToConstant: 323),
            signUpBtn.heightAnchor.constraint(equalToConstant: 29),
            signUpBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ]
        let mailValidationLblConstraints = [
            mailValidationLbl.widthAnchor.constraint(equalToConstant: 287),
            mailValidationLbl.heightAnchor.constraint(equalToConstant: 28),
            mailValidationLbl.leadingAnchor.constraint(equalTo: mailStackView.leadingAnchor),
            mailValidationLbl.bottomAnchor.constraint(equalTo: mailStackView.topAnchor,constant: -5)
        ]
        let paswsordValidationLblConstraints = [
            passwordValidationLbl.widthAnchor.constraint(equalToConstant: 350),
            passwordValidationLbl.heightAnchor.constraint(equalToConstant: 28),
            passwordValidationLbl.leadingAnchor.constraint(equalTo: passwordStackView.leadingAnchor),
            passwordValidationLbl.bottomAnchor.constraint(equalTo: passwordStackView.topAnchor,constant: -5)
            
        ]
        let errorLblConstraints = [
           errorLbl.widthAnchor.constraint(equalToConstant: 309),

           errorLbl.heightAnchor.constraint(equalToConstant: 150),
           errorLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           errorLbl.topAnchor.constraint(equalTo: signUpBtn.bottomAnchor, constant: 20)
//           errorLbl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
           ]

        
        NSLayoutConstraint.activate(passwordTextfieldConstraints)
        NSLayoutConstraint.activate(passwordSignConstraints)
        NSLayoutConstraint.activate(ishiddenBtnConstraints)
        NSLayoutConstraint.activate(passwordStackViewConstraints)
        NSLayoutConstraint.activate(paswsordValidationLblConstraints)

        NSLayoutConstraint.activate(mailSignConstraints)
        NSLayoutConstraint.activate(mailTxtFieldConstraints)
        NSLayoutConstraint.activate(mailStackViewConstraints)
        NSLayoutConstraint.activate(mailValidationLblConstraints)
        
        NSLayoutConstraint.activate(line1Constraints)
        NSLayoutConstraint.activate(line2Constraints)
        
        NSLayoutConstraint.activate(checkBoxConstraints)
        NSLayoutConstraint.activate(rememberMeLblConstraints)
        NSLayoutConstraint.activate(rememberMeStackConstraints)
        
        NSLayoutConstraint.activate(logInBtnConstraints)
        
        NSLayoutConstraint.activate(signUpBtnConstraints)

        NSLayoutConstraint.activate(errorLblConstraints)
        
        NSLayoutConstraint.activate(forgetPassLblConstraints)
        NSLayoutConstraint.activate(resetPassLblConstraints)
        NSLayoutConstraint.activate(forgetResetPassStackConstraints)


    }
    
    
    
    func configurePasswordStackView(){
        
        passwordStackView.addArrangedSubview(passwordSign)
        passwordStackView.addArrangedSubview(passwordTextFeild)
        passwordStackView.addArrangedSubview(isHidden)
      
        passwordStackView.axis = .horizontal
        passwordStackView.distribution = .fillProportionally
        passwordStackView.spacing = 10
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
       
       view.addSubview(passwordStackView)
       
    }
        
    func configuremailStackView(){
        
        mailStackView.addArrangedSubview(mailSign)
        mailStackView.addArrangedSubview(mailTextFeild)
        
        mailStackView.axis = .horizontal
        mailStackView.distribution = .fillProportionally
        mailStackView.spacing = 10
        mailStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mailStackView)
    
    }
    
    func configureRememberMeStack(){
        rememberMeStackView.addArrangedSubview(isChecked)
        rememberMeStackView.addArrangedSubview(rememberMeLabel)
        
        rememberMeStackView.axis = .horizontal
        rememberMeStackView.distribution = .fillProportionally
        rememberMeStackView.spacing = 9
        rememberMeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rememberMeStackView)
    }
    
    func configureforgetResetPassStackView(){
        forgetResetPassStackView.addArrangedSubview(forgetPassLbl)
        forgetResetPassStackView.addArrangedSubview(resetPassLbl)
        
        forgetResetPassStackView.axis = .horizontal
        forgetResetPassStackView.distribution = .fillProportionally
        forgetResetPassStackView.spacing = 30
        forgetResetPassStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(forgetResetPassStackView)
    }

}
//
//extension UIButton {
//    func applyGradient(Colors: [CGColor]) {
//        self.backgroundColor = nil
//        self.layoutIfNeeded()
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = Colors
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        gradientLayer.frame = self.bounds
//        gradientLayer.cornerRadius = self.frame.height/2
//
//        gradientLayer.shadowColor = UIColor.darkGray.cgColor
//        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        gradientLayer.shadowRadius = 5.0
//        gradientLayer.shadowOpacity = 0.3
//        gradientLayer.masksToBounds = false
//
//        self.layer.insertSublayer(gradientLayer, at: 9)
//        self.contentVerticalAlignment = .center
//        self.setTitleColor(UIColor.white, for: .normal)
//        self.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
//        self.titleLabel?.textColor = UIColor.white
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 0.3
//        self.setTitle( "Log In", for: .normal)

//

//

//    }
//}
