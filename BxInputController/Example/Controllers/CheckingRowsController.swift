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
    private var passwordRow = BxInputTextRow(title: "password value", placeholder: "empty is incorrected")
    
    internal let genderRow = BxInputSelectorVariantsRow<BxInputVariantsItem>(title: "gender")
    
    private var filledDateRow = BxInputDateRow(title: "filled date", value: Date().addingTimeInterval(300000))
    private var emptyDateRow = BxInputDateRow(title: "not empty value")
    private var emptySelectorDateRow = BxInputSelectorDateRow(title: "not empty date")
    private var testDateRow = BxInputDateRow(title: "should filled")
    
    private var dependencyRow = BxInputTextRow(title: "dependent")
    
    private var textRow = BxInputTextRow(title: "text value", placeholder: "reuseble test")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isEstimatedContent = false

        genderRow.items = [
            BxInputVariantsItem(id: "none", name: "none"),
            BxInputVariantsItem(id: "male", name: "male"),
            BxInputVariantsItem(id: "famale", name: "famale")]
        
        self.sections = [
            BxInputSection(rows: [nameRow, surnameRow, emailRow, passwordRow, genderRow]),
            BxInputSection(headerText: "Date", rows: [filledDateRow, emptyDateRow, emptySelectorDateRow, testDateRow]),
            BxInputSection(headerText: "Dependent", rows: [dependencyRow]),
            BxInputSection(headerText: "Reusable section", rows: [textRow])
        ]
        
        // for name
        let nameChecker = BxInputEmptyValueChecker<BxInputTextRow>(row: nameRow, placeholder: "Please put your name")
        nameChecker.planPriority = .always
        addChecker(nameChecker, for: nameRow)
        // for email
        addChecker(BxInputEmptyValueChecker<BxInputTextRow>(row: emailRow), for: emailRow)
        addChecker(BxInputEmailChecker<BxInputTextRow>(row: emailRow, subtitle: "incorrect email"), for: emailRow)
        // for password
        passwordRow.textSettings.isSecureTextEntry = true
        addChecker(BxInputEmptyValueChecker<BxInputTextRow>(row: passwordRow, placeholder: "Please put the password"), for: passwordRow)
        // for date
        let dateChecker = BxInputEmptyValueChecker<BxInputDateRow>(row: emptyDateRow, placeholder: "Please put date")
        dateChecker.planPriority = .always
        dateChecker.activePriority = .transitonRow
        addChecker(dateChecker, for: emptyDateRow)
        addChecker(BxInputEmptyValueChecker<BxInputSelectorDateRow>(row: emptySelectorDateRow, placeholder: "Please put the date"), for: emptySelectorDateRow)
        // for variant
        addChecker(BxInputBlockChecker(row: genderRow , handler: {[weak self] (_) -> Bool in
            guard let result = self?.genderRow.value?.id else {
                return false
            }
            return result != "none"
        }), for: genderRow)
        // for test date
        let testChecker = BxInputEmptyValueChecker<BxInputDateRow>(row: testDateRow, placeholder: "You should put date")
        addChecker(testChecker, for: testDateRow)
        
        let dependencyChecker = BxInputDependencyRowsChecker(checkers: [nameChecker, dateChecker], subtitle: "Please put name and date")
        addChecker(dependencyChecker, for: dependencyRow)
        let equalChecker = BxInputEqualValuesChecker<BxInputTextRow>(row: dependencyRow, comparisonRow: nameRow, subtitle: "should be equal to \"name values\"")
        addChecker(equalChecker, for: dependencyRow)
        
        addChecker(BxInputEmptyValueChecker<BxInputTextRow>(row: textRow, placeholder: "Please put text for testing reusable"), for: textRow)
    }
    
    @IBAction func checkClick(_ sender: Any) {
        if checkRow(testDateRow, willSelect: true) {
            checkRow(emptySelectorDateRow, willSelect: true)
        }
    }
    
}
