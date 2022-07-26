//
//  ColorScreenViewController.swift
//  ColorPicker2
//
//  Created by ALEKSEY SUSLOV on 25.07.2022.
//

import UIKit

protocol ColorPickerViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class ColorScreenViewController: UIViewController {
    
    var color: UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorPickerVC = segue.destination as? ColorPickerViewController else { return }
        colorPickerVC.color = color
        colorPickerVC.delegate = self
    }
}

// MARK: - ColorPickerViewControllerDelegate

extension ColorScreenViewController: ColorPickerViewControllerDelegate {
    func setColor(_ color: UIColor) {
        self.color = color
        view.backgroundColor = color
    }
}

