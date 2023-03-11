//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

extension UIView {
    static func loadXib<T : UIView>() -> T {
        guard let view = Bundle.module.loadNibNamed(String(describing: T.self), owner: self, options: nil)?.first as? T else {
            fatalError("Could not load xib file \(String(describing: T.self))")
        }
        
        return view
    }
}
