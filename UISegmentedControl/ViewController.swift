//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Дмитрий Данилин on 08.07.2020.
//  Copyright © 2020 Дмитрий Данилин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmenteControl: UISegmentedControl!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Конфигурируем textLabel
        textLabel.isHidden = true
        textLabel.font = textLabel.font.withSize(35)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        
        //Добавляем новый сегмент
        segmenteControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
    }

    @IBAction func choiseSegmented(_ sender: UISegmentedControl) {
        
        textLabel.isHidden = false
        
        switch segmenteControl.selectedSegmentIndex {
        case 0:
            textLabel.text = "The first segment is selected"
            textLabel.textColor = .red
        case 1:
            textLabel.text = "The second segment is selected"
            textLabel.textColor = .blue
        case 2:
            textLabel.text = "The third segment is selected"
            textLabel.textColor = .purple
        default:
            print("Oops")
        }
    }
    
}

