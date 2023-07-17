//
//  AgeViewController.swift
//  colonCancer
//
//  Created by KH on 22/03/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AgeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        colors.setBackGround(view)
        isModalInPresentation = true //makes the scrollview undissmisable

        view.addSubview(progressBar)
        view.addSubview(ageQLbl)
        view.addSubview(ageBtn)
        view.addSubview(nextBtn)
        view.addSubview(stack)
        view.addSubview(errorLbl)
        configureStack()

        applyConstraint()
        
    }
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.6
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.tintColor = #colorLiteral(red: 0.5490196078, green: 0.3333333333, blue: 0.7607843137, alpha: 1)
        bar.trackTintColor = .white
        return bar
    }()
    
    private let ageQLbl : UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Bold", size: 24)
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.text = "What is your age ?"
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    private var ageBtn: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 21
        view.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        view.layer.borderColor = #colorLiteral(red: 0.5490196078, green: 0.3333333333, blue: 0.7607843137, alpha: 1)
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(keyboardUnhide), for: .touchUpInside)

        return view
    }()
    
    @objc func KeyboardHide(){
        stack.isHidden = true
    }
    @objc func keyboardUnhide(){
        stack.isHidden = false
    }
    
    
    let nextBtn : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 20)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.setTitle( "Next", for: .normal)
        btn.addTarget(self, action: #selector(submitNumber), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn

    }()
  
    private let stack = UIStackView()
    var errorLbl: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 1, green: 0.5518405568, blue: 0.4788284456, alpha: 1)
        view.font = UIFont(name: "Poppins-Light", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
        }()
    func configureStack(){
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(doneBtn)
        
        var count = 0
        for _ in 1...3 {
            let subStack = UIStackView()
            subStack.axis = .horizontal
            subStack.distribution = .fillEqually
            subStack.spacing = 15
            subStack.translatesAutoresizingMaskIntoConstraints = false
            subStack.widthAnchor.constraint(equalToConstant: 338).isActive = true
            subStack.heightAnchor.constraint(equalToConstant: 33).isActive = true
            for _ in 1...3 {
                count+=1
                let btn = UIButton()
                btn.layer.cornerRadius = 18
                btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
                btn.titleLabel?.textAlignment = .center
                btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
                btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
                btn.layer.borderWidth = 0.4
                btn.setTitle(String(count), for: .normal)
                btn.addTarget(self, action: #selector(NumberPressed), for: .touchUpInside)
                subStack.addArrangedSubview(btn)
            }
            stack.addArrangedSubview(subStack)
        }
        
        configureSubStack()
        stack.addArrangedSubview(subStack)

    }
    private let doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(#colorLiteral(red: 0.4666666667, green: 0.2588235294, blue: 0.537254902, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.8032393298)
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
        btn.layer.cornerRadius = 12
        btn.titleLabel?.textAlignment = .center
        btn.setTitle("Done", for: .normal)
        btn.addTarget(self, action: #selector(KeyboardHide), for: .touchUpInside)

        return btn
    }()
    
    private let button0: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 18
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.layer.borderWidth = 0.4
        btn.setTitle( "0", for: .normal)
        btn.addTarget(self, action: #selector(NumberPressed), for: .touchUpInside)
        return btn
    }()
    private let buttonx: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 15)
        btn.titleLabel?.textAlignment = .center
        let img = UIImage(systemName: "delete.backward.fill")
        btn.tintColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.8032393298)
        btn.setImage(img!, for: .normal)
        btn.addTarget(self, action: #selector(deleteBtn), for: .touchUpInside)
        return btn
    }()
    @objc func deleteBtn(){
        if var age = ageBtn.titleLabel?.text{
            if(!age.isEmpty){
                age.removeLast()
                ageBtn.setTitle(age, for: .normal)
                if(age.isEmpty){
                    isFinishedTypingNumber = true
                }
            }
        }
    }
    let subStack = UIStackView ()
    private let buttony = UIButton()
    private func configureSubStack(){
        subStack.axis = .horizontal
        subStack.distribution = .fillEqually
        subStack.spacing = 15
        subStack.translatesAutoresizingMaskIntoConstraints = false
        subStack.widthAnchor.constraint(equalToConstant: 338).isActive = true
        subStack.heightAnchor.constraint(equalToConstant: 33).isActive = true
        subStack.addArrangedSubview(buttony)
        subStack.addArrangedSubview(button0)
        subStack.addArrangedSubview(buttonx)
        


    }
    
   
    
    @objc func NumberPressed(_ sender: UIButton){
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                ageBtn.setTitle(numValue, for: .normal)
                isFinishedTypingNumber = false
            } else {
                let label = ageBtn.titleLabel!.text! + numValue
                ageBtn.setTitle(label, for: .normal)
            }
        }
    }
    private var isFinishedTypingNumber: Bool = true
    
    @objc func submitNumber(){
       if isFinishedTypingNumber{
           errorLbl.text = "you must enter your age!"
       } else {
           if let number = Int(ageBtn.titleLabel!.text!) {
               if number > 99 {
                   errorLbl.text = "your age must be less than 100!"
               } else if number < 10 {
                   errorLbl.text = "your age must be at least 10!"
               } else {
                   isFinishedTypingNumber = true
                   ProfileDataFormViewViewModel.viewModel.age = number
                   self.navigationController?.pushViewController(MeasurmentsViewController(), animated: true)
                       }
               
           } else {
               errorLbl.text = "Cannot convert display label text to a number!"
           }
       }
       
    }
    

    func applyConstraint(){
        
        let progressBarConstraints = [
            progressBar.widthAnchor.constraint(equalToConstant: 331),
            progressBar.heightAnchor.constraint(equalToConstant: 7),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55)
        ]
        let ageQLblConstraints = [
            ageQLbl.widthAnchor.constraint(equalToConstant: 331),
            ageQLbl.heightAnchor.constraint(equalToConstant: 36),
            ageQLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageQLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 105)
        ]
        let ageTextFieldConstraints = [
            ageBtn.widthAnchor.constraint(equalToConstant: 177),
            ageBtn.heightAnchor.constraint(equalToConstant: 40),
            ageBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageBtn.topAnchor.constraint(equalTo: ageQLbl.bottomAnchor, constant: 45)
        ]
        
        let nextBtnnCostraint = [
            nextBtn.widthAnchor.constraint(equalToConstant: 309),
            nextBtn.heightAnchor.constraint(equalToConstant: 36),
            nextBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextBtn.topAnchor.constraint(equalTo: ageBtn.bottomAnchor, constant: 45)
            
        ]
        let stackConstraints = [
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: 188)
        ]
        let errorLblConstraints = [
           errorLbl.widthAnchor.constraint(equalToConstant: 309),
           errorLbl.heightAnchor.constraint(equalToConstant: 36),
           errorLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           errorLbl.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: 30)
            
        ]
        NSLayoutConstraint.activate(stackConstraints)
        NSLayoutConstraint.activate(ageQLblConstraints)
        NSLayoutConstraint.activate(progressBarConstraints)
        NSLayoutConstraint.activate(ageTextFieldConstraints)
        NSLayoutConstraint.activate(nextBtnnCostraint)
        NSLayoutConstraint.activate(errorLblConstraints)
            
        

    }
    

}
