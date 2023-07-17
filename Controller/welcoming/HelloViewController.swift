//
//  ViewController.swift
//  colonCancer
//
//  Created by KH on 21/03/2023.
//

import UIKit
import Combine
class HelloViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        isModalInPresentation = true //makes the scrollview undissmisable

        colors.setBackGround(view)
        view.addSubview(hiLbl)
        view.addSubview(AnswerLbl)
        view.addSubview(continueBtn)
        applyConstraint()
        ProfileDataFormViewViewModel.viewModel.retrieveUser()

    }
    private let hiLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 32)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        if let name = ProfileDataFormViewViewModel.viewModel.name {
                view.text = "Hi \(name) !"
            } else {
                view.text = "Hi !"
            }
           
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let AnswerLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Regular", size: 15)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.text = "Answer a few questions for more\n personalised results"
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    private let continueBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.layer.borderWidth = 0.5
        btn.setTitle( "Continue", for: .normal)
        btn.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func goToNextScreen(){
        navigationController?.pushViewController(GenderViewController(), animated: true)
    }
    
  
    func applyConstraint(){
        
        let hiLblConstraints = [
            hiLbl.widthAnchor.constraint(equalToConstant: 330),
            hiLbl.heightAnchor.constraint(equalToConstant: 40),
            hiLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hiLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 240)
        ]
        let answerLblConstraints = [
            AnswerLbl.widthAnchor.constraint(equalToConstant: 330),
            AnswerLbl.heightAnchor.constraint(equalToConstant: 46),
            AnswerLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            AnswerLbl.topAnchor.constraint(equalTo: hiLbl.bottomAnchor, constant: 17)
        ]
        let continueBtnConstraints = [
            continueBtn.widthAnchor.constraint(equalToConstant: 177),
            continueBtn.heightAnchor.constraint(equalToConstant: 40),
            continueBtn.topAnchor.constraint(equalTo: AnswerLbl.bottomAnchor, constant: 60),
            continueBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(hiLblConstraints)
        NSLayoutConstraint.activate(answerLblConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
        
    }
    

}
