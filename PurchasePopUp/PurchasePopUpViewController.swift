//
//  PurchasePopUpViewController.swift
//  PurchasePopUp
//
//  Created by Matan Cohen on 2/27/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import Foundation
import UIKit

internal class PurchasePopUpViewController: UIViewController {
    
    weak var purchasePopUpPresentor: PurchasePopUpPresentor?
    
    internal convenience init(purchasePopUpPresentor: PurchasePopUpPresentor) {
        self.init(nibName: nil, bundle: nil)
        self.purchasePopUpPresentor = purchasePopUpPresentor
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchasePopUpPresentor!.sizeViews()
        purchasePopUpPresentor!.addAllSubviews()
        self.view.addSubview(purchasePopUpPresentor!)
        self.preferredContentSize = purchasePopUpPresentor!.popOverContentSize
    }
}
