//
//  CommonController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class CommonController: BxInputController {
    
    private var nameValue = BxInputTextRow(title: "name value")
    private var emailValue = BxInputTextRow(title: "email value", value: "")
    private var passwordValue = BxInputTextRow(title: "password value", placeholder: "last")
    
    private var filledDate = BxInputDateRow(title: "filled date", value: Date().addingTimeInterval(300000))
    private var emptyDate = BxInputDateRow(title: "empty value")
    private var lastDate = BxInputDateRow(title: "last value", placeholder: "last")
    
    private var variants : [BxInputVariantsItem] = [
        BxInputVariantsValue(id: "1", name: "first"),
        BxInputVariantsValue(id: "2", name: "second"),
        BxInputVariantsValue(id: "3", name: "last"),
        ]
    private var otherVariants : [BxInputVariantsItem] = [
        BxInputVariantsValue(id: "1", name: "value1"),
        BxInputVariantsValue(id: "2", name: "value2"),
        BxInputVariantsValue(id: "3", name: "value3"),
        BxInputVariantsValue(id: "4", name: "value4"),
        ]
    private var emptyVariants = BxInputVariantsRow(title: "empty variant", placeholder: "please select value")
    private var filledVariants = BxInputVariantsRow(title: "filled variant")
    private var otherVariantsRow = BxInputVariantsRow(title: "other variant")
    
    private var deselectedActionAlert = BxInputActionRow(title: "deselected alert", value: "Value is selected")
    private var actionAlert = BxInputActionRow(title: "action push", value: "Value is selected")
    private var pushAlert = BxInputActionRow(title: "action push", placeholder: "Please select")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyVariants.items = variants
        filledVariants.items = variants
        filledVariants.value = variants.first
        otherVariantsRow.items = otherVariants
        
        emailValue.keyboardType = .emailAddress
        passwordValue.isSecureTextEntry = true
        
        deselectedActionAlert.isAutomaticDeselect = false
        deselectedActionAlert.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            let alert = UIAlertController(title: "Action", message: "successful Selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {[weak this] (action) in
                alert.dismiss(animated: true, completion: nil)
                this?.deselectRow(row: actionRow)
                this?.updateRow(actionRow)
            }))
            this.present(alert, animated: true, completion: nil)
            actionRow.value = "changed"
        }
        actionAlert.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            let alert = UIAlertController(title: "Action", message: "successful Selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            this.present(alert, animated: true, completion: nil)
            actionRow.value = "alert showed"
            this.reloadRow(actionRow)
        }
        pushAlert.isAutomaticDeselect = false
        pushAlert.handler = {[weak self] (actionRow) -> Void in
            guard let this = self else {
                return
            }
            this.performSegue(withIdentifier: "push", sender: nil)
        }
        
        self.sections = [
            BxInputSection(rows: [nameValue, emailValue, passwordValue]),
            BxInputSection(rows: [filledDate, emptyDate, lastDate]),
            BxInputSection(rows: [emptyVariants, filledVariants, otherVariantsRow]),
            BxInputSection(rows: [deselectedActionAlert, actionAlert, pushAlert])
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

