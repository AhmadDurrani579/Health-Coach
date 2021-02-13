//
//  RegistrationPresenter.swift
//  GARAGE SALE
//
//  Created by Ahmed Durrani on 24/01/2019.
//  Copyright © 2019 TeachEase Solution. All rights reserved.
//

import Foundation

protocol RegistrationDelegate{
    func showProgress()
    func hideProgress()
    func registrationDidSucceed()
    func registrationDidFailed(message: String)
}

class RegistrationPresenter  {
    var delegate: RegistrationDelegate
    
    init(delegate: RegistrationDelegate) {
        self.delegate = delegate
    }
    
    func signIn(email: String, password: String){
        if email.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationEmailEmpty)
        } else if !(UtilityHelper.isValidEmailAddress(email)) {
            self.delegate.registrationDidFailed(message: kValidationEmailInvalidInput)

        }
        else if password.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationPasswordEmpty)
        } else if password.count < kPasswordRequiredLength {
            self.delegate.registrationDidFailed(message: KValidationPassword)
        }
        else {
            self.delegate.registrationDidSucceed()
        }
        
        
    }
    
    func registerValidation(firstName : String , lastName: String, DOB : Bool ){

        if firstName.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationNameInput)
        }

        else if !isValidName(name: firstName) {
            self.delegate.registrationDidFailed(message: kValidationNameInputCharacter)
        }
            
       else  if lastName.isEmpty {
            self.delegate.registrationDidFailed(message: "Please Enter the last  name")
        }
        else if !isValidName(name: lastName) {
            self.delegate.registrationDidFailed(message: "Last Name must be alphabet characters.\n")
        }  else if DOB == false {
            self.delegate.registrationDidFailed(message: "Please select the Date Of Birth")
        }
        else {
            self.delegate.registrationDidSucceed()
        }


    }
    
    func SecondStepRegistration(email : String , password : String, confirmPass : String , isTerm : Bool){
        
        if email.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationEmailEmpty)
        } else if !(UtilityHelper.isValidEmailAddress(email)) {
            self.delegate.registrationDidFailed(message: kValidationEmailInvalidInput)
        }
        else if password.isEmpty {
            self.delegate.registrationDidFailed(message: "password should be at least 6 characters")
        } else if password.count < kPasswordRequiredLength {
            self.delegate.registrationDidFailed(message: "password should be at least 6 characters")
        } else if confirmPass.isEmpty {
            self.delegate.registrationDidFailed(message: "confirm password should be at least 6 characters")
        } else if confirmPass.count < kPasswordRequiredLength {
            self.delegate.registrationDidFailed(message: "confirm password should be at least 6 characters")
        } else if password != confirmPass {
            self.delegate.registrationDidFailed(message: KPasswordMismatch)
        } else if isTerm == false {
            self.delegate.registrationDidFailed(message: "please agree to the Terms & Conditions")
        }
        else {
            self.delegate.registrationDidSucceed()
        }
    }
    
    func healthGoal(txtDesc: String ){
        if txtDesc.isEmpty {
            self.delegate.registrationDidFailed(message: "Please share your concerns")
        }
        else if txtDesc.count < 5 {
            self.delegate.registrationDidFailed(message: "Text must be grater then 5 characters")
        }
        else {
            self.delegate.registrationDidSucceed()
        }
        
        
    }
    
    func forgotPasswordValidation(email: String ){
        if email.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationEmailEmpty)
        } else if !(UtilityHelper.isValidEmailAddress(email)) {
            self.delegate.registrationDidFailed(message: kValidationEmailInvalidInput)
        } else {
            self.delegate.registrationDidSucceed()
            
        }
    }

    func checkCode(code: String ){
        if code.isEmpty {
            self.delegate.registrationDidFailed(message: "Please enter the code")
        } else {
            self.delegate.registrationDidSucceed()
            
        }
    }
    
    func validationOnChangePassword(password: String , confirmPass : String){
        if password.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationPasswordEmpty)
        } else if password.count < kPasswordRequiredLength {
            self.delegate.registrationDidFailed(message: KValidationPassword)
        }
        else if confirmPass.isEmpty {
            self.delegate.registrationDidFailed(message: kValidationConfirmPasswordEmpty)
        } else if password != confirmPass  {
            self.delegate.registrationDidFailed(message: KPasswordMismatch)

        } else {
            self.delegate.registrationDidSucceed()

        }
    }
    




