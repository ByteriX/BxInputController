//
//  CommonController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class ActionItem: BxInputString {
    
    var name: String
    
    init (name: String) {
        self.name = name
    }
    
    var stringValue : String? {
        return name
    }
}

class CommonController: BxInputController {
    
    private var nameValue = BxInputTextRow(title: "name value")
    private var emailValue = BxInputTextRow(title: "email value", value: "")
    private var passwordValue = BxInputTextRow(title: "password value", placeholder: "last")
    private var disabledValue = BxInputTextRow(title: "disabled value", placeholder: "didn't selected")
    
    private var filledDate = BxInputDateRow(title: "filled date", value: Date().addingTimeInterval(300000))
    private var emptyDate = BxInputDateRow(title: "empty value")
    private var lastDate = BxInputDateRow(title: "last value", placeholder: "last")
    
    private var variants : [BxInputVariantsItem] = [
        BxInputVariantsItem(id: "1", name: "first"),
        BxInputVariantsItem(id: "2", name: "second"),
        BxInputVariantsItem(id: "3", name: "last"),
        ]
    private var otherVariants : [BxInputVariantsItem] = [
        BxInputVariantsItem(id: "1", name: "value1"),
        BxInputVariantsItem(id: "2", name: "value2"),
        BxInputVariantsItem(id: "3", name: "value3"),
        BxInputVariantsItem(id: "4", name: "value4"),
        ]
    private var emptyVariants = BxInputVariantsRow<BxInputVariantsItem>(title: "empty variant", placeholder: "please select value")
    private var filledVariants = BxInputVariantsRow<BxInputVariantsItem>(title: "filled variant")
    private var otherVariantsRow = BxInputVariantsRow<BxInputVariantsItem>(title: "other variant")
    
    private var deselectedActionAlert = BxInputActionStringRow(title: "deselected alert", value: "Value is selected")
    private var actionAlert = BxInputActionCustomRow<ActionItem>(title: "action push", value: ActionItem(name: "Value is selected"))
    private var pushAlert = BxInputActionCustomRow<ActionItem>(title: "action push", placeholder: "Please select")
    private var disabledAction = BxInputActionCustomRow<ActionItem>(title: "disabled action", placeholder: "Not touchable")
    private var insertSectionAction = BxInputActionCustomRow<ActionItem>(title: "insert action")
    private var selectSectionAction = BxInputActionStringRow(title: "select email", value: "")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isEstimatedContent = false
        
        emptyVariants.items = variants
        filledVariants.items = variants
        filledVariants.value = variants.first
        otherVariantsRow.items = otherVariants
        
        emailValue.keyboardType = .emailAddress
        passwordValue.isSecureTextEntry = true
        disabledValue.isEnabled = false
        
        deselectedActionAlert.handler = {[weak self, weak deselectedActionAlert] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            let alert = UIAlertController(title: "Action", message: "successful Selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {[weak this] (action) in
                alert.dismiss(animated: true, completion: nil)
                this?.deselectRow(actionRow)
                this?.updateRow(actionRow)
            }))
            this.present(alert, animated: true, completion: nil)
            deselectedActionAlert?.value = "changed"
        }
        actionAlert.isImmediatelyDeselect = true
        actionAlert.handler = {[weak self, weak actionAlert] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            let alert = UIAlertController(title: "Action", message: "successful Selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            this.present(alert, animated: true, completion: nil)
            actionAlert?.value = ActionItem(name: "alert showed")
            this.reloadRow(actionRow)
        }
        pushAlert.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            this.performSegue(withIdentifier: "push", sender: nil)
        }
        disabledAction.isEnabled = false
        insertSectionAction.isImmediatelyDeselect = true
        insertSectionAction.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            this.addSection(BxInputSection(headerText: " ", rows: [BxInputTextRow(title: "just value"), BxInputTextRow(title: "yet value")]))
        }
        selectSectionAction.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            this.selectRow(this.emailValue)
        }
        
        self.sections = [
            BxInputSection(rows: [nameValue, emailValue, passwordValue, disabledValue]),
            BxInputSection(headerText: "", rows: [filledDate, emptyDate, lastDate]),
            BxInputSection(headerText: "Section", rows: [emptyVariants, filledVariants, otherVariantsRow], footerText: "Footer"),
            BxInputSection(rows: [deselectedActionAlert, actionAlert, pushAlert, disabledAction, insertSectionAction, selectSectionAction])
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

