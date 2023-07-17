//
//  AfterOneSecondTextField.swift
//  QRCodeSMBExample
//
//  Created by Apinun on 17/7/2566 BE.
//

import UIKit

// Credit by Reinier Melian from
// https://stackoverflow.com/questions/45527222/swift-run-code-1-second-after-a-user-stops-typing-into-a-textfield

@IBDesignable
class AfterOneSecondTextField: UITextField {

    @IBInspectable var delayValue : Double = 1.0
    var timer:Timer?

    var actionClosure : (()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(changedTextFieldValue), for: .editingChanged)
    }

    @objc func changedTextFieldValue(){
        timer?.invalidate()
        //setup timer
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(self.executeAction), userInfo: nil, repeats: false)
    }

    @objc func executeAction(){
        actionClosure?()
    }
}