//
//    func IsAddProduct(productName : String , isCategorue: Bool, address : String ,  productDesc: String , price : String , sizeSelect : Bool  , colorSelect : Bool , condition : Bool , shipFrom : String){
//
//        if productName.isEmpty {
//            self.delegate.registrationDidFailed(message: kValidationProductInput)
//        }
//
//        else if !isValidName(name: productName) {
//            self.delegate.registrationDidFailed(message: kValidationProductNameInputCharacter)
//        }
//        else if isCategorue == false  {
//            self.delegate.registrationDidFailed(message: KCategoriesSelect)
//        }
//        else if address.isEmpty {
//            self.delegate.registrationDidFailed(message: "Address can't be blank")
//        }
//
//        else if productDesc.isEmpty {
//            self.delegate.registrationDidFailed(message: KPRoductDescription)
//        }
//
//        else if price.isEmpty {
//            self.delegate.registrationDidFailed(message: "Price can't be empty")
//        }
//
//        else if sizeSelect == false  {
//            self.delegate.registrationDidFailed(message: "Please select the size")
//        }
//
//        else if colorSelect == false  {
//            self.delegate.registrationDidFailed(message: "Please select the color")
//        }
//        else if condition == false  {
//            self.delegate.registrationDidFailed(message: "Please select the condition of product")
//        }
//
//       else if shipFrom.isEmpty {
//            self.delegate.registrationDidFailed(message: "Please enter the Ship Address")
//        }
//
//        else {
//            self.delegate.registrationDidSucceed()
//        }
//
//
//    }
//
//
//    func registerCardInfo(cardNum : String , cardHolderName: String, expiryDate : String ,  cvvNum: String){
//
//        if cardNum.isEmpty {
//            self.delegate.registrationDidFailed(message: kValidationCardNumInput)
//        }
//        else if cardHolderName.isEmpty {
//            self.delegate.registrationDidFailed(message: kValidationCardHolderNameInput)
//
//        }
//        else if !isValidName(name: cardHolderName) {
//            self.delegate.registrationDidFailed(message: kValidationCardHolderNameInputCharacter)
//        }
//        else if expiryDate.isEmpty {
//            self.delegate.registrationDidFailed(message: kValidationCardExpiryDate)
//
//        }
//        else if cvvNum.isEmpty  {
//            self.delegate.registrationDidFailed(message: kValidationCardCcvNum)
//
//        }
//        else {
//            self.delegate.registrationDidSucceed()
//        }
//
//
//    }
//
//
    func isValidName(name: String) -> Bool {
        let decimalCharacters = NSCharacterSet.decimalDigits
        let decimalRange = name.rangeOfCharacter(from: decimalCharacters, options: String.CompareOptions.numeric, range: nil)

        if decimalRange != nil {
            return false
        }
        return true
    }
//    func forgotPasswordValidation(email: String ){
//        if email.isEmpty {
//            self.delegate.registrationDidFailed(message: kValidationEmailEmpty)
//        } else if !(UtilityHelper.isValidEmailAddress(email)) {
//            self.delegate.registrationDidFailed(message: kValidationEmailInvalidInput)
//        } else {
//            self.delegate.registrationDidSucceed()
//
//        }
//    }
//
//    func validationOnChangePassword(password: String , confirmPass : String){
//        if password.isEmpty {
//            self.delegate.registrationDidFailed(message: kValidationPasswordEmpty)
//        }
//        else if confirmPass.isEmpty {
//            self.delegate.registrationDidFailed(message: kValidationConfirmPasswordEmpty)
//        } else if password != confirmPass  {
//            self.delegate.registrationDidFailed(message: KPasswordMismatch)
//
//        } else {
//            self.delegate.registrationDidSucceed()
//
//        }
//    }
//
//    func validationForUploadingIdentification(idNum: String , isImageSelect : Bool){
//        if idNum.isEmpty {
//            self.delegate.registrationDidFailed(message: KIDNumberValidat)
//        }
//        else if isImageSelect == false {
//            self.delegate.registrationDidFailed(message: KIMAGeSELECT)
//        }
//
//        else {
//            self.delegate.registrationDidSucceed()
//        }
//    }
    
}

//extension String {
//    var isPhoneNumber: Bool {
//        do {
//            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
//            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
//            if let res = matches.first {
//                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.characters.count
//            } else {
//                return false
//            }
//        } catch {
//            return false
//        }
//    }
//}
