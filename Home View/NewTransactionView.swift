//
//  NewTransactionView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 5/30/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CloudKit
import CoreData

struct NewTransactionView: View
{
    
    // core Data of user transaction
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    @FetchRequest(fetchRequest: ServicesData.getServicesData()) var servicesData: FetchedResults<ServicesData>
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    
    @State var showView: String = "text field"
    @State var costumeDateView: Bool = true
    
    //display states
    @State var instruction: String = "Write the name of the Purchase."
    @State var nextButton: String = "Next"
    @State var buttonTapped: Int = 0
    @State var keyboardType:UIKeyboardType = .default
    
    @State var viewMessage: Bool = false  // shows top message
    @State var viewMessageColor: Color = .white
    
    @State var userInput: String = ""
    @State var transaction: String = "-"
    @State var service: String = "-"
    @State var price: Float = 0
    @State var type: String = "-"
    @State var method: String = "-"
    @State var will: String = "-"
    
    //if Custom Date
    @State var maxDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    @State var date = Date()        //default day is current date if not changed by Custom Date
    @State var isCustomDate: Bool = false
    @State var year: Int = 0
    @State var month: Int = 0
    @State var day: Int = 0
    
    //top message
    @State var message: String = "Saved."
    
    
    var body: some View
    {
        ZStack
            {
                
                VStack
                    {
                        HStack
                            {
                                Spacer()
                                // MARK: - Add Date Button
                                if costumeDateView
                                {
                                    Button(action:
                                        {
                                            withAnimation
                                                {
                                                    self.isCustomDate = true
                                                    self.instruction = "Select a Date"
                                                    self.showView = "add date"
                                                    self.nextButton = "Done"
                                            }
                                    }) {
                                        Image(systemName: "calendar")
                                        Text("Add Date")
                                        Spacer()
                                            .frame(width: UIScreen.main.bounds.width / 40)
                                    }
                                    .foregroundColor(.primary)
                                    .font(.body)
                                    .padding(.horizontal)
                                    .background(
                                        Capsule()
                                            .fill(Color.secondary)
                                            .opacity(0.5))
                                }
                        }
                        
                        Spacer()
                        
                        Text(instruction)
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        // MARK: - Different Views
                        if (showView == "text field")
                        {
                            TextField("Type Here", text: self.$userInput)
                                .foregroundColor(.secondary)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.default)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                                .cornerRadius(30)
                        } else if (showView == "service")
                        {
                            Picker(selection: $service, label: Text(""))
                            {
                                ForEach(self.servicesData)
                                { data in
                                    Text(data.services ?? "Empty").tag(data.services ?? "Empty")
                                }
                            }
                            .labelsHidden()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                            .background(Color.white)
                            .cornerRadius(30)
                            
                            AddMoreView(type: "service")
                            
                        } else if (showView == "price field")
                        {
                            TextField("Cost Here", text: self.$userInput)
                                .foregroundColor(.secondary)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                                .background(Color.white)
                                .cornerRadius(30)
                        } else if (showView == "credit or debit")
                        {
                            Picker(selection: $type, label: Text(""))
                            {
                                Text("Credit Card").tag("Credit")
                                Text("Debit Card or Cash").tag("Debit")
                            }
                            .labelsHidden()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                            .background(Color.white)
                            .cornerRadius(30)
                        } else if (showView == "method")
                        {
                            Picker(selection: $method, label: Text(""))
                            {
                                if type == "Credit"
                                {
                                    ForEach(self.creditCardsData)
                                    { data in
                                        Text(data.creditCards ?? "Unknown").tag(data.creditCards!)
                                    }
                                }
                                else if type == "Debit"
                                {
                                    ForEach(self.debitCardsData)
                                    { data in
                                        Text(data.debitCards ?? "Unknown").tag(data.debitCards!)
                                    }
                                }
                            }
                            .labelsHidden()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                            .background(Color.white)
                            .cornerRadius(30)
                            
                            if type == "Credit"
                            {
                                AddMoreView(type: "credit")
                            }
                            else if type == "Debit"
                            {
                                AddMoreView(type: "debit")
                            }
                        }
                        else if (showView == "want or need")
                        {
                            Picker(selection: $will, label: Text(""))
                            {
                                Text("Want").tag("Want")
                                Text("Need").tag("Need")
                            }
                            .labelsHidden()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                            .background(Color.white)
                            .cornerRadius(30)
                        } else if (showView == "add date")
                        {
                            DatePicker("", selection: $date, in: ...maxDate, displayedComponents: .date)
                                .labelsHidden()
                                .padding()
                                .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                                .background(Color.white)
                                .cornerRadius(30)
                        }
                        
                        // MARK: - Next Button
                        Button(action: {
                            if(self.isCustomDate) {
                                self.showView = "text field"
                                self.instruction = "Write the name of the Purchase."
                                self.nextButton = "Next"
                            }
                            
                            if(self.buttonTapped == 0)
                            {
                                if !(self.userInput == "")
                                {
                                    self.transaction = self.userInput
                                    self.showView = "service"
                                    self.userInput = ""
                                    self.instruction = "Choose type of the service."
                                    self.buttonTapped += 1
                                    self.costumeDateView = false  // only show costumedate option on the first view
                                }
                            }
                                
                            else if(self.buttonTapped == 1)
                            {
                                if self.service == "-"
                                {
                                    self.service = self.servicesData[0].services ?? "Unknown"
                                }
                                self.showView = "price field"
                                self.userInput = ""
                                self.instruction = "Type the price of that item."
                                self.buttonTapped += 1
                            }
                                
                            else if(self.buttonTapped == 2)
                            {
                                if !(self.userInput == "") && Int(self.userInput)! <= 1000000
                                {
                                    self.price = Float(self.userInput) ?? 0
                                    self.instruction = "What did you use?"
                                    self.showView = "credit or debit"  //hide the textfield
                                    self.buttonTapped += 1
                                } else if Int(self.userInput)! > 1000000
                                {
                                    self.viewMessage = true
                                    self.viewMessageColor = .red
                                    self.message = "Digit Limit Exceeded"
                                    
                                }
                            }
                                
                            else if(self.buttonTapped == 3)
                            {
                                if self.type == "-"
                                { self.type = "Credit" }
                                self.instruction = "Choose your Payment Method."
                                self.showView = "method"
                                self.buttonTapped += 1
                            }
                                
                            else if(self.buttonTapped == 4)
                            {
                                if self.method == "-"
                                {
                                    if self.type == "Credit"
                                    {
                                        self.method = self.creditCardsData[0].creditCards ?? "-"
                                    }
                                    else if self.type == "Debit"
                                    {
                                        self.method = self.debitCardsData[0].debitCards ?? "-"
                                    }
                                }
                                self.instruction = "Do you wanted it or needed it?"
                                self.nextButton = "Save"
                                self.showView = "want or need"
                                self.buttonTapped += 1
                                
                            }
                            else if(self.buttonTapped == 5)
                            {
                                self.instruction = "Write the name of the Purchase."
                                self.nextButton = "Next"
                                self.showView = "text field"
                                self.userInput = ""
                                self.buttonTapped = 0
                                if self.will == "-"
                                { self.will = "Want" }
                                self.viewMessage = true
                                self.viewMessageColor = .white
                                self.message = "Saved."
                                self.addItem()
                                self.isCustomDate = false
                                self.costumeDateView = true
                                
                            }
                        }) {
                            Text(nextButton)
                                .font(.system(size: 20, design: .serif))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width / 4 , height: UIScreen.main.bounds.height / 20)
                                .background(Color.init(red: 254 / 255, green: 95 / 255, blue: 85 / 255).opacity(0.8))
                                .cornerRadius(20)
                                .shadow(radius: 20)
                                .padding()
                        }
                        
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 2.8)
                .background(
                    ZStack
                        {
                            Color.primary.colorInvert()
                            
                            Image("newTransactionbg")
                                .resizable()
                                .blur(radius: 6)
                                .opacity(0.7)
                    }
                )
                    .cornerRadius(30)
                    .shadow(radius: 10)
                
                
                // MARK: - "Saved" View
                if self.viewMessage
                {
                    Text(self.message)
                    .lineLimit(1)
                        .font(.system(size: UIScreen.main.bounds.width / 10, design: .serif))
                        .foregroundColor(self.viewMessageColor)
                        .padding()
                        .background(Color.secondary.opacity(0.7))
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 6)
                        .onAppear()
                            {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {   // shows for only 2 seconds
                                    self.viewMessage = false
                                }
                    }
                }
        }
    }
    
    
    func addItem()
    {
        let value = TransactionData(context: self.managedObjectContext)
        
        value.transaction = self.transaction
        value.service = self.service
        value.price = self.price
        value.method = self.method
        value.type = self.type
        value.will = self.will
        
        gettingDate()
        
        value.year = Int16(self.year)
        value.month = Int16(self.month)
        value.day = Int16(self.day)
        
        if value.hasChanges
        {
            try? self.managedObjectContext.save()
        }
    }
    
    
    func gettingDate()
    {
        let component = { (unit) in return Calendar.current.component(unit, from: self.date) }
        self.year = component(.year)
        self.month = component(.month)
        self.day = component(.day)
    }
}
