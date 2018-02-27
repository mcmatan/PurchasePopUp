//
//  PurchasePopUpBarButtonItem.swift
//  PurchasePopUp
//
//  Created by Matan Cohen on 2/27/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import Foundation

import UIKit

open class PurchasePopUpBarButtonItem: UIBarButtonItem {
    /**
     A bar button to close PurchasePopUpPresentor with out selections.
     
     - parameter purchasePopUpPresentor: Target instance
     - parameter title: Optionally set a custom title
     - parameter barButtonSystemItem: Optionally set UIBarButtonSystemItem or omit for default: .done. NOTE: This option is ignored when title is non-nil.
     
     - returns: PurchasePopUpBarButtonItem
     */
    
    public class func title(title: String) -> PurchasePopUpBarButtonItem {
        let button = self.init(title: title, style: .plain, target: nil, action: nil)
        button.tintColor = UIColor.black
        return button
    }
    
    public class func cancel(purchasePopUpPresentor: PurchasePopUpPresentor, title: String? = nil, barButtonSystemItem: UIBarButtonSystemItem = .cancel) -> PurchasePopUpBarButtonItem {
        
        if let buttonTitle = title {
            return self.init(title: buttonTitle, style: .plain, target: purchasePopUpPresentor, action: #selector(PurchasePopUpPresentor.cancel))
        }
        
        return self.init(barButtonSystemItem: barButtonSystemItem, target: purchasePopUpPresentor, action: #selector(PurchasePopUpPresentor.cancel))
    }
    
    public class func flexibleSpace() -> PurchasePopUpBarButtonItem {
        return self.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
    
    public class func fixedSpace(width: CGFloat) -> PurchasePopUpBarButtonItem {
        let fixedSpace =  self.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = width
        return fixedSpace
    }
}

