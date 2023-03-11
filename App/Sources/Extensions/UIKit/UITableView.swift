//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell: T = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                                for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self)")
        }
        
        return cell
    }
    
    func register(_ cells: UITableViewCell.Type..., in bundle: Bundle = .module) {
        cells.forEach {
            register(UINib(nibName: String(describing: $0), bundle: bundle),
                     forCellReuseIdentifier: String(describing: $0))
        }
    }
    
    func registerHeaderFooterView(_ view: UIView.Type, in bundle: Bundle = .module) {
        register(UINib(nibName: String(describing: view), bundle: bundle),
                 forHeaderFooterViewReuseIdentifier: String(describing: view))
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView: T = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not dequeue header footer view: \(T.self)")
        }
        
        return headerFooterView
    }
}
