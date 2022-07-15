//
//  ContentView.swift
//  FInal_Project
//
//  Created by Mike on 2022/1/6.
//

import SwiftUI
import UIKit

var sum = 0
var expense_sum = 0
var income_sum = 0
var sums = [0,0,0,0,0,0,0,0,0]
var max: Double = 0
var angles = [Angle(degrees: 0), Angle(degrees: 0), Angle(degrees: 0), Angle(degrees: 0), Angle(degrees: 0), Angle(degrees: 0), Angle(degrees: 0), Angle(degrees: 0), Angle(degrees: 0), Angle(degrees: 360)]
var percents = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]

func calculateSum() {
    let spendingsData = SpendingData()
    expense_sum = 0
    income_sum = 0
    
    for i in 0..<sums.count {
        sums[i] = 0
    }
    
    for i in 0..<spendingsData.spendings.count {
        sums[spendingsData.spendings[i].type.rawValue] += spendingsData.spendings[i].amount
    }
    for i in 0..<sums.count{
        if i < 6{
            expense_sum += sums[i]
        }
        else{
            income_sum += sums[i]
        }
    }
    for i in 0..<sums.count{
        if i < 6{
            percents[i] = Double(sums[i])/Double(expense_sum)
        }
        else{
            percents[i] = Double(sums[i])/Double(income_sum)
        }
    }
}
func percentString(num: Double) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    formatter.numberStyle = .decimal
    
    return formatter.string(from: num as NSNumber) ?? "n/a"
}

func calculateAngles() {
    var temp:Double = 0.0
    for i in 1...sums.count {
        if i < 6{
            if max < Double(sums[i-1]) {
                max = Double(sums[i-1])
            }
            temp += Double(sums[i-1])
            angles[i] = Angle(degrees: temp*360.0/Double(expense_sum))
        }
        else{
            if max < Double(sums[i-1]) {
                max = Double(sums[i-1])
            }
            temp += Double(sums[i-1])
            angles[i] = Angle(degrees: temp*360.0/Double(income_sum))
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            ExpenseSummary()
                .tabItem {
                    Text("總覽")
                    Image(systemName: "chevron.up.circle")
                }
            ExpenseDetail()
                .tabItem {
                    Text("紀錄")
                    Image(systemName: "ellipsis.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ExpenseDetail()
        ContentView()
//            .preferredColorScheme(.dark)
    }
}
