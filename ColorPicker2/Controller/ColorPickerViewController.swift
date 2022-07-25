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
        setViewColor(red: redSlider.value,
                 green: greenSlider.value,
                 blue: blueSlider.value)
        
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
        
        let (red, green, blue) = getViewColor()
        
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
        
        redTextField.text = String(format: "%.2f", red)
        greenTextField.text = String(format: "%.2f", green)
        blueTextField.text = String(format: "%.2f", blue)
    }
    
    private func getViewColor() -> (red: Float, green: Float, blue: Float) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return (Float(red), Float(green), Float(blue))
    }
    
    private func setViewColor(red: Float, green: Float, blue: Float) {
        color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
}

// MARK: - UITextFieldDelegate

extension ColorPickerViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let colorValue = Float(newValue) else { return }
        
        var (red, green, blue) = getViewColor()
        
        switch textField {
        case redTextField:
            red = colorValue
        case greenTextField:
            green = colorValue
        case blueTextField:
            blue = colorValue
        default:
            return
        }
        
        setViewColor(red: red, green: green, blue: blue)
        
        updateUI()
    }
}
