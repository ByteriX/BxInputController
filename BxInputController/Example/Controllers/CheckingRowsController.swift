//
//  CheckingRowsController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 24/04/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class CheckingRowsController: BxInputController {
    
    private var nameValue = BxInputTextRow(title: "name value", placeholder: "should not be empty")
    private var surnameValue = BxInputTextRow(title: "surname value", placeholder: "can be empty")
    private var emailValue = BxInputTextRow(title: "email value", placeholder: "only corrected email")
    
    private var filledDate = BxInputDateRow(title: "filled date", value: Date().addingTimeInterval(300000))
    private var emptyDate = BxInputDateRow(title: "not empty value")//BxInputSelectorDateRow(title: "not empty value")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isEstimatedContent = false
        
        self.sections = [
            BxInputSection(rows: [nameValue, surnameValue, emailValue]),
            BxInputSection(headerText: "", rows: [filledDate, emptyDate])
        ]
        
        // for name
        addChecker(BxInputEmptyValueChecker(message: "Please put your name"), for: nameValue)
        // for email
        addChecker(BxInputEmptyValueChecker(message: "Please put your email"), for: emailValue)
        addChecker(BxInputEmailChecker(message: "Please put your email"), for: emailValue)
        // for date
        let dateChecker = BxInputEmptyValueChecker(message: "Please put date")
        dateChecker.planPriority = .immediately
        dateChecker.activePriority = .transitonValue
        addChecker(dateChecker, for: emptyDate)
    }
    
    
}
