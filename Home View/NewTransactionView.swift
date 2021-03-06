import SwiftUI
import CloudKit
import CoreData


struct NewTransactionView: View
{
    
    // core Data of user transaction
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    @FetchRequest(fetchRequest: CategoriesData.getCategoriesData()) var categoriesData: FetchedResults<CategoriesData>
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    
    @State var showView: String = "text field"
    @State var costumeDateView: Bool = true
    
    //display states
    @State var instruction: String = "Name of the Purchase"
    @State var nextButton: String = "Next"
    @State var buttonTapped: Int = 0
    @State var keyboardType:UIKeyboardType = .default
    @State var showAddMoreView: Bool = false
    
    @State var viewMessage: Bool = false  // shows top message
    
    // for text manager
    @ObservedObject var textFieldManager = TextFieldManager(charLimit: 19)      //this is text limiter for the textField
    @ObservedObject var textFieldManagerForPrice = TextFieldManager(charLimit: 7)
    
    // default variables
    @State var userInput: String = ""
    @State var transaction: String = ""
    @State var category: String = ""
    @State var price: Float = 0
    @State var type: String = ""
    @State var method: String = ""
    @State var will: String = ""
    
    //if Custom Date
    @State var maxDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    @State var date = Date()        //default day is current date if not changed by Custom Date
    @State var isCustomDate: Bool = false
    @State var year: Int = 0
    @State var month: Int = 0
    @State var day: Int = 0
    
    //top message
    @State var message: String = "Saved"
    
    // transaction
    @State var refreshPage: Bool = false
    
    // sheet view
    @State var showSheetView: Bool = false
    @State var sheetView: String = ""
    
