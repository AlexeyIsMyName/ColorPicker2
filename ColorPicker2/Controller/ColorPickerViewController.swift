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
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = color
    }
    
    @IBAction func doneButtonPressed() {
        dismiss(animated: true)
    }
}
