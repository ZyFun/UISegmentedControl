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
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
        
        // Локализуем выбор даты на русский
        datePicker.locale = Locale(identifier: "ru_RU")
    }

    @IBAction func choiseSegmented(_ sender: UISegmentedControl) {
        
        // Отображение значения в textLabel, в зависимости от того, какая кнопка нажата
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
        let backgraundColor = self.view.backgroundColor
        self.view.backgroundColor = backgraundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    @IBAction func doneButton(_ sender: UIButton) {
        
        // Проверяем поле на заполненность
        guard textField.text?.isEmpty == false else { return }
        
        //Проверяем формат введенных данных
        if let _ = Double(textField.text!) {
            // Конфигурируем сообщение об ошибке для константы
            let alert = UIAlertController(title: "Fail name", message: "Enter your name text format", preferredStyle: .alert)
            //Конфигурируем действие в окне ошибки
            let alertOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            // Присваиваем константе действие для исправления ошибки
            alert.addAction(alertOk)
            // Выводим сообщение об ошибке пользователю
            present(alert, animated: true, completion: nil)
        } else {
            textLabel.text = textField.text
            // Очищаем поле ввода, после удачного ввода текста
            textField.text = nil
        }
    }
    @IBAction func changeDate(_ sender: UIDatePicker) {
        
        // Создаём константу для выбора формата даты
        let dateFormatter = DateFormatter()
        
        // Локализуем под русский язык
        dateFormatter.locale = Locale(identifier: "ru_RU")
        // Задаём стиль отображения
        dateFormatter.dateStyle = .full
        
        // Приводим тип даты в строковое значение
        let dataValue = dateFormatter.string(from: sender.date)
        
        //Отображаем в лейбле указанную дату
        textLabel.text = dataValue
    }
}

