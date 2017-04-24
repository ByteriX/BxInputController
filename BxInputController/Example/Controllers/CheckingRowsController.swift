//
//  CheckingRowsController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 24/04/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class CheckingRowsController: BxInputController {
    
    private var nameValue = BxInputTextRow(title: "name value")
    private var surnameValue = BxInputTextRow(title: "surname value")
    private var emailValue = BxInputTextRow(title: "email value", value: "")
    
    private var filledDate = BxInputDateRow(title: "filled date", value: Date().addingTimeInterval(300000))
    private var emptyDate = BxInputDateRow(title: "not empty value")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isEstimatedContent = false
        
        self.sections = [
            BxInputSection(rows: [nameValue, surnameValue, emailValue]),
            BxInputSection(headerText: "", rows: [filledDate, emptyDate])
        ]
        
        addChecker(BxInputEmptyValueChecker(message: "Please put your name"), for: nameValue)
        addChecker(BxInputEmptyValueChecker(message: "Please put your email"), for: emailValue)
    }
    
    
}
