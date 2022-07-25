//
//  ColorPickerViewController.swift
//  ColorPicker2
//
//  Created by ALEKSEY SUSLOV on 25.07.2022.
//

import UIKit

class ColorPickerViewController: UIViewController {
    @IBOutlet var colorView: UIView!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var color: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITextFieldDelegate
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 15
        updateUI()
    }
    
    @IBAction func colorSliderValueChanged(_ sender: UISlider) {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        updateUI()
    }
    
    @IBAction func doneButtonPressed() {
        dismiss(animated: true)
    }
}

// MARK: - Private Methods

extension ColorPickerViewController {
    private func updateUI() {
        
        colorView.backgroundColor = color
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        redTextField.text = String(format: "%.2f", red)
        greenTextField.text = String(format: "%.2f", green)
        blueTextField.text = String(format: "%.2f", blue)
    }
}

// MARK: - UITextFieldDelegate

extension ColorPickerViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let floatValue = Float(newValue) else { return }
        
        switch textField {
        case redTextField:
            color = UIColor(red: CGFloat(floatValue),
                            green: CGFloat(greenSlider.value),
                            blue: CGFloat(blueSlider.value),
                            alpha: 1.0)
        case greenTextField:
            color = UIColor(red: CGFloat(redSlider.value),
                            green: CGFloat(floatValue),
                            blue: CGFloat(blueSlider.value),
                            alpha: 1.0)
        case blueTextField:
            color = UIColor(red: CGFloat(redSlider.value),
                            green: CGFloat(greenSlider.value),
                            blue: CGFloat(floatValue),
                            alpha: 1.0)
        default:
            return
        }
        
        updateUI()
    }
}
