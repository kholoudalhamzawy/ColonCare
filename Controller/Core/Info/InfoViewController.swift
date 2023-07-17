//
//  InfoViewController.swift
//  colonCancer
//
//  Created by KH on 22/06/2023.
//

import UIKit

class InfoViewController: UIViewController, UITextViewDelegate {
    


    private var body: UITextView = {
        let label = UITextView()
        label.textColor = .label
        label.isEditable = false
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Regular", size: 20)

        return label
    }()
    
    func configureNavigationBar(){
        let ReminderView = UILabel()
        ReminderView.font = UIFont(name: "Poppins-Medium", size: 24)
        ReminderView.textColor = .label
        ReminderView.text = header
        navigationItem.titleView = ReminderView
      
    }

    private var header: String = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.hidesBarsOnSwipe = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        body.delegate = self

        colors.setBackGround(view)
        view.addSubview(body)
        //this dosent work
//        body.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        body.widthAnchor.constraint(equalToConstant: 355).isActive = true
        body.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        body.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        body.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        body.contentOffset = CGPoint.zero
      
        
        // Do any additional setup after loading the view.
    }
    init(header: String, body: String){
        self.header = header
        self.body.text = body
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

   
}
