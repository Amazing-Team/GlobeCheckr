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
    
    @IBAction func callAPIandGo(sender: UIButton) {
        /* API Structure
        // Origin airport based from user's location (e.x. ams,bcn)
        // Date of departure yyyyMMdd(e.x 20150606)
        // Date of return yyyyMMdd(e.x 20150606)
        // Price range (e.x. 50-100)
        // Number of people
        */
        let url = NSURL(string: "http://opendutchhackathon.w3ibm.mybluemix.net/ams/20151101/20151110/100-2000/2")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data: NSData?,  response: NSURLResponse?, error: NSError?) -> Void in
            
            //Table with the destiantions available
            var destinations = [String]()
            
            //Table with the prices of the aller
            var pricesAller = [Int]()
            
            //Table with the prices of the return
            var pricesRetur = [Int]()
            
            //Table with the total prices of the trips
            //var pricesTotal = [Int]()
            
            //Table with the departure times of the aller
            var departureTimeAller = [String]()
            
            //Table with the arrival times of the aller
            var arrivalTimeAller = [String]()
            
            //Table with the departure times of the return
            var departureTimeRetur = [String]()
            
            //Table with the arrival times of the return
            var arrivalTimeRetur = [String]()
            
            do {
                
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
                
                destinations = jsonResult!.valueForKeyPath("flightOffer.inboundFlight.departureAirport.locationCode") as! [String];
                
                pricesAller = jsonResult!.valueForKeyPath("flightOffer.inboundFlight.pricingInfo.totalPriceAllPassengers") as! [Int];
                
                pricesRetur = jsonResult!.valueForKeyPath("flightOffer.outboundFlight.pricingInfo.totalPriceAllPassengers") as! [Int];
                
                departureTimeAller = jsonResult!.valueForKeyPath("flightOffer.inboundFlight.departureDateTime") as! [String];
                
                arrivalTimeAller = jsonResult!.valueForKeyPath("flightOffer.inboundFlight.arrivalDateTime") as! [String];
                
                departureTimeRetur = jsonResult!.valueForKeyPath("flightOffer.outboundFlight.departureDateTime") as! [String];
                
                arrivalTimeRetur = jsonResult!.valueForKeyPath("flightOffer.outboundFlight.arrivalDateTime") as! [String];
                
                
                print(destinations)
                
                
                for (var i = 0; i < pricesAller.count; i++ ){
                    pricesTotal.append(pricesAller[i] + pricesRetur[i])
                }
                
                print(pricesTotal)
                
                print(departureTimeAller)
                print(arrivalTimeAller)
                print(departureTimeRetur)
                print(arrivalTimeRetur)
                
            } catch let error as NSError {
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    
    
    
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
