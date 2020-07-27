import SwiftUI
import CoreData

struct listOfDebitsView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    
    @ObservedObject var textFieldManager = TextFieldManager(charLimit: 15)
    @State var newDebitCard: String = ""
    @State var userInput: String = "Type the name of your Debit Card"
    @State var showAlert: Bool = false
    
    var body: some View
    {
        List
            {
                HStack
                    {
                        TextField(self.userInput, text: self.$textFieldManager.text)
                        
                        Spacer()
                        
                        Button(action: {
                            self.newDebitCard = self.textFieldManager.text.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if !self.newDebitCard.isEmpty {
                                var exist = false
                                for each in self.debitCardsData
                                {
                                    if each.debitCards == self.newDebitCard
                                    {
                                        exist = true
                                    }
                                }
                                if !exist
                                {
                                    let data = DebitCardsData(context: self.managedObjectContext)
                                    data.debitCards = self.newDebitCard
                                    self.textFieldManager.text = ""
                                    
                                    if data.hasChanges
                                    {
                                        try? self.managedObjectContext.save()
                                    }
                                } else
                                {
                                    self.showAlert = true
                                    let notificationGenerator = UINotificationFeedbackGenerator()
                                    notificationGenerator.notificationOccurred(.error)
                                }
                            }
                        })
                        {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.green)
                        }
                }
                
                ForEach(self.debitCardsData, id: \.self)
                { data in
                    
                    Text(data.debitCards ?? "Unknown")
                }
                .onDelete{ index in
                    let deleteItem = self.debitCardsData[index.first!]
                    self.managedObjectContext.delete(deleteItem)
                    
                    try? self.managedObjectContext.save()
                    
                }
        }
        .alert(isPresented: $showAlert)
        {
            Alert(title: Text("Already Exists"), message: Text("Item cannot be added because it already exists."), dismissButton: .default(Text("OK")))
        }
        
    }
}
