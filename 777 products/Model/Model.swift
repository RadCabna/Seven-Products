//
//  Model.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import Foundation

struct BarButton {
    var name: String
    var text: String
}

class Arrays {
    
    static var barButtons = [
        BarButton(name: "botBarHome", text: "Home"),
        BarButton(name: "botBarList", text: "List"),
        BarButton(name: "botBarStatistic", text: "Statictic"),
        BarButton(name: "botBarSettings", text: "Settings")
    ]
    
    static var settingsBGArray = ["setBG1","setBG2","setBG3","setBG4",]
}

//["botBarHome", "botBarList", "botBarStatictic", "botBarSettings"]
