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
        
            
            let url = NSURL(string: "http://opendutchhackathon.w3ibm.mybluemix.net/ams/bcn/201510/201511/100-2000/2")
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data: NSData?,  response: NSURLResponse?, error: NSError?) -> Void in
                
                if let d = data {
                    print(d)
                }
                
                
//                let err: NSError?
                
                
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    print(jsonResult)
                    
                    
                } catch let error as NSError {
                    print(error)
                }
                
                
                
//                if err != nil {
//                    // If there is an error parsing JSON, print it to the console
//                    print("JSON Error \(err!.localizedDescription)")
//                }
                
                
                
                
                
                
                
                
//                let json = JSONValue(jsonResult)
//                let count: Int? = json["data"].array?.count
//                print("found \(count!) challenges")
//    
//                if let ct = count {
//                    for index in 0...ct-1 {
//                        // println(json["data"][index]["challengeName"].string!)
//                        if let name = json["data"][index]["challengeName"].string {
//                            println(name)
//                        }
//                        
//                    }
//                }
                
            }
            
            task.resume()
            
        
    
    
    }
    

}