//
//  ExpenseSummary.swift
//  FInal_Project
//
//  Created by Mike on 2022/1/7.
//

import SwiftUI

let height = CGFloat(200)
var expense_Type = ["正餐", "飲料", "點心", "娛樂", "交通", "其他", "薪水", "利息", "其他收入"]

struct PieChart: Shape {
    var startAngle: Angle
    var endAngle: Angle
    func path(in rect: CGRect) -> Path {
        Path { (path) in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center, radius: rect.midX, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}

struct ExpenseSummary: View {
    @StateObject var spendingsData = SpendingData()
    @State private var trimEnd: CGFloat = 0
    @State private var showChart = false
    var body: some View {
        VStack {
            TabView {
                VStack {
                    HStack{
                        Text("總支出 $\(expense_sum)")
                            .font(.title)
                            .padding()
                            .frame(width: 300, height: 60, alignment: .leading)
                            .offset(x: 0, y: 0)
                        Spacer()
                        Button(action: {
                            showChart = false
                            calculateSum()
                            calculateAngles()
                            showChart = true
                        }, label: {
                            Text("更新    ")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(40)
                                .frame(width: 100, height: 30)
                        })
                        Spacer()
                    }
                    .offset(x: 0, y: -30)
                    ZStack{
                        Text("支出圖")
                    }
                    ZStack {
                        PieChart(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 0))
                        if (showChart == true) {
                            PieChart(startAngle: angles[0], endAngle: angles[1])
                                .foregroundColor(.brown)
                                .animation(.linear(duration: 2), value: true)
                            PieChart(startAngle: angles[1], endAngle: angles[2])
                                .foregroundColor(.orange)
                                .animation(.linear(duration: 2), value: true)
                            PieChart(startAngle: angles[2], endAngle: angles[3])
                                .foregroundColor(.red)
                                .animation(.linear(duration: 2), value: true)
                            PieChart(startAngle: angles[3], endAngle: angles[4])
                                .foregroundColor(Color(.cyan))
                                .animation(.linear(duration: 2), value: true)
                            PieChart(startAngle: angles[4], endAngle: angles[5])
                                .foregroundColor(.blue)
                                .animation(.linear(duration: 2), value: true)
                            PieChart(startAngle: angles[5], endAngle: angles[0])
                                .foregroundColor(.gray)
                                .animation(.linear(duration: 2), value: true)
                        }
                    }
                    .frame(width: 270, height: 270, alignment: .center)
                    HStack {
                        Color(.brown)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[0]):\(percentString(num: percents[0]*100))%")
                        Spacer()
                        Color(.orange)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[1]):\(percentString(num: percents[1]*100))%")
                        Spacer()
                        Color(.red)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[2]):\(percentString(num: percents[2]*100))%")
                        Spacer()
                    }
                    HStack {
                        Color(.cyan)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[3]):\(percentString(num: percents[3]*100))%")
                        Spacer()
                        Color(.blue)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[4]):\(percentString(num: percents[4]*100))%")
                        Spacer()
                        Color(.gray)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[5]):\(percentString(num: percents[5]*100))%")
                        Spacer()
                    }
                }
                .animation(.linear(duration: 2), value: true)
                .padding(.leading)
                VStack {
                    HStack{
                        Text("總收入 $\(income_sum)")
                            .font(.title)
                            .padding()
                            .frame(width: 300, height: 60, alignment: .leading)
                            .offset(x: 0, y: 0)
                        Spacer()
                        Button(action: {
                            showChart = false
                            calculateSum()
                            calculateAngles()
                            showChart = true
                        }, label: {
                            Text("更新    ")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(40)
                                .frame(width: 100, height: 30)
                        })
                        Spacer()
                    }
                    .offset(x: 0, y: -30)
                    ZStack{
                        Text("收入圖")
                    }
                    ZStack {
                        PieChart(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 0))
                        if (showChart == true) {
                            PieChart(startAngle: angles[6], endAngle: angles[7])
                                .foregroundColor(.green)
                                .animation(.linear(duration: 2), value: true)
                            PieChart(startAngle: angles[7], endAngle: angles[8])
                                .foregroundColor(.yellow)
                                .animation(.linear(duration: 2), value: true)
                            PieChart(startAngle: angles[8], endAngle: angles[9])
                                .foregroundColor(.gray)
                                .animation(.linear(duration: 2), value: true)
                        }
                    }
                    .frame(width: 270, height: 270, alignment: .center)
                    HStack {
                        Color(.green)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[6]):\(percentString(num: percents[6]*100))%")
                        Spacer()
                        Color(.yellow)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[7]):\(percentString(num: percents[7]*100))%")
                        Spacer()
                    }
                    HStack{
                        Color(.gray)
                            .clipShape(Circle())
                            .frame(width: 13, height: 13)
                        Text("\(expense_Type[8]):\(percentString(num: percents[8]*100))%")
                        Spacer()
                    }
                }
                .animation(.linear(duration: 2), value: true)
                .padding(.leading)
            }
            .tabViewStyle(PageTabViewStyle())
            HStack{
                Text("總和 $\(income_sum - expense_sum)")
                    .font(.system(size: 20))
                    .padding()
                    .frame(width: 390, height: 60, alignment: .trailing)
                    .offset(x: 0, y: 0)
                Spacer()
            }
        }
        .onAppear {
            calculateSum()
            calculateAngles()
            showChart = true
        }
        .onDisappear()
    }
}

//private func textOffset(for index: Int, in size: CGSize) -> CGSize {
//    let radius = min(size.width, size.height) / 3
//    let dataRatio = (2 * data[..<index].reduce(0, +) + data[index]) / (2 * data.reduce(0, +))
//    let angle = CGFloat(sliceOffset + 2 * .pi * dataRatio)
//    return CGSize(width: radius * cos(angle), height: radius * sin(angle))
//  }

struct ExpenseSummary_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSummary()
    }
}
