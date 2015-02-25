//
//  InterfaceController.swift
//  kurs WatchKit Extension
//
//  Created by Sergey Yuryev on 30/01/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

import WatchKit
import Foundation
import ExchangeRateKit

class InterfaceController: WKInterfaceController {

    var rates : [Dictionary<String, String>] = []
    var filteredRates : [Dictionary<String, String>] = []
    
    @IBOutlet weak var rateLabel: WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.loadRates()
            dispatch_async(dispatch_get_main_queue(), {
                if let item = self.filteredRates.last {
                    self.rateLabel.setText(item[kValue])
                }
            });
        });
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadRates () {
        let ratesParser = ExchangeRateParser()
        let rates = ratesParser.getRates()
        
        filteredRates = rates.filter({ (item : Dictionary) -> Bool in
            if let numCode = item[kNumCode] {
                if numCode.toInt() == 840 {
                    return true
                }
            }
            return false;
        })
    }

}
