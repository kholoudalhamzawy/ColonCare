//
//  AlertViewController.swift
//  colonCancer
//
//  Created by KH on 03/07/2023.
//

import UIKit

class AlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        colors.setBackGround(view)
        view.addSubview(TitleLbl)
        view.addSubview(BodyLbl)
        view.addSubview(continueBtn)
        applyConstraint()

    }
    
    init(TitleLbl: String, BodyLbl: String, viewController: UIViewController) {
           self.TitleLbl.text = TitleLbl
           self.BodyLbl.text = BodyLbl
           self.myViewController = viewController
           
           super.init(nibName: nil, bundle: nil)
           
           // Additional initialization code, if needed
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    private let TitleLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Medium", size: 25)
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        view.text = "Heade UP !"
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let BodyLbl: UILabel = {
        var view = UILabel()
        view.font = UIFont(name: "Poppins-Regular", size: 15)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.text = "It's time For Your Medicine !"
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
        btn.setTitle( "Dismiss", for: .normal)
        btn.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    var myViewController: UIViewController
    @objc func goToNextScreen(){
//        guard let vc = navigationController?.viewControllers.first as? HelloViewController else {return}
        myViewController.dismiss(animated: true)
    }
    
  
    func applyConstraint(){
        
        let TitleLblConstraints = [
            TitleLbl.widthAnchor.constraint(equalToConstant: 330),
            TitleLbl.heightAnchor.constraint(equalToConstant: 40),
            TitleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TitleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 240)
        ]
        let BodyLblConstraints = [
            BodyLbl.widthAnchor.constraint(equalToConstant: 330),
            BodyLbl.heightAnchor.constraint(equalToConstant: 46),
            BodyLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            BodyLbl.topAnchor.constraint(equalTo: TitleLbl.bottomAnchor, constant: 17)
        ]
        
        let continueBtnConstraints = [
            continueBtn.widthAnchor.constraint(equalToConstant: 177),
            continueBtn.heightAnchor.constraint(equalToConstant: 40),
            continueBtn.topAnchor.constraint(equalTo: BodyLbl.bottomAnchor, constant: 60),
            continueBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(TitleLblConstraints)
        NSLayoutConstraint.activate(BodyLblConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)
        
    }
    

    
    

    

}
