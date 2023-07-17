//
//  AddReminder.swift
//  colonCancer
//
//  Created by KH on 21/05/2023.
//

import UIKit
import Combine

class AddReminderViewController: UIViewController, DropDownButtonDelegate,  UITextFieldDelegate  {
    
    func didSelectDays(_ index: Int) {
        print(index)
    }
    
    func didSelectType(_ index: Int) {
        print(index)

    }
    
    private var viewModel = ReminderViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    
    func configureNavigationBar(){
        let ReminderView = UILabel()
        ReminderView.font = UIFont(name: "Poppins-Medium", size: 24)
        ReminderView.textColor = .label
        ReminderView.text = "New Prescription"
        navigationItem.titleView = ReminderView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(didTapeExit))
        navigationItem.hidesBackButton = true
    }
    
    @objc private func didTapeExit(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colors.setBackGround(view)
        configureNavigationBar()
        view.addSubview(detailsLabel)
        view.addSubview(detailsStack)
        view.addSubview(NotificationsLabel)
        view.addSubview(NotificationsStack)
        view.addSubview(continueBtn)
        repeatButton.delegate = self
        repeatButton.medType = false
        TypeButton.delegate = self
        TypeButton.medType = true
        bindViews()
        applyConstraints()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        textFields[0].delegate = self
        textFields[1].delegate = self
        textFields[2].delegate = self


    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
//        TypeButton.didTapTohide()
//        repeatButton.didTapTohide()
    }
   
    
    
    let detailsLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 86, height: 33)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Poppins-Medium", size: 22)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Details"
        return view
    }()

    private var labels: [UILabel] = ["Name", "Type", "Dose Quantity", "amount" ]
        .map { labelText in
            let view = UILabel()
            view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            view.font = UIFont(name: "Poppins-Regular", size: 18)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.text = labelText
            view.textAlignment = .left
            return view
        }
    
    private lazy var labelsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
