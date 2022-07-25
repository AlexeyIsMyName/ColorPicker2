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
    var delegate: ColorPickerViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITextFieldDelegate
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setUpKeyboard(for: redTextField, greenTextField, blueTextField)
        
        colorView.layer.cornerRadius = 15
        updateUI()
    }
    
    @IBAction func colorSliderValueChanged(_ sender: UISlider) {
        view.endEditing(true)
        
        setColor(red: redSlider.value,
                 green: greenSlider.value,
                 blue: blueSlider.value)
        
        updateUI()
    }
    
    @IBAction func doneButtonPressed() {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
        
        delegate.setColor(color)
        
        dismiss(animated: true)
    }
}

// MARK: - Private Methods

extension ColorPickerViewController {
    private func updateUI() {
        
        colorView.backgroundColor = color
        
        let (red, green, blue) = getColor()
        
//        redSlider.value = red
//        greenSlider.value = green
//        blueSlider.value = blue
        
        redSlider.setValue(red, animated: true)
        greenSlider.setValue(green, animated: true)
        blueSlider.setValue(blue, animated: true)
        
        redTextField.text = String(format: "%.2f", red)
        greenTextField.text = String(format: "%.2f", green)
        blueTextField.text = String(format: "%.2f", blue)
    }
    
    private func getColor() -> (red: Float, green: Float, blue: Float) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return (Float(red), Float(green), Float(blue))
    }
    
    private func setColor(red: Float, green: Float, blue: Float) {
        color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
}

// MARK: - Setting up keyBoard for text Fields
extension ColorPickerViewController {
    private func setUpKeyboard(for textFields: UITextField...) {
        for textField in textFields {
            
            let toolBar = UIToolbar()
            textField.inputAccessoryView = toolBar
            toolBar.sizeToFit()
            
            let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                    target: self,
                                                    action: #selector(done))
            
            toolBar.items = [.flexibleSpace(), doneBarButtonItem]
        }
    }
    
    @objc private func done() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension ColorPickerViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else {
            updateUI()
            return
        }
        
        guard let colorValue = Float(newValue) else {
            updateUI()
            return
        }
        
        var (red, green, blue) = getColor()
        
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
        
        setColor(red: red, green: green, blue: blue)
        
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