    //Binding
    @Binding var showTransactionView: Bool
    
    
    var body: some View
    {
        ZStack
        {
            if !refreshPage
            {
                VStack
                {
                    HStack
                    {
                        Spacer()
                        // MARK: - Add Date Button
                        if costumeDateView
                        {
                            DatePicker("", selection: $date, in: ...maxDate, displayedComponents: .date)
                                .labelsHidden()
                                .foregroundColor(.primary)
                                .font(.body)
                                .padding(.horizontal)
                                .background(
                                    Capsule()
                                        .fill(Color.primary)
                                        .colorInvert()
                                        .opacity(0.5))
                        }
                    }
                    
                    Spacer()
                    
                    Text(instruction)
                        .foregroundColor(.black)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .animation(nil)     // fix text animation bug
                    
                    Spacer()
                    
                    // MARK: - Transaction Views
                    Group
                    {
                        if (showView == "text field")
                        {
                            TextField("Type Here", text: self.$textFieldManager.text)
                                .foregroundColor(.secondary)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.default)
                                .padding()
                        }
                        else if (showView == "category")
                        {
                            Picker(selection: $category, label: Text(""))
                            {
                                ForEach(self.categoriesData)
                                { data in
                                    Text(data.category ?? "Unknown").tag(data.category ?? "Unknown")
                                }
                            }
                            .labelsHidden()
                            .padding()
                            
                        }
                        else if (showView == "price field")
                        {
                            TextField("Cost Here", text: self.$textFieldManagerForPrice.text)
                                .foregroundColor(.secondary)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding()
                        }
                        else if (showView == "credit or debit")
                        {
                            Picker(selection: $type, label: Text(""))
                            {
                                Text("Credit Card").tag("Credit")
                                Text("Debit Card or Cash").tag("Debit")
                            }
                            .labelsHidden()
                            .padding()
                        }
                        else if (showView == "method")
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
                        }
                        else if (showView == "want or need")
                        {
                            Picker(selection: $will, label: Text(""))
                            {
                                Text("Want").tag("Want")
                                Text("Need").tag("Need")
                            }
                        }
                        else if (showView == "add date")
                        {
                            DatePicker("", selection: $date, in: ...maxDate, displayedComponents: .date)
                                .labelsHidden()
                                .padding()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 10)
                    .cornerRadius(30)
                    
                    // MARK: - Add more button to toggle sheet
                    if showAddMoreView
                    {
                        Button(action: {
                            self.showSheetView = true
                        })
                        {
                            Text("+ Add more")
                                .foregroundColor(.primary)
                        }
                        .padding(10)
                        .background(Color.primary.colorInvert().opacity(0.5))
                        .cornerRadius(20)
                    }
                    // MARK: - Next Button
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred() //haptic feedback
                        
                        if(self.isCustomDate) {
                            self.showView = "text field"
                            self.instruction = "Name of the Purchase."
                            self.nextButton = "Next"  // after clicking done will take you back to name of the purchase
                        }
                        
                        if(self.buttonTapped == 0)
                        {
                            self.userInput = self.textFieldManager.text
                            if !(self.userInput == "")
                            {
                                self.transaction = self.userInput
                                self.showView = "category"
                                self.userInput = ""
                                self.textFieldManager.text = ""
                                self.instruction = "Category"
                                self.buttonTapped += 1
                                self.costumeDateView = false  // disable costume date option after the first view
                                self.enableSlideAnimation()
                                
                                if #available(iOS 14, *)       // has a bug for IOS 13
                                {
                                    self.sheetView = "category"
                                    self.showAddMoreView = true
                                }
                            }
                        }
                        
                        else if(self.buttonTapped == 1)
                        {
                            if self.category == ""
                            {
                                self.category = self.categoriesData[0].category ?? "Unknown"
                            } // setting default
                            self.userInput = ""
                            self.textFieldManager.text = ""
                            self.showView = "price field"
                            self.instruction = "Price"
                            self.buttonTapped += 1
                            self.enableSlideAnimation()
                            
                            self.showAddMoreView = false
                        }
                        
                        else if(self.buttonTapped == 2)
                        {
                            self.userInput = self.textFieldManagerForPrice.text
                            if !(self.userInput == "")
                            {
                                self.price = Float(self.userInput) ?? 0
                                self.userInput = ""
                                self.textFieldManager.text = ""
                                self.instruction = "Payment Type"
                                self.showView = "credit or debit"  //hide the textfield
                                self.buttonTapped += 1
                                self.enableSlideAnimation()
                                
                                self.showAddMoreView = false
                            }
                        }
                        
                        else if(self.buttonTapped == 3)
                        {
                            if self.type == ""
                            { self.type = "Credit" } // setting default
                            self.instruction = "Payment Method"
                            self.showView = "method"
                            self.buttonTapped += 1
                            self.enableSlideAnimation()
                            
                            if #available(iOS 14, *)       // has a bug for IOS 13
                            {
                                self.sheetView = "method"
                                self.showAddMoreView = true
                            }
                        }
                        
                        else if(self.buttonTapped == 4)
                        {
                            if self.method == ""
                            {
                                if self.type == "Credit"
                                {
                                    self.method = self.creditCardsData[0].creditCards ?? ""
                                }
                                else if self.type == "Debit"
                                {
                                    self.method = self.debitCardsData[0].debitCards ?? ""
                                }
                            } // setting default
                            self.instruction = "Necessity"
                            self.nextButton = "Save"
                            self.showView = "want or need"
                            self.buttonTapped += 1
                            self.enableSlideAnimation()
                            
                            self.showAddMoreView = false
                            
                        }
                        else if(self.buttonTapped == 5)
                        {
                            self.userInput = ""
                            self.textFieldManager.text = ""
                            self.buttonTapped = 0
                            if self.will == ""
                            { self.will = "Want" } // setting default
                            self.viewMessage = true
                            self.message = "Saved."
                            self.addItem()
                            self.isCustomDate = false
                            self.costumeDateView = true
                            
                            self.showAddMoreView = false
                            
                            // set everything back to default
                            self.transaction = ""
                            self.price = 0
                            self.date = Date()
                            
                            
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
                            .animation(nil)     // fix text animation bug
                    }
                    .sheet(isPresented: $showSheetView)
                    {
                        if self.sheetView == "category"
                        {
                            listOfCategoriesView()
                        }
                        else if self.sheetView == "method"{
                            listOfMethodsView()
                        }
                    }
                }
                .padding()
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 2.8)
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
                
                .animation(.easeInOut)
                .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
            }
            
            // MARK: - "Saved" View
            if self.viewMessage
            {
                Text(self.message)
                    .lineLimit(1)
                    .font(.system(size: UIScreen.main.bounds.width / 10, design: .serif))
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding()
                    .background(Color.secondary.opacity(0.7))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                    .onAppear()
                    {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {   // shows for only 2 seconds
                            self.viewMessage = false
                            self.showTransactionView = false
                        }
                    }
            }
        }
        .padding()
        
    }
    
    func enableSlideAnimation()
    {
        self.refreshPage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {   // wait
            self.refreshPage = false
        }
    }
    
    func addItem()
    {
        let value = TransactionData(context: self.managedObjectContext)
        
        value.transaction = self.transaction
        value.category = self.category
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
