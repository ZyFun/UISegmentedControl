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
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //устанавливаем значение слайдера по умолчанию
        slider.value = 1
        
        // Конфигурируем textLabel
        textLabel.text = String(slider.value)
        textLabel.font = textLabel.font.withSize(35)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        
        //Добавляем новый сегмент контроллера
        segmenteControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        // Конфигурируем слайдер
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
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
    
    @IBAction func sliderAction(_ sender: UISlider) {
        textLabel.text = String(sender.value)
        
        // Меняем прозрачность с помощью слайдера
        let backgrndColor = self.view.backgroundColor
        self.view.backgroundColor = backgrndColor?.withAlphaComponent(CGFloat(sender.value))
    }
}

