//
//  ColorScreenViewController.swift
//  ColorPicker2
//
//  Created by ALEKSEY SUSLOV on 25.07.2022.
//

import UIKit

class ColorScreenViewController: UIViewController {
    
    var color: UIColor = #colorLiteral(red: 0.862745098, green: 0.8431372549, blue: 0.7882352941, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorPickerVC = segue.destination as? ColorPickerViewController else { return }
        colorPickerVC.color = color
    }
}

