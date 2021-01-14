//
//  InAppPurchaseStore.swift
//  ExpenseSheet
//
//  Created by Bishal Aryal on 03/01/2021.
//  Copyright © 2021 Bishal Aryal. All rights reserved.
//

import StoreKit

typealias FetchComplitionHandler = (([SKProduct]) -> Void)
typealias PurchaseomplitionHandler = ((SKPaymentTransaction?) -> Void)

class InAppPurchaseStore: NSObject, ObservableObject
{
    
    private let allProductIdentifiers = Set(["biszaal.Expense.removeads"])
    
    private var completedPurchases = [String]()
    
    private var productRequests: SKProductsRequest?
    private var fetchedProducts = [SKProduct]()
    private var fetchComplitionHandler: FetchComplitionHandler?
    private var purchaseComplitionHandler: PurchaseomplitionHandler?
    
    override init()
    {
        super.init()
        
        fetchProducts
        { (products) in
            print(products)
        }
    }
    
    private func startObservingPaymentQueue()
    {
        SKPaymentQueue.default().add(self)
    }
    
    private func fetchProducts(_ complition: @escaping FetchComplitionHandler)
    {
        guard self.productRequests == nil else { return }
        
        fetchComplitionHandler = complition
        
        productRequests = SKProductsRequest(productIdentifiers: allProductIdentifiers)
        productRequests?.delegate = self
        productRequests?.start()
    }
    
    private func buy(_ product: SKProduct, complition: @escaping PurchaseomplitionHandler)
    {
        purchaseComplitionHandler = complition
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension InAppPurchaseStore
{
    func purchaseProduct(_ product: SKProduct)
    {
        startObservingPaymentQueue()
        buy(product)
        { _ in
            // Empty
        }
    }
}

extension InAppPurchaseStore: SKPaymentTransactionObserver
{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])
    {
        for transaction in transactions
        {
            var shouldFinishTransaction = false
            switch transaction.transactionState
            {
            case .purchased, .restored:
                completedPurchases.append(transaction.payment.productIdentifier)
                shouldFinishTransaction = true
            case .failed:
                shouldFinishTransaction = true
            case .purchasing, .deferred:
                break
            @unknown default:
                break
            }
            
            if shouldFinishTransaction
            {
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async
                {
                    self.purchaseComplitionHandler?(transaction)
                    
                    self.purchaseComplitionHandler = nil
                }
            }
        }
    }
}

extension InAppPurchaseStore: SKProductsRequestDelegate
{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse)
    {
        let loadedProducts = response.products
        let invalidProducts = response.invalidProductIdentifiers
        
        guard !loadedProducts.isEmpty else {
            print("Could not load the purchase")
            if !invalidProducts.isEmpty
            {
                print("Invalid purchase: \(invalidProducts)")
            }
            productRequests = nil
            return
        }
        
        // Cache the fetched products
        fetchedProducts = loadedProducts
        
        // Notify anyone waiting on the product load
        DispatchQueue.main.async
        {
            self.fetchComplitionHandler?(loadedProducts)
            
            self.fetchComplitionHandler = nil
            self.productRequests = nil
        }
    }
}
