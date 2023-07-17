//
//  CustomButton.swift
//  QRCodeSMBExample
//
//  Created by Apinun on 17/7/2566 BE.
//

import UIKit

class CustomButton: UIButton {
    private var disabledBackgroundColor: UIColor?
    private var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                if let color = defaultBackgroundColor {
                    self.backgroundColor = color
                }
            }
            else {
                if let color = disabledBackgroundColor {
                    self.backgroundColor = color
                }
            }
        }
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        switch state {
        case .disabled:
            disabledBackgroundColor = color
        default:
            defaultBackgroundColor = color
        }
    }
}
