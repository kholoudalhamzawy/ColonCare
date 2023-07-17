//
//  GenderViewController.swift
//  colonCancer
//
//  Created by KH on 22/03/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class GenderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true //makes the scrollview undissmisable

        
        navigationItem.hidesBackButton = true
        colors.setBackGround(view)
        view.addSubview(genderQLbl)
        view.addSubview(progressBar)
        configureBtnStack()
        view.addSubview(nextBtn)
        view.addSubview(errorLbl)

        applyConstraint()
        
    }
    
    private let btnStackView = UIStackView()
    
    func configureBtnStack(){
        btnStackView.addArrangedSubview(maleBtn)
        btnStackView.addArrangedSubview(femaleBtn)
        btnStackView.addArrangedSubview(otherBtn)
        
        btnStackView.axis = .vertical
        btnStackView.distribution = .fillEqually
        btnStackView.spacing = 25
        btnStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(btnStackView)
    
    }
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.3
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.tintColor = #colorLiteral(red: 0.5490196078, green: 0.3333333333, blue: 0.7607843137, alpha: 1)
        bar.trackTintColor = .white
        return bar
    }()
    
    private let genderQLbl : UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Bold", size: 24)
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.text = "What is your gender ?"
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()

    private let maleBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.layer.borderWidth = 0.5
        btn.setTitle( "Male", for: .normal)
        btn.addTarget(self, action: #selector(SelectGender), for: .touchUpInside)
        btn.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let femaleBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.layer.borderWidth = 0.5
        btn.setTitle( "Female", for: .normal)
        btn.addTarget(self, action: #selector(SelectGender), for: .touchUpInside)
        btn.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)

        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let otherBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.layer.borderWidth = 0.5
        btn.setTitle( "Other", for: .normal)
        btn.addTarget(self, action: #selector(SelectGender), for: .touchUpInside)
        btn.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    @objc func optionSelected(_ sender: UIButton) {

        maleBtn.isSelected = false
        femaleBtn.isSelected = false
        otherBtn.isSelected = false
        sender.isSelected = true

        let array = [maleBtn,femaleBtn,otherBtn]
        for btn in array {
            if btn.isSelected{
                btn.layer.borderColor = #colorLiteral(red: 0.5490196078, green: 0.3333333333, blue: 0.7607843137, alpha: 1)
                btn.layer.borderWidth = 1
            } else {
                btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
                btn.layer.borderWidth = 0.5
            }
        }

        
    }
    
    @objc func SelectGender(_ sender: UIButton){
        
        if let gender = sender.titleLabel?.text {
            switch gender{
            case "Male":
                ProfileDataFormViewViewModel.viewModel.gender = Gender.male.rawValue
            case "Female":
                ProfileDataFormViewViewModel.viewModel.gender = Gender.female.rawValue
            default:
                ProfileDataFormViewViewModel.viewModel.gender = Gender.other.rawValue
            }
            genderWasSelected = true
        }
        
    }
    var genderWasSelected: Bool = false
    @objc func NextQ(){
        if genderWasSelected{
                self.navigationController?.pushViewController(AgeViewController(), animated: true)
            } else {
                errorLbl.text = "you must select a gender!"
            }
        
    }
    
    let nextBtn : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.setTitle( "Next", for: .normal)
        btn.addTarget(self, action: #selector(NextQ), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn

    }()
    
    var errorLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
        }()

    func applyConstraint(){
        
        
        
        let progressBarConstraints = [
            progressBar.widthAnchor.constraint(equalToConstant: 331),
            progressBar.heightAnchor.constraint(equalToConstant: 7),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55)
        ]
        let genderQLblConstraints = [
            genderQLbl.widthAnchor.constraint(equalToConstant: 331),
            genderQLbl.heightAnchor.constraint(equalToConstant: 36),
            genderQLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderQLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 105)
        ]
        let maleBtnConstraints = [
            maleBtn.widthAnchor.constraint(equalToConstant: 177),
            maleBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        let femaleBtnConstraints = [
            femaleBtn.widthAnchor.constraint(equalToConstant: 177),
            femaleBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        let otherBtnConstraints = [
            otherBtn.widthAnchor.constraint(equalToConstant: 177),
            otherBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let btnStackViewConstraints = [
            btnStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnStackView.topAnchor.constraint(equalTo: genderQLbl.bottomAnchor, constant: 35)
        ]
        let nextBtnnCostraint = [
            nextBtn.widthAnchor.constraint(equalToConstant: 309),
            nextBtn.heightAnchor.constraint(equalToConstant: 36),
            nextBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextBtn.topAnchor.constraint(equalTo: btnStackView.bottomAnchor, constant: 35)
            
        ]
        let errorLblConstraints = [
           errorLbl.widthAnchor.constraint(equalToConstant: 309),
           errorLbl.heightAnchor.constraint(equalToConstant: 36),
           errorLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           errorLbl.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: 30)
            
        ]
        NSLayoutConstraint.activate(genderQLblConstraints)
        NSLayoutConstraint.activate(progressBarConstraints)
        NSLayoutConstraint.activate(btnStackViewConstraints)
        NSLayoutConstraint.activate(maleBtnConstraints)
        NSLayoutConstraint.activate(femaleBtnConstraints)
        NSLayoutConstraint.activate(otherBtnConstraints)
        NSLayoutConstraint.activate(nextBtnnCostraint)
        NSLayoutConstraint.activate(errorLblConstraints)

    }
}
