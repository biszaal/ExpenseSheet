import StoreKit

class InAppPurchases: NSObject, SKPaymentTransactionObserver, ObservableObject {
    
    let productID = "biszaal.Expense.removeads"
    
    var purchaseLabel: String = ""
    
    func purchasePressed(_ sender: Any)
    {
        SKPaymentQueue.default().add(self)
        if SKPaymentQueue.canMakePayments()
        {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else
        {
            print("User unable to make payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])
    {
        for transaction in transactions
        {
            if transaction.transactionState == .purchased
            {
                //if item has been purchased
                print("Transaction Successful")
                purchaseLabel = "Purchase Completed!"
                
                UserDefaults.standard.set(true, forKey: "ads_removed")
                
            } else if transaction.transactionState == .failed
            {
                print("Transaction Failed")
            } else if transaction.transactionState == .restored
            {
                print("restored")
                purchaseLabel = "Purchase Restored!"
            }
        }
    }
    
    func restorePressed(_ sender: Any)
    {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    

}
