//
//  HightViewController.swift
//  colonCancer
//
//  Created by KH on 22/03/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class MeasurmentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true //makes the scrollview undissmisable

        navigationItem.hidesBackButton = true
        colors.setBackGround(view)
        view.addSubview(measurmentsQLbl)
        view.addSubview(progressBar)
        configuretextFiledStackView()
        view.addSubview(nextBtn)
        view.addSubview(stack)
        view.addSubview(errorLbl)
        configureStack()
        applyConstraint()
        
    }
    
    private let textFiledStackView = UIStackView()
    
    func configuretextFiledStackView(){
        textFiledStackView.addArrangedSubview(heightBtn)
        textFiledStackView.addArrangedSubview(weightBtn)
        
        textFiledStackView.axis = .vertical
        textFiledStackView.distribution = .fillEqually
        textFiledStackView.spacing = 25
        textFiledStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textFiledStackView)
    
    }
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 1
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.tintColor = #colorLiteral(red: 0.5490196078, green: 0.3333333333, blue: 0.7607843137, alpha: 1)
        bar.trackTintColor = .white
        return bar
    }()
    
    private let measurmentsQLbl : UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Bold", size: 24)
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.text = "What is your height and weight ?"
        view.numberOfLines = 0
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    private let heightBtn: UIButton = {
        let view = UIButton()
        view.setTitle("cm", for: .normal)
        view.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 21
        view.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        view.layer.borderColor = #colorLiteral(red: 0.5490196078, green: 0.3333333333, blue: 0.7607843137, alpha: 1)
        view.layer.borderWidth = 1
        view.isSelected = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(keyboardUnhide), for: .touchUpInside)
        view.addTarget(self, action: #selector(selectBtn), for: .touchUpInside)
        view.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)


        return view
    }()
    
    private let weightBtn: UIButton = {
        let view = UIButton()
        view.setTitle("KG", for: .normal)
        view.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 21
        view.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        view.titleLabel?.textAlignment = .center
        view.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        view.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.layer.borderWidth = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(keyboardUnhide), for: .touchUpInside)
        view.addTarget(self, action: #selector(selectBtn), for: .touchUpInside)
        view.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)



        return view
    }()
    @objc func optionSelected(_ sender: UIButton) {

        weightBtn.isSelected = false
        heightBtn.isSelected = false
        sender.isSelected = true

        let array = [weightBtn,heightBtn]
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
    @objc func NextQ(){
        navigationController?.pushViewController(ThanksViewController(), animated: true)
    }
    @objc func selectBtn( _ sender: UIButton){
        selectedBtn = sender
    }
    
    @objc func KeyboardHide(){
        stack.isHidden = true
        weightBtn.isSelected = false
        heightBtn.isSelected = false
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
        if selectedBtn == weightBtn{
            if var weight = weightBtn.titleLabel?.text{
                if(!weight.isEmpty){
                    weight.removeLast()
                    weightBtn.setTitle(weight, for: .normal)
                    if(weight.isEmpty){
                        isFinishedTypingWeight = true
                    }
                }
            }
        } else {
            if var height = heightBtn.titleLabel?.text{
                if(!height.isEmpty){
                    height.removeLast()
                    heightBtn.setTitle(height, for: .normal)
                    if(height.isEmpty){
                        isFinishedTypingHeight = true
                    }
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
    
    private var selectedBtn = UIButton()
    
    @objc func NumberPressed(_ sender: UIButton){
        if let numValue = sender.currentTitle {
            if selectedBtn == weightBtn{
                if isFinishedTypingWeight {
                    weightBtn.setTitle(numValue, for: .normal)
                    isFinishedTypingWeight = false
                } else {
                    let label = weightBtn.titleLabel!.text! + numValue
                    weightBtn.setTitle(label, for: .normal)
                }
            
        } else {
            if isFinishedTypingHeight {
                heightBtn.setTitle(numValue, for: .normal)
                isFinishedTypingHeight = false
            } else {
                let label = heightBtn.titleLabel!.text! + numValue
                heightBtn.setTitle(label, for: .normal)
            }
        }
    }
        
    }
    private var isFinishedTypingHeight: Bool = true{
        didSet {
            if isFinishedTypingHeight && !isExitingPage {
                heightBtn.setTitle("cm", for: .normal)
            }
        }
    }
    private var isFinishedTypingWeight: Bool = true{
        didSet {
            if isFinishedTypingWeight && !isExitingPage {
                weightBtn.setTitle("kg", for: .normal)
            }
        }
    }

    private var isExitingPage = false
    
    @objc func submitNumber(){
       if isFinishedTypingHeight || isFinishedTypingWeight{
           errorLbl.text = "you must enter all Measurments!"
       } else {
           if let height = Int(heightBtn.titleLabel!.text!), let weight = Int(weightBtn.titleLabel!.text!) {
               
               ProfileDataFormViewViewModel.viewModel.height = height
               ProfileDataFormViewViewModel.viewModel.weight = weight
               
               self.navigationController?.pushViewController(ProfileDataFormViewController(), animated: true)
               self.isFinishedTypingWeight = true
               self.isFinishedTypingHeight = true
            
           }else {
               errorLbl.text = "Cannot convert display label text to a number!"
           }
           
       }
       
    }
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
        let measurmentsQLblConstraints = [
            measurmentsQLbl.widthAnchor.constraint(equalToConstant: 331),
            measurmentsQLbl.heightAnchor.constraint(equalToConstant: 70),
            measurmentsQLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            measurmentsQLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 105)
        ]
        let heightTextFieldConstraints = [
            heightBtn.widthAnchor.constraint(equalToConstant: 177),
            heightBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        let weightTextFieldConstraints = [
            weightBtn.widthAnchor.constraint(equalToConstant: 177),
            weightBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let textFiledStackViewConstraints = [
            textFiledStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFiledStackView.topAnchor.constraint(equalTo: measurmentsQLbl.bottomAnchor, constant: 35)
        ]
        let nextBtnnCostraint = [
            nextBtn.widthAnchor.constraint(equalToConstant: 309),
            nextBtn.heightAnchor.constraint(equalToConstant: 36),
            nextBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextBtn.topAnchor.constraint(equalTo: textFiledStackView.bottomAnchor, constant: 35)
            
        ]
        let stackConstraints = [
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: 100)
        ]
        
        let errorLblConstraints = [
           errorLbl.widthAnchor.constraint(equalToConstant: 309),
           errorLbl.heightAnchor.constraint(equalToConstant: 36),
           errorLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           errorLbl.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: 30)
           ]
        NSLayoutConstraint.activate(errorLblConstraints)
        NSLayoutConstraint.activate(stackConstraints)
        NSLayoutConstraint.activate(progressBarConstraints)
        NSLayoutConstraint.activate(measurmentsQLblConstraints)
        NSLayoutConstraint.activate(heightTextFieldConstraints)
        NSLayoutConstraint.activate(weightTextFieldConstraints)
        NSLayoutConstraint.activate(textFiledStackViewConstraints)
        NSLayoutConstraint.activate(nextBtnnCostraint)

    }

}
