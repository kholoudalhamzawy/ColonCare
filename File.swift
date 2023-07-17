//////
//////  File.swift
//////  colonCancer
//////
//////  Created by KH on 18/03/2023.
//////
////
//import Foundation
//import UIKit
////
//////
//////  logInViewController.swift
//////  colonCancer
//////
//////  Created by KH on 17/03/2023.
//////
////
////import UIKit
//
//class kogInViewController: UIViewController {
//    let ash = SignUpViewController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        ash.emailAddressField.text = "y@o.n"
//        ash.handleSignUpButtonPress()
//        colors.setBackGround(view)
//        var email = UITextField()
//        view.addSubview(email)
//     
//        
//        
//    }
//        
//    }
////   
////    
////    func setLabelView(){
////        var view = UILabel()
////        view.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
////        view.backgroundColor = .white
////
////        var shadows = UIView()
////        shadows.frame = view.frame
////        shadows.clipsToBounds = false
////        view.addSubview(shadows)
////
////        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
////        let layer0 = CALayer()
////        layer0.shadowPath = shadowPath0.cgPath
////        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
////        layer0.shadowOpacity = 1
////        layer0.shadowRadius = 4
////        layer0.shadowOffset = CGSize(width: 0, height: 4)
////        layer0.bounds = shadows.bounds
////        layer0.position = shadows.center
////        shadows.layer.addSublayer(layer0)
////
////        var stroke = UIView()
////        stroke.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
////        stroke.center = view.center
////        view.addSubview(stroke)
////        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
////        stroke.layer.borderWidth = 1
////        stroke.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
////
////        var parent = self.view!
////        parent.addSubview(view)
////        view.translatesAutoresizingMaskIntoConstraints = false
////        view.widthAnchor.constraint(equalToConstant: 18).isActive = true
////        view.heightAnchor.constraint(equalToConstant: 18).isActive = true
////        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 1).isActive = true
////        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 15).isActive = true
////    }
////    
////    
////    
////}
//
////
////class CustomButton: UIButton {
////
////    init() {
////        super.init(frame: .zero)
////        customInit()
////    }
////
////    required init?(coder aDecoder: NSCoder) {
////        super.init(coder: aDecoder)
////        customInit()
////    }
////
////    private func customInit() {
////        setupGradient()
////    }
////
////    private func setupGradient() {
////        let gradient = CAGradientLayer()
////        gradient.name = "gradient"
////        gradient.frame = self.bounds
////        gradient.cornerRadius = self.layer.cornerRadius
////
////        gradient.colors = [
////            UIColor(red: 1.00, green: 0.41, blue: 0.35, alpha: 1.0).cgColor,
////            UIColor(red: 1.00, green: 0.00, blue: 0.67, alpha: 1.0).cgColor
////        ]
////
////        gradient.locations = [0, 1]
////        gradient.startPoint = CGPoint(x: 0, y: 0)
////        gradient.endPoint = CGPoint(x: 1, y: 1)
////
////        self.layer.insertSublayer(gradient, at: 0) // insert to the back
////    }
////}

//ViewController: UIViewController {
//////
//////
//////
//////    override func viewDidLoad() {
//////        super.viewDidLoad()
//////
//////        for fontFamily in UIFont.familyNames {
//////            for font in UIFont.fontNames(forFamilyName: fontFamily){
//////                print ("--\(font)")
//////            }
//////        }
//////        }
//////
//////
//////}
//////
//private let weightTextField: UITextField = {
//    let view = UITextField()
//    view.attributedPlaceholder =  NSAttributedString(string: "KG", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
//    view.textAlignment = .center
//    view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
//    view.font = UIFont(name: "Poppins-Light", size: 16)
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.tintColor = .white
//    view.layer.cornerRadius = 21
//    view.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
//    view.layer.borderWidth = 0.5
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.addTarget(self, action: #selector(keyboardUnhide), for: .touchDown)
//    view.addTarget(self, action: #selector(selectBtn), for: .touchUpInside)
//
//    return view
//}()
