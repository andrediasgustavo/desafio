//
//  AppCoordinator.swift
//  desafio
//
//  Created by Andre Dias on 15/07/23.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private(set) var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
