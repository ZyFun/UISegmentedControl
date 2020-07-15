//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Дмитрий Данилин on 08.07.2020.
//  Copyright © 2020 Дмитрий Данилин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDatePicker"]
    
    var selectedElement: String?
    
    @IBOutlet weak var segmenteControl: UISegmentedControl!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchLabel: UILabel!
    
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
        
        choiceUiElement()
        createToolbar()
    }
    
    func hiddenAllElement() {
        segmenteControl.isHidden = true
        textLabel.isHidden = true
        slider.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
    }
    
    func choiceUiElement() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        textField.inputView = elementPicker
        
        // Делаем кастомизацию
        elementPicker.backgroundColor = .brown
    }
    
    // Создаём тулбар над клавиатурой
    func createToolbar() {
        
        //Присваиваем значение тулбара константе
        let toolbar = UIToolbar()
        // Закрепляем размер тулбара
        toolbar.sizeToFit()
        
        // Конфигурируем кнопку в тулбаре
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        // Размещаем кнопку в тулбаре
        toolbar.setItems([doneButton], animated: true)
        // Позволяем пользователю взаимодействовать с тулбаром
        toolbar.isUserInteractionEnabled = true
        
        // При тапе на поле ввода, встраиваем тулбал над клавиатурой
        textField.inputAccessoryView = toolbar
        
        // Делаем кастомизацию
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
        }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
    @IBAction func switchAction(_ sender: UISwitch) {
        
        // Присваиваем значениям противоположное значение
        segmenteControl.isHidden = !segmenteControl.isHidden
        textLabel.isHidden = !textLabel.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isEditing
        doneButton.isHidden = !doneButton.isHidden
        datePicker.isHidden = !datePicker.isHidden
        
        if sender.isOn {
            switchLabel.text = "Отоброзить все элементы"
        } else {
            switchLabel.text = "Скрыть все элементы"
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Метод возвращает количество барабанов, которое будет использовано.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Возвращаем количество элементов в барабане в соответствии с количеством значений в массиве
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        uiElements.count
    }
    
    // Возвращаем значение элемента в барабане, присваивая индекс текущего выбранного элемента
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    // Метод позволяет работать с выбранным элементом
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hiddenAllElement()
            segmenteControl.isHidden = false
        case 1:
            hiddenAllElement()
            textLabel.isHidden = false
        case 2:
            hiddenAllElement()
            slider.isHidden = false
        case 3:
            hiddenAllElement()
        case 4:
            hiddenAllElement()
            doneButton.isHidden = false
        case 5:
            hiddenAllElement()
            datePicker.isHidden = false
        default:
            hiddenAllElement()
        }
    }
    
    
    // Функция позволяет работать со свойствами внутри UIPickerView
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerVIewLable = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerVIewLable = currentLabel
        } else {
            pickerVIewLable = UILabel()
        }
        
        pickerVIewLable.textColor = .white
        pickerVIewLable.textAlignment = .center
        pickerVIewLable.font = UIFont(name: "AppleSDGothicNeon-Regular", size: 23)
        pickerVIewLable.text = uiElements[row]
        
        return pickerVIewLable
    }
    
}
