//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

extension UIViewController {
    /// Instantiates a regular view controller from a nib file.
    /// - Returns: A view controller instance.
    static func loadControllerFromNib<T: UIViewController>() -> T {
        let controller = T(nibName: String(describing: T.self), bundle: .module)
        
        return controller
    }
}
