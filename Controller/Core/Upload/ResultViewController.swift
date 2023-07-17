//
//  ResultViewController.swift
//  colonCancer
//
//  Created by KH on 06/07/2023.
//

import UIKit

class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        colors.setBackGround(view)
        navigationItem.hidesBackButton = true


        view.addSubview(resultLbl)
        view.addSubview(infoLbl)
        view.addSubview(viewMapLbl)
        view.addSubview(CNNLbl)
        view.addSubview(LearnMoreLbl)
        view.addSubview(moreResultsbtn)
        view.addSubview(returnbtn)


        
        let maptapGesture = UITapGestureRecognizer(target: self, action: #selector(mapLblTapped))
        viewMapLbl.addGestureRecognizer(maptapGesture)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(learMoreLblTapped))
        LearnMoreLbl.addGestureRecognizer(tapGesture)
        
        configureConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if  UploadViewViewModel.model.CNNCancerResult! {
            resultLbl.text = "Cancerous :("
            infoLbl.text = "we are sorry to inform you that the results of the classification is cancer, view the map to see the nearest hospitals.. \n we are here for you 💜"
        } else {
            resultLbl.text = "Not Cancerous :)"
            infoLbl.text = "we are happy to inform you that the results of the classification is not cancer, view the map to see the nearest hospitals.. \n we are here for you 💜"
        }
        
        if UploadViewViewModel.model.isSsequance {
            CNNLbl.text = "This classifiction was made by hard voting Model using decision tree - KNN - SVM which accuracy is 95%"
        } else {
            CNNLbl.text = "This classifiction was made by ResNet50 Model which accuracy is 100%"

        }
        
    }
    
    @objc func mapLblTapped(_ sender: UITapGestureRecognizer) {
        let vc = MapViewController()
        navigationController?.pushViewController(vc, animated: true)
    
    }
    @objc func learMoreLblTapped(_ sender: UITapGestureRecognizer) {
        let vc = ModelsInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    private let resultLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 26)
        view.textAlignment = .center
        view.textColor = .white
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let infoLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 20)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewMapLbl: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.597, green: 0.381, blue: 0.812, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 16)
        view.textAlignment = .center
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "View Map", attributes: underlineAttribute)
        view.attributedText = underlineAttributedString
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    private let CNNLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 18)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "This classifiction was made by ResNet50 Model which accuracy is 100%"
        return view
    }()
    
    private let LearnMoreLbl: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.597, green: 0.381, blue: 0.812, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 16)
        view.textAlignment = .center
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "learn more About Model", attributes: underlineAttribute)
        view.attributedText = underlineAttributedString
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    private let moreResultsbtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderWidth = 0.5
        btn.setTitle("see more results from differnt models", for: .normal)
        btn.addTarget(self, action: #selector(didTapModels), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func didTapModels(_ sender: UITapGestureRecognizer) {
        let vc = ModelsInfoTableViewViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    
    }
    
    
    
    private let returnbtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderWidth = 0.5
        btn.setTitle("Return to classification", for: .normal)
        btn.addTarget(self, action: #selector(didTapReturn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func didTapReturn(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    
    }
    
    private func configureConstraints() {
        
        let resultLblelConstraints = [
            resultLbl.widthAnchor.constraint(equalToConstant: 330),
            resultLbl.heightAnchor.constraint(equalToConstant: 50),
            resultLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ]

        let infoLblelConstraints = [
            infoLbl.widthAnchor.constraint(equalToConstant: 330),
            infoLbl.heightAnchor.constraint(equalToConstant: 150),
            infoLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLbl.topAnchor.constraint(equalTo: resultLbl.bottomAnchor, constant: 30)
        ]
        let viewMapelConstraints = [
            viewMapLbl.widthAnchor.constraint(equalToConstant: 150),
            viewMapLbl.heightAnchor.constraint(equalToConstant: 30),
            viewMapLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewMapLbl.topAnchor.constraint(equalTo: infoLbl.bottomAnchor, constant: 0)
        ]
        
        let CNNLblConstraints = [
            CNNLbl.widthAnchor.constraint(equalToConstant: 330),
            CNNLbl.heightAnchor.constraint(equalToConstant: 80),
            CNNLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CNNLbl.topAnchor.constraint(equalTo: viewMapLbl.bottomAnchor, constant: 50)
        ]
        let LearnMoreLblConstraints = [
            LearnMoreLbl.widthAnchor.constraint(equalToConstant: 230),
            LearnMoreLbl.heightAnchor.constraint(equalToConstant: 30),
            LearnMoreLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LearnMoreLbl.topAnchor.constraint(equalTo: CNNLbl.bottomAnchor, constant: 0)
        ]
    
        let moreResultsConstraints = [
            moreResultsbtn.widthAnchor.constraint(equalToConstant: 350),
            moreResultsbtn.heightAnchor.constraint(equalToConstant: 50),
            moreResultsbtn.topAnchor.constraint(equalTo: LearnMoreLbl.bottomAnchor, constant: 60),
            moreResultsbtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
        ]
        let returnConstraints = [
            returnbtn.widthAnchor.constraint(equalToConstant: 225),
            returnbtn.heightAnchor.constraint(equalToConstant: 50),
            returnbtn.topAnchor.constraint(equalTo: moreResultsbtn.bottomAnchor, constant: 20),
            returnbtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
        ]
        
       
        
        NSLayoutConstraint.activate(resultLblelConstraints)
        NSLayoutConstraint.activate(infoLblelConstraints)
        NSLayoutConstraint.activate(viewMapelConstraints)
        NSLayoutConstraint.activate(CNNLblConstraints)
        NSLayoutConstraint.activate(LearnMoreLblConstraints)
        NSLayoutConstraint.activate(moreResultsConstraints)
        NSLayoutConstraint.activate(returnConstraints)

    }

}
