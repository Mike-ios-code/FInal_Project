//
//  ExpenseDetail.swift
//  FInal_Project
//
//  Created by Mike on 2022/1/7.
//

import SwiftUI

class SpendingData: ObservableObject {
    @AppStorage("spendings") var spendingsData: Data?
    @Published var spendings = [Spending]() {
        didSet {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(spendings)
                spendingsData = data
            } catch {
                
            }
        }
    }
    init() {
        if let spendingsData = spendingsData {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Spending].self, from: spendingsData) {
                spendings = decodedData
            }
        }
    }
}

struct Spending: Identifiable, Codable {
    var id = UUID()
    var amount: Int
    var note: String
    var type: Type
    var date: Date
}

enum Type: Int, Codable, CaseIterable {
case food = 0, drink = 1, dessert = 2, entertainment = 3, transportation = 4, other = 5,
    salary = 6, interest = 7, other_income = 8
    var description: String {
        switch self {
        case .food: return "正餐  "
        case .drink: return "飲料  "
        case .dessert: return "點心  "
        case .entertainment: return "娛樂  "
        case .transportation: return "交通  "
        case .other: return "其它  "
        case .salary: return "薪水  "
        case .interest: return "利息  "
        case .other_income: return "其他收入"
        }
    }
}

struct SpendingEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var spendingsData: SpendingData
    @State private var price = ""
    @State private var note = " "
    @State private var selectedType = Type.food
    @State private var dateValue = Date()
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("價錢")
                    TextField("", text: $price)
                        .keyboardType(.decimalPad)
                }
                VStack {
                    HStack {
                        Text("項目")
                        Spacer()
                        Picker("項目", selection: $selectedType) {
                            ForEach(Type.allCases, id: \.self) { (value) in
                                Text(value.description)
                                    .font(.system(size: 17))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 150, height: 80)
                        .clipped()
                    }
                }
                HStack {
                    Text("備註")
                    TextField("", text: $note)
                }
                HStack {
                    Text("時間")
                    DatePicker("",selection: $dateValue,
                               displayedComponents: [.date, .hourAndMinute])
                }
            }
            .navigationBarTitle("新增花費")
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                if price.contains(".") || price == "" {
                    showAlert = true
                }
                else {
                    let spending = Spending(amount: Int(price) ?? 0, note: note, type: selectedType,date: dateValue)
                    spendingsData.spendings.insert(spending, at: 0)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
                                    .alert(isPresented: $showAlert) { () -> Alert in
                return Alert(title: Text((price.contains(".")) ? "價錢必須為整數!" : "請輸入價錢!"))
            })
        }
    }
}

struct ExpenseDetail: View {
    @ObservedObject var spendingsData = SpendingData()
    @State private var showEditSpending = false
    var body: some View {
        NavigationView {
            Form {
                ForEach (spendingsData.spendings) { (spending) in
                    VStack{
                        HStack{
                            Text("\(spending.type.description)")
                                .foregroundColor(.blue)
                            Spacer()
                            VStack{
                                HStack{
                                    Text(spending.date, style: .date)
                                    Text(spending.date, style: .time)
                                    Spacer()
                                }
                                Spacer()
                                HStack {
                                    if spending.note != "" {
                                        Text("\(spending.note)")
                                    }
                                    Spacer()
                                    Text("$\(spending.amount)")
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    spendingsData.spendings.remove(atOffsets: indexSet)
                })
                .onMove(perform: { indices, newOffset in
                    spendingsData.spendings.move(fromOffsets: indices, toOffset: newOffset)
                })
            }
            .navigationBarTitle("Expenses")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .disabled(spendingsData.spendings.count == 0)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showEditSpending = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                }
            })
        }
        .sheet(isPresented: $showEditSpending) {
            SpendingEditor(spendingsData: spendingsData)
        }
    }
}


struct ExpenseDetail_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseDetail()
    }
}
