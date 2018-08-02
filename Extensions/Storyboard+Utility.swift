//
//  Storyboard+Utility.swift
//  ChoiceFreedom
//
//  Created by Owais Raza on 8/1/18.
//  Copyright © 2018 Makeschool. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum CFType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: CFType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: CFType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
