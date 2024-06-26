//
//  AppDelegate.swift
//  DemoPayApp
//
//  Created by Ипатов Александр Станиславович on 24.01.2024.
//

import UIKit
import SPaySdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // Метод настройки sdk на старте приложения
        SPay.setup(bnplPlan: true, // Необходимо ли отображение системы оплаты частями.
                   helpers: true, // Необходимо ли отображение подсказок для пользователя, которые помогут оплатить заказ при недостатке средств или при остутствии карты.
                   needLogs: true, // Необходимо ли писать лог SDK в консоль (работает только в режиме песочницы).
                   helperConfig: SBHelperConfig(sbp: true, creditCard: true, debitCard: true), // Более тонкая настройка отображения helpers для пользователя.
                   environment: .prod) { error in
            if let error {
                //  Произошла ошибка на этапе инициализации SDK.
                print(error.description)
            } else {
                // SDK инициализировалось без ошибок.
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

