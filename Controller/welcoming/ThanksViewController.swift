//
//  ThanksViewController.swift
//  colonCancer
//
//  Created by KH on 22/03/2023.
//

import UIKit

class ThanksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        isModalInPresentation = true //makes the scrollview undissmisable
        colors.setBackGround(view)
        view.addSubview(thanksLbl)
        view.addSubview(AnswerLbl)
        view.addSubview(continueBtn)
        applyConstraint()

    }
    
    private let thanksLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 25)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.text = "Thanks For Signing Up !"
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let AnswerLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Regular", size: 15)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.text = "Now you can use the app"
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    private let continueBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderWidth = 0.5
        btn.setTitle( "Start using", for: .normal)
        btn.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func goToNextScreen(){
            guard let vc = navigationController?.viewControllers.first as? HelloViewController else {return}
            vc.dismiss(animated: true)
       
    }
    
  
    func applyConstraint(){
        
        let thanksLblConstraints = [
            thanksLbl.widthAnchor.constraint(equalToConstant: 330),
            thanksLbl.heightAnchor.constraint(equalToConstant: 40),
            thanksLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thanksLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 240)
        ]
        let answerLblConstraints = [
            AnswerLbl.widthAnchor.constraint(equalToConstant: 330),
            AnswerLbl.heightAnchor.constraint(equalToConstant: 46),
            AnswerLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            AnswerLbl.topAnchor.constraint(equalTo: thanksLbl.bottomAnchor, constant: 17)
        ]
        
        let continueBtnConstraints = [
            continueBtn.widthAnchor.constraint(equalToConstant: 177),
            continueBtn.heightAnchor.constraint(equalToConstant: 40),
            continueBtn.topAnchor.constraint(equalTo: AnswerLbl.bottomAnchor, constant: 60),
            continueBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(thanksLblConstraints)
        NSLayoutConstraint.activate(answerLblConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
        
    }
    

    
    

    

}
