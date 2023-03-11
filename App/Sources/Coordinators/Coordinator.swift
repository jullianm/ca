//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

public protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }

    func start()

    func addChild(_ coordinator: Coordinator)
    func removeFromParent()
}

public extension Coordinator {

    func addChild(_ coordinator: Coordinator) {
        children.append(coordinator)
        coordinator.parent = self
    }

    func removeFromParent() {
        defer { parent = nil}
        guard let parent = parent else { return }

        for (index, child) in parent.children.enumerated() {
            if self === child {
                parent.children.remove(at: index)
                break
            }
        }
    }
}
