//
//  TemplatesList.swift
//  777 products
//
//  Created by Алкександр Степанов on 11.07.2025.
//

import SwiftUI

struct TemplatesList: View {
    @AppStorage("bgNimber") var bgNumber = 1
    @State private var templatesListArray = UserDefaults.standard.array(forKey: "templatesListArray") as? [[String]] ?? Arrays.startTemplatesArray
    @State private var temporaryListPosition = UserDefaults.standard.array(forKey: "temporaryListPosition") as? [String] ?? ["01.01.25","productImage1","Apple","1", "p","1.75","0"]
    @State private var listElementXOffset: CGFloat = 0
    @State private var listOffsetXArray: [ListItemOffset] =  Array(repeating: ListItemOffset(), count: 100)
    @State private var addPositionPresented: Bool = false
    @State private var addPositionInListPresented: Bool = false
    @State private var tapletsListIndex = 0
    @Binding var wantToSelectTemplate: Bool
    @Binding var templatesPresented: Bool
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            Text("Add a position in list")
                .font(Font.custom("Moul-Regular", size: screenHeight*0.025))
                .foregroundColor(.red)
                .shadow(color: .white, radius: 1)
                .shadow(color: .black, radius: 2)
                .frame(maxHeight: screenHeight*0.9, alignment: .top)
            //                .padding(.top)
            Image(.arrowBack)
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.04)
                .frame(maxWidth: .infinity, maxHeight: screenHeight*0.9, alignment: .topLeading)
                .padding(.horizontal)
                .onTapGesture {
                    templatesPresented.toggle()
                }
            Image(.templatesListFrame)
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.8)
                .overlay(
                    ZStack {
                        HStack(spacing: screenHeight*0.07) {
                            Text("Category")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                .foregroundColor(.textYellow)
                            Text("Title")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                .foregroundColor(.textYellow)
                            Text("Amount")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                .foregroundColor(.textYellow)
                            Text("Price")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                .foregroundColor(.textYellow)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top)
                        ScrollView {
                            if !templatesListArray.isEmpty {
                                VStack {
                                    ForEach(0..<templatesListArray.count, id: \.self) { item in
                                        ZStack {
                                            Image(.templatesPositionFrame)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.054)
                                                .overlay(
                                                    HStack {
                                                        Image(templatesListArray[item][1])
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: screenHeight*0.04)
                                                            .frame(maxWidth: screenHeight*0.05)
                                                            .padding(.trailing)
                                                        Spacer()
                                                        Text(templatesListArray[item][2])
                                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                                            .foregroundColor(.textYellow)
                                                            .frame(width: screenHeight*0.12)
                                                            .shadow(color: .black, radius: 1)
                                                            .shadow(color: .black, radius: 1)
                                                        Spacer()
                                                        Text(templatesListArray[item][3] + templatesListArray[item][4])
                                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                                            .foregroundColor(.textYellow)
                                                            .frame(width: screenHeight*0.07)
                                                            .shadow(color: .black, radius: 1)
                                                            .shadow(color: .black, radius: 1)
                                                        Spacer()
                                                        Text(priceFormat(price: templatesListArray[item][5]))
                                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.014))
                                                            .foregroundColor(.red)
                                                            .frame(width: screenHeight*0.08)
                                                            .shadow(color: .black, radius: 1)
                                                            .shadow(color: .black, radius: 1)
                                                    }
                                                        .frame(maxWidth: screenHeight*0.41)
                                                )
                                            Image(.garbage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.035)
                                                .offset(x: -screenHeight*0.24)
                                                .onTapGesture {
                                                    removeElement(item: item)
                                                }
                                        }
                                        .onTapGesture {
                                            if !wantToSelectTemplate {
                                                tapOnListElement(item: item)
                                            } else {
                                                tapletsListIndex = item
                                                updateTemporaryListPosition(item: item)
                                                addPositionInListPresented.toggle()
                                            }
                                        }
                                        .offset(x: listOffsetXArray[item].offset)
                                    }
                                }
                                .padding(.vertical, screenHeight*0.01)
                            } else {
                                VStack {
                                    Text("There are no templates")
                                        .font(Font.custom("Moul-Regular", size: screenHeight*0.025))
                                        .foregroundColor(.red)
                                    //                                        .shadow(color: .white, radius: 1)
                                    //                                        .shadow(color: .black, radius: 2)
                                    Image(.addPositionButton)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.046)
                                        .onTapGesture {
                                            addPositionPresented.toggle()
                                        }
                                }
                                .padding(.top)
                            }
                        }
                        .frame(height: screenHeight*0.745)
                        .offset(y: screenHeight*0.02)
                    }
                    
                )
                .offset(y: screenHeight*0.03)
        }
        
        .fullScreenCover(isPresented: $addPositionPresented) {
            AddNewPosition(fromSettings: .constant(true), addPositionPresented: $addPositionPresented, selectedTemplateIndex: .constant(0))
        }
        
        .fullScreenCover(isPresented: $addPositionInListPresented, content: {
            AddPositionInList(addPositionPresented: $addPositionInListPresented, fromTamplates: .constant(true))
        })
        
        .onChange(of: addPositionPresented) { isPresented in
            if !isPresented {
                templatesListArray = UserDefaults.standard.array(forKey: "templatesListArray") as? [[String]] ?? Arrays.startTemplatesArray
                updateOffsetArray()
            }
        }
        
        .onAppear {
            pr()
            updateOffsetArray()
        }
        
    }
    
     func updateTemporaryListPosition(item: Int) {
    temporaryListPosition[1] = templatesListArray[item][1]
    temporaryListPosition[2] = templatesListArray[item][2]
    temporaryListPosition[3] = templatesListArray[item][3]
    temporaryListPosition[4] = templatesListArray[item][4]
    temporaryListPosition[5] = templatesListArray[item][5].replacingOccurrences(of: "$", with: "")
    UserDefaults.standard.setValue(temporaryListPosition, forKey: "temporaryListPosition")
}
    
    func tapOnListElement(item: Int) {
        if !listOffsetXArray[item].moved {
            for i in 0..<listOffsetXArray.count {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    listOffsetXArray[i].offset = 0
                }
                listOffsetXArray[i].moved = false
            }
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                listOffsetXArray[item].offset = screenHeight*0.05
            }
            listOffsetXArray[item].moved = true
        } else {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                listOffsetXArray[item].offset = 0
            }
            listOffsetXArray[item].moved = false
        }
    }
    
    func updateOffsetArray() {
        listOffsetXArray.removeAll()
        for _ in 0..<templatesListArray.count {
            listOffsetXArray.append(ListItemOffset(offset: 0, moved: false))
        }
    }
    
    func removeElement(item: Int) {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            listOffsetXArray[item].offset = screenWidth*1.1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            templatesListArray.remove(at: item)
            UserDefaults.standard.setValue(templatesListArray, forKey: "templatesListArray")
            for i in 0..<listOffsetXArray.count {
                listOffsetXArray[i].offset = 0
                listOffsetXArray[i].moved = false
            }
        }
    }
    
    func pr() {
        let dateFormatter = Formatter()
        
        // Преобразование в английский формат
        let englishDate = dateFormatter.convertToEnglishFormat("18.01.25")
        print(englishDate) // "January 18, 2025"
        
        // Преобразование в короткий формат
        let shortDate = dateFormatter.convertToShortFormat("January 18, 2025")
        print(shortDate) // "18.01.25"
        
        let monthDate = dateFormatter.getMonthFromAnyDate("18.07.25")
        print(monthDate)
        
        let weekDay = dateFormatter.getWeekdayAbbreviation("18.07.25")
        print(weekDay)
        
        let monthDay = dateFormatter.getMonthAndDay("18.07.25")
        print(monthDay)
    }
    
    func priceFormat(price: String) -> String {
        return "$\(price)"
    }
    
}

#Preview {
    TemplatesList(wantToSelectTemplate: .constant(false), templatesPresented: .constant(true))
}
