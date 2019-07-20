//
//  AppDelegate.swift
//  TestAssignment
//
//  Created by Alexey Naumov on 19/07/2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = setupRootViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    private func setupRootViewController() -> UIViewController {
        let viewController = ListOfCountriesViewController(nibName: nil, bundle: nil)
        let service = setupCountriesService()
        viewController.viewModel = ListOfCountries.ViewModel(service: service)
        return viewController
    }

    private func setupCountriesService() -> CountriesServiceProtocol {
        let urlSession = URLSession(configuration: .default)
        return CountriesService(urlSession: urlSession)
    }
}
