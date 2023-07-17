//
//  AuthenticationViewViewModel.swift
//  colonCancer
//
//  Created by KH on 20/04/2023.
//

import Foundation
import Firebase
import Combine

final class AuthenticationViewViewModel: ObservableObject {

    @Published var email: String?
    @Published var password: String?
    @Published var phoneNumber: String?
    @Published var name: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var isEditFormValid: Bool = false
    @Published var user: User?
    @Published var subscriptions: Set<AnyCancellable> = []
    @Published var gender: String?
    @Published var age: String?
    @Published var height: String?
    @Published var weight: String?
    @Published var error: String?
    @Published var emailError: String?
    @Published var nameError: String?
    @Published var passwordError: String?
    @Published var phoneError: String?
    @Published var ageError: String?
    @Published var heightError: String? 
    @Published var weightError: String?
    @Published var genderError: String?

    
    
    func invalidnameMessage(_ text: String) -> String {
        if text.isEmpty {
            return "* this Field is required *"
        }
        return ""
        
    }
    
    func invalidEmailMessage(_ text: String) -> String {
        if text.isEmpty {
            return "* this Field is required *"
        } else if let _ = EmailAddress(rawValue: text){
            return ""
        } else {
            return "* invaled email adress *"
        }
    }
    
    func invalidPhoneMessage(_ text: String) -> String{
        let set = CharacterSet(charactersIn: text)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "* phone number must only contain digits *"
        } else if text.isEmpty  {
            return "* this Field is required *"
        } else if text.count != 11 {
            return "* phone number must be 11 Digits *"
        } else {
            return ""
        }
    }
    
    
    func invalidPasswordMessage(_ text: String) -> String{
        if text.isEmpty {
            return "* this Field is required *"
        } else if text.count < 8 {
            return "* password must be atleast 8 digits *"
        } else if !containsDigit(text){
            return "* password must contain at least 1 digit *"
        } else if !containsLowerCase(text){
            return "* password must contain at least 1 lowercase character *"
        } else if !containsUpperCase(text){
            return "* password must contain at least 1 uppercase character *"
        } else {
            return ""
        }
        
    }
    
    func invalidAgeMessage(_ text: String) -> String {
        let set = CharacterSet(charactersIn: text)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "* Age must only contain digits *"
        } else if text.isEmpty {
            return "* this Field is required *"
        } else if text.count > 2 {
           return "* your age must be less than 100 *"
        } else if text.count == 1 {
           return "* your age must be at least 10 *"
        } else {
            return ""
        }
    }
    
    func invalidMeasurmentMessage(_ text: String) -> String {
        let set = CharacterSet(charactersIn: text)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return " * Field must only contain digits *"
        } else if text.isEmpty {
            return "* this Field is required *"
        } else {
            return ""
        }
    }
    
    func containsDigit(_ value: String) -> Bool {
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    func containsLowerCase(_ value: String) -> Bool {
        let regularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    func containsUpperCase(_ value: String) -> Bool {
        let regularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    
    
    func validateAuthenticationLogInForm(){
        guard let email = email, let password = password else {
            isAuthenticationFormValid = false
            return
        }
        
        passwordError = invalidPasswordMessage(password)
        emailError = invalidEmailMessage(email)
        isAuthenticationFormValid = passwordError!.isEmpty &&
                                    emailError!.isEmpty
                                   
    
    }
    
    func validateAuthenticationsignUpForm(){
        guard let email = email,
              let password = password,
              let phoneNum = phoneNumber,
              let name = name else {
            isAuthenticationFormValid = false
                  print ("empty")
            return
        }
        passwordError = invalidPasswordMessage(password)
        emailError = invalidEmailMessage(email)
        nameError = invalidnameMessage(name)
        phoneError = invalidPhoneMessage(phoneNum)
        isAuthenticationFormValid = passwordError!.isEmpty &&
                                    emailError!.isEmpty    &&
                                    nameError!.isEmpty     &&
                                    phoneError!.isEmpty
    }
    
    func validateEditForm(){
        guard let email = email,
//              let password = password,
              let phoneNum = phoneNumber,
              let name = name,
              let gender = gender,
              let height = height,
              let weight = weight,
              let age = age else {
                  isEditFormValid = false
                  print ("empty")
            return
        }
//        passwordError = invalidPasswordMessage(password)
        emailError = invalidEmailMessage(email)
        nameError = invalidnameMessage(name)
        phoneError = invalidPhoneMessage(phoneNum)
        
        genderError = invalidnameMessage(gender)
        ageError = invalidAgeMessage(age)
        heightError = invalidMeasurmentMessage(height)
        weightError = invalidMeasurmentMessage(weight)

        isEditFormValid = // passwordError!.isEmpty &&
                                    emailError!.isEmpty    &&
                                    nameError!.isEmpty     &&
                                    phoneError!.isEmpty    &&
        ageError!.isEmpty     &&
        heightError!.isEmpty     &&
        weightError!.isEmpty     &&
        ageError!.isEmpty

        
    }
    
    func createUser() {
        guard let email = email, let password = password else {return}

        AuthManager.shared.registerUser(with: email, password: password)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion { //the completion that's returned either is failure or success, so instead of switch statement we just put " if case .failure " because we only want to check for that case
                    self?.error = error.localizedDescription
                }
                
            } receiveValue: { [weak self] user in
                self?.createRecord(for: user)
                self?.updateUserData()
            }
            .store(in: &subscriptions)
    }
    
    func createRecord(for user: User) {
        DatabaseManager.shared.collectionUsers(add: user)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print("Adding user record to database: \(state)")
            }
            .store(in: &subscriptions)
    }
    
    func logInUser() {
        guard let email = email, let password = password else {
            return
        }

        AuthManager.shared.logInUser(with: email, password: password)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
                
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    func updateUserData(){
        guard let name = name,
              let phoneNumber = phoneNumber,
              let id = Auth.auth().currentUser?.uid else { return }
        
        let updatedFields: [String: Any] = [
            "name": name,
            "phoneNumber": phoneNumber
        ]
        
        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: id)
        //when the function recieves the bool value it performs the closure
            .sink{ [weak self] Completion in
                if case .failure(let error) = Completion {
                    print(error.localizedDescription)
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print("Adding user data to database: \(state)")
            }
            .store(in: &subscriptions)
            
    }
    
 
    
}
