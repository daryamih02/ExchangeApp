//
//  ViewController.swift
//  ExchangeApp
//

import UIKit

class ViewController: UIViewController  {
    

    @IBOutlet weak var FromLabel: UILabel!
    
    @IBOutlet weak var ToLabel: UILabel!
    
    @IBOutlet weak var DollarSign: UIImageView!
    
    @IBOutlet weak var ArrowSign: UIImageView!
    
    @IBOutlet weak var FromPickerView: UIPickerView!
    
    @IBOutlet weak var ToPickerView: UIPickerView!
    
    @IBOutlet weak var ValueTextField: UITextField!
    
    @IBOutlet weak var ValueLabel: UILabel!
    
    @IBAction func changeButton(_ sender: Any) {
            API.getRate(from: money[FromPickerView.selectedRow(inComponent: 0)], to: money[ToPickerView.selectedRow(inComponent: 0)]) { [weak self] (result) in
                switch result {
                case .success(let rate):
                    guard let inputString = self?.ValueTextField.text, let inputInt = Int(inputString) else {
                        return
                    }
                    let value = Double(round(100 * (rate * Float(inputInt))) / 100)
                    self?.ValueLabel.text = String(format:  "%.2f", value)
                    self?.view.layoutIfNeeded()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    let money = ["CAD","HKD","ISK","PHP","DKK","HUF","CZK","AUD","RON","SEK","IDR","INR","BRL","RUB","HRK","JPY","THB","CHF","SGD","PLN","BGN","TRY","CNY","NOK","NZD","ZAR","USD","MXN","ILS","GBP","KRW","MYR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        FromPickerView.selectRow(13, inComponent: 0, animated: true)
        ToPickerView.selectRow(26, inComponent: 0, animated: true)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        DispatchQueue.main.async {[weak self] in
            self?.view.endEditing(true)
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return money[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return money.count
    }
}


