//
//  LoginController.swift
//  TinderSwipeCardsSwift
//
//  Created by Andrei Nevar on 31/10/15.
//  Copyright © 2015 gcweb. All rights reserved.
//

import UIKit
import Foundation



class LoginController: UIViewController {

    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func callApi(sender: UIButton) {
        
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
                var pricesTotal = [Int]()
                
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
    

}