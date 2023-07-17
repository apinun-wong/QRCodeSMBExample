//
//  ViewController.swift
//  QRCodeSMBExample
//
//  Created by Apinun on 17/7/2566 BE.
//

import UIKit
import QRCode

class ViewController: UIViewController {
    @IBOutlet weak var titleTextField: AfterOneSecondTextField!
    @IBOutlet weak var shareButton: CustomButton!
    @IBOutlet weak var titleImageView: UIImageView!
    var qrCodeImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleImageView.layer.borderColor = UIColor.systemCyan.cgColor
        titleImageView.layer.borderWidth = 2.0
        shareButton.setBackgroundColor(.systemBlue, for: .normal)
        shareButton.setBackgroundColor(.lightGray, for: .disabled)
        shareButton.isEnabled = false
        setUpTextField()
        hideKeyboardWhenTappedAround()
    }
    private func setUpTextField() {
        titleTextField.actionClosure = { [weak self] in
            guard let self else { return }
            self.textFieldDidChange(self.titleTextField)
        }
    }
    @IBAction func shareAction(_ sender: Any) {
        let text =  """
                    This is demo app from SMB text.
                    You can see this demo at thist link.
                    https://github.com/apinun-wong/QRCodeSMBExample
                    """
        self.shareImageAndText(image: qrCodeImage, message: text)
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        shareButton.isEnabled = !(textfield.text?.isEmpty ?? true)
        guard let text = textfield.text, !text.isEmpty else { return }
        let doc = QRCode.Document(utf8String: text, errorCorrection: .high)
        let logoImage = UIImage(named: "img_logo")
        if let cgImage = logoImage?.cgImage {
            let path = CGPath(ellipseIn: CGRect(x: 0.375, y: 0.375, width: 0.25, height: 0.25), transform: nil)
            doc.logoTemplate = QRCode.LogoTemplate(image: cgImage, path: path, inset: 8)
        }
        
        //style
        doc.design.style.background = QRCode.FillStyle.Solid(UIColor.white.cgColor)
        doc.design.shape.eye = QRCode.EyeShape.RoundedPointingIn()
        doc.design.style.eye = QRCode.FillStyle.Solid(0.0, 0.424, 0.900)
        doc.design.style.pupil = QRCode.FillStyle.Solid(1.0, 0.1, 0.4)
        doc.design.style.onPixels = QRCode.FillStyle.Solid(0.0, 0.424, 0.900)
        
        let sizeImageView = titleImageView.bounds.size
        let originalSize = CGSize(width: sizeImageView.width * 2.0, height: sizeImageView.height * 2.0)
        if let generated = doc.cgImage(originalSize) {
            qrCodeImage = UIImage(cgImage: generated)
            titleImageView.image = UIImage(cgImage: generated)
        } else {
            qrCodeImage = nil
        }
    }
}

