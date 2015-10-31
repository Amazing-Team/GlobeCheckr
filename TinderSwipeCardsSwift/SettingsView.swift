//
//  SettingsView.swift
//  TinderSwipeCardsSwift
//
//  Created by Andrei Nevar on 31/10/15.
//  Copyright © 2015 gcweb. All rights reserved.
//

import UIKit
import Foundation

class SettingsView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBAction func tempSlider(sender: UISlider) {
        let currentValue = Int(sender.value)
        var plus = ""
        if(currentValue > 0){plus = "+"} else {plus = ""}
        temperatureLabel.text = "\(plus)\(currentValue)°C"

    }

    
    @IBAction func costSlider(sender: UISlider) {
        let currentValue = Int(sender.value)
        
        costLabel.text = "\(currentValue)€"
        if(currentValue == 5000){costLabel.text = "∞"}
    }
    
    @IBOutlet weak var tempSlider: UISlider!
    @IBOutlet weak var costSlider: UISlider!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var justPicker: UIPickerView!
    @IBOutlet weak var justPicker2: UIPickerView!
    
//    @IBOutlet var txtTest : UITextField = nil
    @IBOutlet weak var txtTest: UITextField! = nil
    
    let monthsData = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct", "Nov", "Dec"]
    var daysArray = [Int] ()
    var yearsArray = [Int] ()
    
    func populateArray (start:Int, end:Int) -> [Int]{
        var daysData = [Int]()
        for index in start...end {
            daysData.append(index)
        }
        return daysData
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        daysArray = populateArray (1, end: 31)
        yearsArray = populateArray (2015, end: 2040)
        

        justPicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        justPicker.dataSource = self
        justPicker.delegate = self
        
        
        justPicker2.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        justPicker2.dataSource = self
        justPicker2.delegate = self

        
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return daysArray.count
        }
        else if (component == 1){
            return monthsData.count
        }
        else if (component == 2){
            return yearsArray.count
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        var titleData: String = ""
        if (component == 0) {
            titleData = String(daysArray[row])
        }
        else if (component == 1){
            titleData = monthsData[row]
        }
        else if (component == 2){
            titleData = String(yearsArray[row])
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
}
