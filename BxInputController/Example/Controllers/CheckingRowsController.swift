//
//  CheckingRowsController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 24/04/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class CheckingRowsController: BxInputController {
    
    private var nameRow = BxInputTextRow(title: "name value", placeholder: "should not be empty")
    private var surnameRow = BxInputTextRow(title: "surname value", placeholder: "can be empty")
    private var emailRow = BxInputFormattedTextRow(title: "email value", placeholder: "only corrected email")
    
    private var filledDateRow = BxInputDateRow(title: "filled date", value: Date().addingTimeInterval(300000))
    private var emptyDateRow = BxInputDateRow(title: "not empty value")//BxInputSelectorDateRow(title: "not empty value")
    
    private var dependencyRow = BxInputTextRow(title: "dependent")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isEstimatedContent = false
        
        self.sections = [
            BxInputSection(rows: [nameRow, surnameRow, emailRow]),
            BxInputSection(headerText: "Date", rows: [filledDateRow, emptyDateRow]),
            BxInputSection(headerText: "Dependent", rows: [dependencyRow])
        ]
        
        // for name
        let nameChecker = BxInputEmptyValueChecker<BxInputTextRow>(row: nameRow, placeholder: "Please put your name")
        nameChecker.planPriority = .always
        addChecker(nameChecker, for: nameRow)
        // for email
        addChecker(BxInputEmptyValueChecker<BxInputTextRow>(row: emailRow, placeholder: "Please put your email"), for: emailRow)
        addChecker(BxInputEmailChecker<BxInputTextRow>(row: emailRow, subtitle: "incorrect email"), for: emailRow)
        // for date
        let dateChecker = BxInputEmptyValueChecker<BxInputDateRow>(row: emptyDateRow, placeholder: "Please put date")
        dateChecker.planPriority = .always
        dateChecker.activePriority = .transitonRow
        addChecker(dateChecker, for: emptyDateRow)
        
        let dependencyChecker = BxInputDependencyRowsChecker(checkers: [nameChecker, dateChecker], subtitle: "Please put name and date")
        addChecker(dependencyChecker, for: dependencyRow)
        let equalChecker = BxInputEqualValuesChecker<BxInputTextRow>(row: dependencyRow, comparisonRow: nameRow, subtitle: "should be equal to \"name values\"")
        addChecker(equalChecker, for: dependencyRow)
    }
    
    
}