//        stackView.spacing = 18
        stackView.distribution = .fillEqually
        stackView.heightAnchor.constraint(equalToConstant: 226).isActive = true

        return stackView
    }()
    private var textFields: [UITextField] = [0,1,2]
        .map { index in
            let txtField = UITextField()
            txtField.tag = index
            txtField.attributedPlaceholder =  NSAttributedString(string: ". . .", attributes:
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
            txtField.textAlignment = .right
            txtField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            txtField.font = UIFont(name: "Poppins-Light", size: 18)
            txtField.translatesAutoresizingMaskIntoConstraints = false
            txtField.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
            txtField.setRightPaddingPoints(10)

            return txtField
        }

    private var TypeButton: DropDownButton = {
        let btn = DropDownButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.dataSource = [MedType.injection.rawValue, MedType.pill.rawValue, MedType.tablet.rawValue]
        btn.widthAnchor.constraint(equalToConstant: 125).isActive = true
        return btn
    }()
    
    
    private lazy var textFieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(textFields[0])
        stackView.addArrangedSubview(TypeButton)
        stackView.addArrangedSubview(textFields[1])
        stackView.addArrangedSubview(textFields[2])
//        stackView.addArrangedSubview(textFields[4])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.setCustomSpacing(17.5, after: textFields[0])
        stackView.setCustomSpacing(6.75, after: TypeButton)

        stackView.distribution = .fillProportionally
        stackView.heightAnchor.constraint(equalToConstant: 226).isActive = true


        return stackView
    }()
    
    private lazy var detailsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelsStack,textFieldsStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.09).cgColor
        stackView.layer.cornerRadius = 13

        return stackView
    }()
    
    
     let NotificationsLabel: UILabel = {
         var view = UILabel()
         view.frame = CGRect(x: 0, y: 0, width: 86, height: 33)
         view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
         view.font = UIFont(name: "Poppins-Medium", size: 22)
         view.textAlignment = .left
         view.translatesAutoresizingMaskIntoConstraints = false
         view.text = "Reminder"
         return view
     }()

     private var NotificationsLabels: [UILabel] = ["Time", "Repeat Days","Notifications"]
         .map { labelText in
             let view = UILabel()
             view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
             view.font = UIFont(name: "Poppins-Regular", size: 18)
             view.translatesAutoresizingMaskIntoConstraints = false
             view.text = labelText
             view.textAlignment = .left
             return view
         }
     
    
     private lazy var NotificationsLabelsStack: UIStackView = {
         let stackView = UIStackView(arrangedSubviews: NotificationsLabels)
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .vertical
         stackView.alignment = .leading
        // stackView.spacing = 27
//         stackView.isLayoutMarginsRelativeArrangement = true
//         stackView.layoutMargins = UIEdgeInsets(top: 22, left: 0, bottom: 10, right: 0)
         stackView.distribution = .fillEqually
         stackView.heightAnchor.constraint(equalToConstant: 225).isActive = true

         return stackView
     }()
    
     private var NotificationsTextFields: [UITextField] = [0,1]
         .map { index in
             let txtField = UITextField()
             txtField.tag = index
             txtField.attributedPlaceholder =  NSAttributedString(string: "...", attributes:
             [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 0.598688694) ])
             txtField.textAlignment = .right
             txtField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
             txtField.font = UIFont(name: "Poppins-Light", size: 18)
             txtField.translatesAutoresizingMaskIntoConstraints = false
             txtField.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
             txtField.setRightPaddingPoints(10)
             

             return txtField
         }
    
    private let mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = #colorLiteral(red: 0.7359752059, green: 0.501306951, blue: 0.9633793235, alpha: 1)

        /*For off state*/
        mySwitch.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        mySwitch.layer.cornerRadius = mySwitch.frame.height / 2.0
        mySwitch.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        mySwitch.clipsToBounds = true
        mySwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        mySwitch.setOn(false, animated: false)
        
        return mySwitch
    }()
    
     private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        //    datePicker.frame = CGRect(x: 10, y: 50, width: 350, height: 200)

         datePicker.timeZone = NSTimeZone.local
         datePicker.backgroundColor = UIColor.clear
         datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
         datePicker.datePickerMode = UIDatePicker.Mode.time

         datePicker.preferredDatePickerStyle = .inline

         datePicker.translatesAutoresizingMaskIntoConstraints = false
           
         return datePicker
    }()
    
    var selectedTime = CalendarHelper.getCurrentDate()
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "hh:mm a"
//        dateFormatter.timeStyle = .short
        // Apply date format
        selectedTime = sender.date
            // dateFormatter.string(from: sender.date)
    }

     
     private lazy var NotificationstextFieldsStack: UIStackView = {
         let stackView = UIStackView()
         stackView.addArrangedSubview(datePicker)
         stackView.addArrangedSubview(repeatButton)
         stackView.addArrangedSubview(mySwitch)

         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .vertical
         stackView.alignment = .trailing
         stackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
         stackView.spacing = 10
         stackView.setCustomSpacing(32, after: repeatButton)
         stackView.isLayoutMarginsRelativeArrangement = true
         stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         stackView.distribution = .fillProportionally
         stackView.heightAnchor.constraint(equalToConstant: 225).isActive = true

         return stackView
     }()
     
     private lazy var NotificationsStack: UIStackView = {
         let stackView = UIStackView(arrangedSubviews: [NotificationsLabelsStack,NotificationstextFieldsStack])
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .horizontal
         stackView.alignment = .trailing
         stackView.isLayoutMarginsRelativeArrangement = true
         stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
         stackView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.09).cgColor
         stackView.layer.cornerRadius = 13
         

         return stackView
     }()
    
    private let continueBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 21
        btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
        btn.titleLabel?.textAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1)
        btn.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9058823529, blue: 1, alpha: 1), for: .normal)
        btn.layer.borderWidth = 0.5
        btn.setTitle( "Save Med", for: .normal)
        btn.addTarget(self, action: #selector(DidTapContinue), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = false
        btn.setTitleColor(.white.withAlphaComponent(0.4), for: .disabled) //this makes the button dim when it's disabaled
        return btn
    }()
    
    private let calendarHelper = CalendarHelper()
    private let calendar = Calendar.current
   

    @objc private func DidTapContinue(){
        ReminderViewViewModel.model.prescriptions.append(Prescription( name: textFields[0].text!, type: TypeButton.type, quantity: textFields[1].text!, amount: textFields[2].text!, time: selectedTime, repeatedDays: repeatButton.checkmarkStates, reminderIsEnabled: mySwitch.isOn))
        
        
        navigationController?.popViewController(animated: true)
    }
    
    
    var switchIsOn: Bool = false
   @objc func switchStateDidChange(_ sender:UISwitch!)
   {
       if (sender.isOn == true){
           switchIsOn = true
//           let vc = DatePickerViewController()
//           present(vc, animated: true)
       }
       else{
           switchIsOn = false
           print("UISwitch state is now Off")
       }
   }
       
    private var repeatButton: DropDownButton = {
        let btn = DropDownButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.dataSource = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        btn.widthAnchor.constraint(equalToConstant: 125).isActive = true
        return btn
    }()
    
    func didSelect(_ index: Int) {
        print(index)
    }
    
    
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okayButton)
        present(alert, animated: true)
    }
    
    private func applyConstraints(){
        
        
        let detailsLabelConstraints = [
            detailsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
 
        ]
        let stackConstraints = [
            detailsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsStack.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 10),
            detailsStack.widthAnchor.constraint(equalToConstant: 360),
            detailsStack.heightAnchor.constraint(equalToConstant: 226)
            
        ]
        
        let NotificationsLabelConstraints = [
            NotificationsLabel.topAnchor.constraint(equalTo: detailsStack.bottomAnchor, constant: 22),
            NotificationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
 
        ]
        let NotificationsStackConstraints = [
            NotificationsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NotificationsStack.topAnchor.constraint(equalTo: NotificationsLabel.bottomAnchor, constant: 10),
            NotificationsStack.widthAnchor.constraint(equalToConstant: 360),
            NotificationsStack.heightAnchor.constraint(equalToConstant: 225)
        ]
        
        let continueBtnConstraints = [
            continueBtn.widthAnchor.constraint(equalToConstant: 177),
            continueBtn.heightAnchor.constraint(equalToConstant: 40),
            continueBtn.topAnchor.constraint(equalTo: NotificationsStack.bottomAnchor, constant: 20),
            continueBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(detailsLabelConstraints)
        NSLayoutConstraint.activate(stackConstraints)
        NSLayoutConstraint.activate(NotificationsLabelConstraints)
        NSLayoutConstraint.activate(NotificationsStackConstraints)
        NSLayoutConstraint.activate(continueBtnConstraints)

    }
    
    @objc private func didUpdateName() {
          viewModel.name =  textFields[0].text
          viewModel.validateReminder() //we check if the form is valid evry time anything in it is changed so we can enable the button
      }
    @objc private func didUpdateDose() {
          viewModel.dose = textFields[1].text
          viewModel.validateReminder() //we check if the form is valid evry time anything in it is changed so we can enable the button
      }
    @objc private func didUpdateAmount() {
          viewModel.amount = textFields[2].text
          viewModel.validateReminder() //we check if the form is valid evry time anything in it is changed so we can enable the button
      }
   
      
    
    private func bindViews(){
        
        textFields[0].addTarget(self, action: #selector(didUpdateName), for: .editingChanged)
        textFields[1].addTarget(self, action: #selector(didUpdateDose), for: .editingChanged)
        textFields[2].addTarget(self, action: #selector(didUpdateAmount), for: .editingChanged)

        viewModel.$isReminderValid.sink{ [weak self] validationState in                self?.continueBtn.isEnabled = validationState
            
        }
        .store(in: &subscriptions)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
  






    
    
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
