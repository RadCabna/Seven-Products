//
//  AddNewPosition.swift
//  777 products
//
//  Created by Алкександр Степанов on 11.07.2025.
//

import SwiftUI

struct AddNewPosition: View {
    @AppStorage("bgNimber") var bgNumber = 1
    @State private var image = "productImage1"
    @State private var title = "Apple"
    @State private var amount = "1"
    @State private var units = "p"
    @State private var price = "$1.75"
    @State private var unitsArray = ["Pieces", "Liters", "Kilos"]
    @State private var unitNumber = 0
    @State private var categoryesArray = Arrays.categoriesArray
    @State private var categoryIndex = 0
    @State private var templatesListArray = UserDefaults.standard.array(forKey: "templatesListArray") as? [[String]] ?? Arrays.startTemplatesArray
    @State private var temporaryListPosition = UserDefaults.standard.array(forKey: "temporaryListPosition") as? [String] ?? ["01.01.25","productImage1","Apple","1", "p","1.75","0"]
    @State private var addPositionInListPresentred: Bool = false
    @Binding var fromSettings: Bool
    @Binding var addPositionPresented: Bool
    @Binding var selectedTemplateIndex: Int
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            Text("Add a position")
                .font(Font.custom("Moul-Regular", size: screenHeight*0.025))
                .foregroundColor(.red)
                .shadow(color: .white, radius: 1)
                .shadow(color: .black, radius: 2)
                .frame(maxHeight: screenHeight*0.9, alignment: .top)
            Image(.arrowBack)
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.04)
                .frame(maxWidth: .infinity, maxHeight: screenHeight*0.9, alignment: .topLeading)
                .padding(.horizontal)
                .onTapGesture {
                    addPositionPresented.toggle()
                }
            VStack(spacing: screenHeight*0.015) {
                Image(.limitFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .overlay(
                        ZStack {
                            Text("Name")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                .foregroundColor(.textYellow)
                                .offset(x: -screenHeight*0.18)
                            TextField("", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.025))
                                .foregroundColor(.red)
                                .shadow(color: .black, radius: 2)
                                .frame(maxWidth: screenHeight*0.315)
                                .offset(x: screenHeight*0.06)
                        }
                    )
                Image(.limitFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .overlay(
                        ZStack {
                            Text("Amount")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                .foregroundColor(.textYellow)
                                .offset(x: -screenHeight*0.17)
                            HStack {
                                TextField("", text: $amount)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.025))
                                    .foregroundColor(.red)
                                    .shadow(color: .black, radius: 2)
                                    .frame(maxWidth: screenHeight*0.16)
                                
                                    .onChange(of: amount) { newValue in
                                        let cleaned = newValue.filter { $0.isNumber || $0 == "." }
                                        if !cleaned.isEmpty {
                                            amount = cleaned
                                        } else {
                                            amount = ""
                                        }
                                    }
                                Image(.buttonOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.02)
                                    .onTapGesture {
                                        changeUnits(direction: -1)
                                        updateUnits()
                                    }
                                RoundedRectangle(cornerRadius: screenHeight*0.01)
                                    .frame(width: screenHeight*0.07, height: screenHeight*0.037)
                                    .foregroundColor(.white)
                                    .overlay(
                                        Text(unitsArray[unitNumber])
                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.015))
                                            .foregroundColor(.red)
                                    )
                                Image(.buttonOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.02)
                                    .onTapGesture {
                                        changeUnits(direction: 1)
                                        updateUnits()
                                    }
                            }
                            .offset(x: screenHeight*0.055)
                        }
                    )
                Image(.limitFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .overlay(
                        ZStack {
                            Text("Price per unit")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                .foregroundColor(.textYellow)
                                .offset(x: -screenHeight*0.14)
                            TextField("", text: $price)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.025))
                                .foregroundColor(.red)
                                .shadow(color: .black, radius: 2)
                            
                                .onChange(of: price) { newValue in
                                    let cleaned = newValue.filter { $0.isNumber || $0 == "." }
                                    if !cleaned.isEmpty {
                                        price = "$" + cleaned
                                    } else {
                                        price = ""
                                    }
                                }
                                .padding(.horizontal,screenHeight*0.1)
                                .offset(x: screenHeight*0.09)
                        }
                    )
                ZStack {
                    Image(.categoryImageFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.44)
                    VStack {
                        Text("Category")
                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.025))
                            .foregroundColor(.textYellow)
                        HStack(spacing: screenHeight*0.025) {
                            Image(.imageFrame)
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.37)
                                .overlay(
                                    VStack {
                                        ForEach(0..<4) { index in
                                            ZStack {
                                                VStack {
                                                    Image(categoryesArray[index].image)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.05)
                                                    Text(categoryesArray[index].name)
                                                        .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                                        .foregroundColor(.red)
                                                        .shadow(color: .black, radius: 0.5)
                                                }
                                                .padding(.vertical, screenHeight*0.005)
                                                if categoryIndex == index {
                                                    Image(.redSquare)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.078)
                                                        .scaleEffect(CGFloat(1.1))
                                                    AnimateArrowLeft()
                                                        .offset(x: -screenHeight*0.065)
                                                }
                                            }
                                            .onTapGesture {
                                                selectCategory(index: index)
                                            }
                                        }
                                    }
                                )
                            Image(.imageFrame)
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.37)
                                .overlay(
                                    VStack {
                                        ForEach(4..<8) { index in
                                            ZStack {
                                                VStack {
                                                    Image(categoryesArray[index].image)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.05)
                                                    Text(categoryesArray[index].name)
                                                        .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                                        .foregroundColor(.red)
                                                        .shadow(color: .black, radius: 0.5)
                                                }
                                                .padding(.vertical, screenHeight*0.005)
                                                if categoryIndex == index {
                                                    Image(.redSquare)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.078)
                                                        .scaleEffect(CGFloat(1.1))
                                                    AnimateArrowLeft()
                                                        .offset(x: -screenHeight*0.065)
                                                }
                                            }
                                            .onTapGesture {
                                                selectCategory(index: index)
                                            }
                                        }
                                    }
                                )
                            Image(.imageFrame)
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.37)
                                .overlay(
                                    VStack {
                                        ForEach(8..<12) { index in
                                            ZStack {
                                                VStack {
                                                    Image(categoryesArray[index].image)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.05)
                                                    Text(categoryesArray[index].name)
                                                        .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                                        .foregroundColor(.red)
                                                        .shadow(color: .black, radius: 0.5)
                                                        .multilineTextAlignment(.center)
                                                }
                                                .padding(.vertical, screenHeight*0.005)
                                                if categoryIndex == index {
                                                    Image(.redSquare)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.078)
                                                        .scaleEffect(CGFloat(1.1))
                                                    AnimateArrowLeft()
                                                        .offset(x: -screenHeight*0.065)
                                                        
                                                }
                                            }
                                            .onTapGesture {
                                               selectCategory(index: index)
                                            }
                                        }
                                    }
                                )
                        }
                    }
                }
                Spacer()
                Image(.addPositionButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .onTapGesture {
                        if fromSettings {
                            addNewCategory()
                            addPositionPresented.toggle()
                        } else {
                            updateTemporaryListPosition()
                            addPositionInListPresentred.toggle()
                        }
                        
//                        UserDefaults.standard.removeObject(forKey: "templatesListArray")
                    }
                Spacer()
            }
            .offset(y: screenHeight*0.07)
        }
        
        .fullScreenCover(isPresented: $addPositionInListPresentred, content: {
            AddPositionInList(addPositionPresented: $addPositionInListPresentred, fromTamplates: .constant(false))
        })
        
        .onAppear {
            
            updatePresentedData()
        }
        
    }
    
    func updateTemporaryListPosition() {
        temporaryListPosition[1] = image
        temporaryListPosition[2] = title
        temporaryListPosition[3] = amount
        temporaryListPosition[4] = units
        temporaryListPosition[5] = price.replacingOccurrences(of: "$", with: "")
        UserDefaults.standard.setValue(temporaryListPosition, forKey: "temporaryListPosition")
    }
    
    func updatePresentedData() {
        image = templatesListArray[selectedTemplateIndex][1]
        title = templatesListArray[selectedTemplateIndex][2]
        amount  = templatesListArray[selectedTemplateIndex][3]
        units  = templatesListArray[selectedTemplateIndex][4]
        switch units {
        case "p":
            unitNumber = 0
        case "l":
            unitNumber = 1
        default:
            unitNumber = 2
        }
        price  = templatesListArray[selectedTemplateIndex][5]
        categoryIndex = categoryesArray.firstIndex(where: {$0.image == templatesListArray[selectedTemplateIndex][1] }) ?? 0
    }
    
    func addNewCategory() {
        var newElement = ["01.01.25"]
        let newPrice = String(price.dropFirst())
        image = categoryesArray[categoryIndex].image
        newElement += [image, title, amount, units, newPrice]
        templatesListArray.insert(newElement, at: 0)
        UserDefaults.standard.set(templatesListArray, forKey: "templatesListArray")
        
    }
    
    func selectCategory(index: Int) {
        categoryIndex = index
        image = categoryesArray[index].image
    }
    
    func changeUnits(direction: Int) {
        unitNumber += direction
        if unitNumber < 0 {
            unitNumber = 2
        }
        if unitNumber > 2 {
            unitNumber = 0
        }
    }
    
    func updateUnits() {
        switch unitNumber {
        case 0:
            units = "p"
        case 1:
            units = "l"
        default:
            units = "kg"
        }
    }
    
}

#Preview {
    AddNewPosition(fromSettings: .constant(true), addPositionPresented: .constant(true), selectedTemplateIndex: .constant(0))
}
