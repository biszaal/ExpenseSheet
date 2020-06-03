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

struct NewTransactionView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: Data.getData()) var data: FetchedResults<Data>
    
    @State var numberOfTransaction = 0
    
    @State var showView: String = "text field"
    
    //display states
    @State var instruction: String = "Write the name of the Purchase."
    @State var nextButton: String = "Next"
    @State var buttonTapped: Int = 0
    @State var keyboardType:UIKeyboardType = .default
    
    //hiding and displaying text fields
    @State private var textField = true
    @State var viewSaved = false
    @State var value: CGFloat = 0
    
    @State var userInput = ""
    @State var transaction: String = "-"
    @State var price: Float = 0
    @State var type: String = "-"
    @State var will: String = "-"
    
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: -10)
            
            VStack {
                
                Text(instruction)
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                if (showView == "text field")
                {
                    TextField("Type Here", text: self.$userInput)
                        .foregroundColor(.secondary)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                        .background(Color.white)
                        .cornerRadius(30)
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
                        Text("Credit").tag("Credit")
                        Text("Debit").tag("Debit")
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                    .background(Color.white)
                    .cornerRadius(30)
                } else if (showView == "want or need")
                {
                    Picker(selection: $will, label: Text(""))
                    {
                        Text("Want").tag("Want")
                        Text("Need").tag("Need")
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                    .background(Color.white)
                    .cornerRadius(30)
                }
                
                
                Spacer()
                
                Button(action: {
                    
                    
                    if(self.buttonTapped == 0)
                    {
                        if !(self.userInput == "")
                        {
                            self.transaction = self.userInput
                            self.showView = "price field"
                            self.userInput = ""
                            self.instruction = "Type the price of that item."
                            self.buttonTapped += 1
                            self.viewSaved = false  //"saved" view after input
                        }
                    }
                        
                    else if(self.buttonTapped == 1)
                    {
                        if !(self.userInput == "")
                        {
                            self.price = Float(self.userInput) ?? 0
                            self.instruction = "Did you use Credit or Debit?"
                            self.showView = "credit or debit"  //hide the textfield
                            self.buttonTapped += 1
                        }
                    }
                        
                    else if(self.buttonTapped == 2)
                    {
                        self.instruction = "Do you wanted it or needed it?"
                        self.nextButton = "Save"
                        self.showView = "want or need"
                        self.buttonTapped += 1
                        if self.type == "-"
                        { self.type = "Credit" }
                    }
                    else if(self.buttonTapped == 3)
                    {
                        self.instruction = "Write the name of the Purchase."
                        self.keyboardType = .default
                        self.nextButton = "Next"
                        self.showView = "text field"
                        self.userInput = ""
                        self.buttonTapped = 0
                        if self.will == "-"
                        { self.will = "Want" }
                        self.viewSaved = true
                        
                        self.addItem()    
                        
                    }
                    
                }) {
                    Text(nextButton)
                        .font(.system(size: 20, design: .serif))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 4 , height: UIScreen.main.bounds.height / 20)
                        .background(Color.init(red: 254 / 255, green: 95 / 255, blue: 85 / 255).opacity(0.8))
                        .cornerRadius(20)
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 4)
            .background(Color.init(red: 198 / 255, green: 236 / 255, blue: 207 / 255))
            .cornerRadius(30)
                        
            // MARK: - "Saved" View
            if self.viewSaved {
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 15)
                
                Text("Saved.")
                    .font(.system(size: 20, design: .serif))
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {   // shows for only 2 seconds
                            self.viewSaved = false
                        }
                }
            }
        }
    }
    
    
    func addItem() {
        let value = Data(context: self.managedObjectContext)
        
        value.transaction = self.transaction
        value.price = self.price
        value.type = self.type
        value.will = self.will
        
        value.year = Int16(gettingDate(type: "year"))
        value.month = Int16(gettingDate(type: "month"))
        value.day = Int16(gettingDate(type: "day"))
        
        if value.hasChanges {
            try? self.managedObjectContext.save()
        }
    }
    
    
    func gettingDate(type: String) -> Int {
        
        let date = Date()
        let component = { (unit) in return Calendar.current.component(unit, from: date) }
        let year = component(.year)
        let month = component(.month)
        let day = component(.day)
        
        if (type.lowercased() == "year") { return Int(year) }
            
        else if (type.lowercased() == "month") { return Int(month) }
            
        else if (type.lowercased() == "day") { return Int(day) }
            
        else { return -1 }
    }
}
struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView()
    }
}
