//
//  ViewController.swift
//  kurs
//
//  Created by Sergey Yuryev on 14/01/15.
//  Copyright (c) 2015 syuryev. All rights reserved.
//

import UIKit
import ExchangeRateKit

class ViewController: UIViewController {

    // MARK - Outlets
    
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK - Private variables
    
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "icon_loader")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    // MARK - Variables
    
    var rates : [Dictionary<String, String>] = []
    var filteredRates : [Dictionary<String, String>] = []
    
    // MARK - Init
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK - Lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()

        addLoadingIndicator()
        
        showLoadingIndicator()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.loadRates()
            dispatch_async(dispatch_get_main_queue(), {
                self.hideLoadingIndicator()
                if let item = self.filteredRates.last {
                    self.exchangeRateLabel.text = item[kValue]
                }
            });
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK - Func

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
        println(filteredRates)
    }
    
    func addLoadingIndicator () {
        self.indicatorView.addSubview(activityIndicator)
    }
        
    func showLoadingIndicator () {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.loadingView.hidden = false
        })
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator () {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.loadingView.hidden = true
        })
        activityIndicator.stopAnimating()
    }
}

