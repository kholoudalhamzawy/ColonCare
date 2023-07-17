//
//  ReminderViewViewModel.swift
//  colonCancer
//
//  Created by KH on 25/05/2023.
//

import Combine
import UIKit


final class ReminderViewViewModel: ObservableObject {
    
    static var model = ReminderViewViewModel()
    @Published var isValidToRemind: Bool = false
    @Published var prescriptions: [Prescription] = []
    @Published var error: String?
    @Published var name: String?
    @Published var type: String?
    @Published var dose: String?
    @Published var modelSelcetedDate = CalendarHelper.getCurrentDate()
    @Published var amount: String?
    @Published var time: String?
    @Published var repeatedDays: [String]?
    @Published var reminderIsEnabled: Bool?
    @Published var isReminderValid: Bool = false
    @Published var nameError: String?
    @Published var amountError: String?
    @Published var doseError: String?


    func invalidNameMessage(_ text: String) -> String {
        if text.isEmpty {
            return "* this Field is required *"
        } else {
            return ""
        }
    }
    
    
    func invalidDoseMessage(_ text: String) -> String{
        let set = CharacterSet(charactersIn: text)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "* field must only contain digits *"
        } else if text.isEmpty  {
            return "* this Field is required *"
        } else {
            return ""
        }
    }
    
    func validateReminder(){
        guard let name = name, let amount = amount, let dose = dose else {
            isReminderValid = false
            return
        }
        
        nameError = invalidNameMessage(name)
        amountError = invalidDoseMessage(amount)
        doseError = invalidDoseMessage(dose)
        
        isReminderValid = nameError!.isEmpty &&
        amountError!.isEmpty &&
        doseError!.isEmpty
    
    }
    
    
    func eventsForDate(date: Date) -> [(Prescription, Bool)]
    {
        var prescriptions = [(Prescription, Bool)]() //returns if the prescription is checked or not
        for prescription in ReminderViewViewModel.model.prescriptions{
            for Prescdate in prescription.datesOfDays{
                print("the prescDate is \(Prescdate)")
                print("the day is \(date)")
                if(Calendar.current.isDate(Prescdate.date, inSameDayAs:date))
                {
                    print("Did Append")
                    prescriptions.append((prescription, Prescdate.isChecked))
                }
            }
        }
        
        prescriptions.sort { $0.0.time < $1.0.time }

       
        return prescriptions
    }
    
    func isCellToggled(PrescreptionId: String)-> Bool {
        for prescription in 0..<ReminderViewViewModel.model.prescriptions.count {
            for prescreptionDate in 0..<ReminderViewViewModel.model.prescriptions[prescription].datesOfDays.count {
                if(Calendar.current.isDate( ReminderViewViewModel.model.prescriptions[prescription].datesOfDays[prescreptionDate].date , inSameDayAs: ReminderViewViewModel.model.modelSelcetedDate) && ReminderViewViewModel.model.prescriptions[prescription].id == PrescreptionId)
                {
                  
                    return ReminderViewViewModel.model.prescriptions[prescription].datesOfDays[prescreptionDate].isChecked
                    
                }
            }
        }
        return false
    }
    
    func toggleCheck(PrescreptionId: String) {
        for prescription in 0..<ReminderViewViewModel.model.prescriptions.count {
            for prescreptionDate in 0..<ReminderViewViewModel.model.prescriptions[prescription].datesOfDays.count {
                if(Calendar.current.isDate( ReminderViewViewModel.model.prescriptions[prescription].datesOfDays[prescreptionDate].date , inSameDayAs: ReminderViewViewModel.model.modelSelcetedDate) && ReminderViewViewModel.model.prescriptions[prescription].id == PrescreptionId)
                {
                    ReminderViewViewModel.model.prescriptions[prescription].datesOfDays[prescreptionDate].isChecked.toggle()

                }
            }
        }
    }
   
    
    
    
//    func invalidFieldMessage(_ text: String) -> String {
//
//        if text.isEmpty {
//            return "* this Field is required *"
//        }
//        return ""
//    }
//
//
//    func validateAuthenticationsignUpForm(){
//        guard let email = email,
//              let name = name else {
//            isAuthenticationFormValid = false
//            return
//        }
//        error = invalidFieldMessage(password)
//
//        isAuthenticationFormValid = error?.isEmpty
//    }
    
    
    
}
