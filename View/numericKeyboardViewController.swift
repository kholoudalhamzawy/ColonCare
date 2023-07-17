////
////  numericKeyboardViewController.swift
////  colonCancer
////
////  Created by KH on 23/03/2023.
////
//
//import UIKit
//
//class numericKeyBoard: UIView {
//    private let stack1 = UIStackView()
//    private let stack2 = UIStackView()
//    private let stack3 = UIStackView()
//    private let stack4 = UIStackView()
//    private let stack = UIStackView()
//    var displayLabel = UILabel()
//    var displayError = UILabel()
//    
//    private let button1: UIButton = {
//        let btn = UIButton()
//        btn.layer.cornerRadius = 23
//        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
//        btn.titleLabel?.textAlignment = .center
//        btn.titleLabel?.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
//        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
//        btn.layer.borderWidth = 0.3
//        btn.setTitle( "1", for: .normal)
//        btn.addTarget(self, action: #selector(NumberPressed), for: .touchUpInside)
//        return btn
//    }()
//    @objc func NumberPressed(_ sender: UIButton){
//        if let numValue = sender.currentTitle {
//            if isFinishedTypingNumber {
//                displayLabel.text = numValue
//                isFinishedTypingNumber = false
//            
//            } else {
//                displayLabel.text = displayLabel.text! + numValue
//            }
//            
//        }
//    }
//    private var isFinishedTypingNumber: Bool = true
//    
//   @objc func submitNumber(){
//       if isFinishedTypingNumber{
//           displayError = "you must enter a number"
//       }
//       
//    }
//    
//    func saveNumber(number: Int) -> string {
//       
//        else{
//            isFinishedTypingNumber = true
//            guard let number = Int(displayLabel.text!) else {
//                fatalError("Cannot convert display label text to a number.")
//            }
//            if number > 99 {
//                print ("you're age must be less than 100")
//            } else if number < 10 {
//                print ("you're age must be atleast 10")
//            }
//            else {
//                return number
//            }
//        }
//    }
//    
//
//    func configureStack1(){
//        
//        stack1.axis = .horizontal
//        stack1.distribution = .fillEqually
//        stack1.spacing = 15
//        stack1.translatesAutoresizingMaskIntoConstraints = false
//       
//    }
//    func configureStack(){
//        stack.addArrangedSubview(stack1)
//        stack.addArrangedSubview(stack2)
//        stack.addArrangedSubview(stack3)
//        stack.addArrangedSubview(stack4)
//
//        stack.axis = .horizontal
//        stack.distribution = .fillEqually
//        stack.spacing = 10
//        stack.translatesAutoresizingMaskIntoConstraints = false
//    }
//    
//    func applyConstraints(){
//        let stack1Constraints = [
//            stack1.widthAnchor.constraint(equalToConstant: 338),
//            stack1.heightAnchor.constraint(equalToConstant: 33)
//        ]
//        NSLayoutConstraint.activate(stack1Constraints)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(stack)
//        applyConstraints()
//    }
//    
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        stack.frame = bounds
//    }
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//}
