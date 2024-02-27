//
//  ViewController.swift
//  DemoPayApp
//
//  Created by Ипатов Александр Станиславович on 24.01.2024.
//

import UIKit
import SPaySdk

class ViewController: UIViewController {
    
    // Кнопка оплаты SDK
    private lazy var sPayButton: SBPButton = {
        let view = SBPButton()
        view.tapAction = {
            self.payWithSDK()
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        
        // Узнаем, доступны ли сервисы оплаты SDK
        if SPay.isReadyForSPay {
            
            // Если доступны, то можем отрисовать кнопку SDK
            
            view.addSubview(sPayButton)
            
            self.sPayButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.sPayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                         constant: 16),
                self.sPayButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -16),
                self.sPayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                        constant: -40)
            ])
        }
        
    }
    
    func payWithSDK() {
        
        let request = SBankInvoicePaymentRequest(merchantLogin: "", // Login партнера для работы с сервисами платежного шлюза
                                                 bankInvoiceId: "", // Уникальный номер (идентификатор) заказа в Платежном шлюзе Банка. Необходимо передавать значение sbolBankInvoiceId (передается в externalParams)
                                                 orderNumber: "", // Уникальный номер (идентификатор) заказа в системе Клиента

                                                 redirectUri: "demopayappscheme://spay", // Адрес вашего приложения, по которому необходимо вернуть пользователя после аутентификации в СберБанк Онлайн (формат вашасхема://spay)
                                                 apiKey: "") // Ключ клиента для работы с сервисами платежного шлюза через SDK
        
        SPay.payWithBankInvoiceId(with: self, paymentRequest: request) { state, info in
            switch state {
            case .success:
                print("Получили success")
            case .waiting:
                print("Получили waiting")
            case .error:
                print("Получили error")
            case .cancel:
                print("Получили cancel")
            @unknown default:
                print("Получили неизвестный стейт")
            }
        }
    }

}

