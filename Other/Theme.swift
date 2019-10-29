//  Theme.swift

import Foundation
import UIKit

class Theme {
    
    static var themeName: String!
    static var navigationbarBarTintColor: UIColor!
    static var baseColor: UIColor!
    static var baseLetterColor: UIColor!
    static var mainColor: UIColor!
    static var mainLetterColor: UIColor!
    static var accentColor: UIColor!
    static var tintColor: UIColor!
    static var grayColor: UIColor!
    
    static func setTheme(themeName: String) {
        switch themeName {
            case "simple":
                Theme.themeName = "simple"
                Theme.navigationbarBarTintColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                Theme.baseColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
                Theme.mainColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                Theme.accentColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
                Theme.tintColor = UIColor(red: 76/255, green: 229/255, blue: 25/255, alpha: 1)
                Theme.grayColor = .gray
            case "lovely-candy":
                Theme.themeName = "lovely-candy"
                Theme.navigationbarBarTintColor = UIColor(red: 240/255, green: 101/255, blue: 156/255, alpha: 1)
                Theme.baseColor = UIColor(red: 245/255, green: 141/255, blue: 182/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
                Theme.mainColor = UIColor(red: 129/255, green: 252/255, blue: 173/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
                Theme.accentColor = UIColor(red: 255/255, green: 0/255, blue: 132/255, alpha: 1)
                Theme.tintColor = UIColor(red: 93/255, green: 5/255, blue: 233/255, alpha: 1)
                Theme.grayColor = .gray
            case "happy-bitter":
                Theme.themeName = "happy-bitter"
                Theme.navigationbarBarTintColor = UIColor(red: 243/255, green: 206/255, blue: 21/255, alpha: 1)
                Theme.baseColor = UIColor(red: 247/255, green: 221/255, blue: 80/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
                Theme.mainColor = UIColor(red: 83/255, green: 97/255, blue: 122/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                Theme.accentColor = UIColor(red: 161/255, green: 106/255, blue: 254/255, alpha: 1)
                Theme.tintColor = UIColor(red: 160/255, green: 143/255, blue: 213/255, alpha: 1)
                Theme.grayColor = .gray
            case "nature":
                Theme.themeName = "nature"
                Theme.navigationbarBarTintColor = UIColor(red: 191/255, green: 156/255, blue: 119/255, alpha: 1)
                Theme.baseColor = UIColor(red: 202/255, green: 173/255, blue: 141/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                Theme.mainColor = UIColor(red: 117/255, green: 130/255, blue: 90/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                Theme.accentColor = UIColor(red: 197/255, green: 79/255, blue: 31/255, alpha: 1)
                Theme.tintColor = UIColor(red: 241/255, green: 131/255, blue: 85/255, alpha: 1)
                Theme.grayColor = .gray
            case "rock-mode":
                Theme.themeName = "rock-mode"
                Theme.navigationbarBarTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
                Theme.baseColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 237/255, green: 76/255, blue: 124/255, alpha: 1)
                Theme.mainColor = UIColor(red: 237/255, green: 76/255, blue: 124/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
                Theme.accentColor = UIColor(red: 237/255, green: 70/255, blue: 48/255, alpha: 1)
                Theme.tintColor = UIColor(red: 86/255, green: 180/255, blue: 44/255, alpha: 1)
                Theme.grayColor = .lightGray
            case "deep-ocean":
                Theme.themeName = "deep-ocean"
                Theme.navigationbarBarTintColor = UIColor(red: 1/255, green: 11/255, blue: 54/255, alpha: 1)
                Theme.baseColor = UIColor(red: 2/255, green: 15/255, blue: 73/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 214/255, green: 30/255, blue: 61/255, alpha: 1)
                Theme.mainColor = UIColor(red: 6/255, green: 33/255, blue: 166/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 214/255, green: 30/255, blue: 61/255, alpha: 1)
                Theme.accentColor = UIColor(red: 255/255, green: 221/255, blue: 49/255, alpha: 1)
                Theme.tintColor = UIColor(red: 214/255, green: 30/255, blue: 61/255, alpha: 1)
                Theme.grayColor = .lightGray
            case "ice":
                Theme.themeName = "ice"
                Theme.navigationbarBarTintColor = UIColor(red: 91/255, green: 214/255, blue: 173/255, alpha: 1)
                Theme.baseColor = UIColor(red: 142/255, green: 227/255, blue: 200/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 96/255, green: 49/255, blue: 98/255, alpha: 1)
                Theme.mainColor = UIColor(red: 96/255, green: 49/255, blue: 98/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                Theme.accentColor = UIColor(red: 21/255, green: 95/255, blue: 207/255, alpha: 1)
                Theme.tintColor = UIColor(red: 247/255, green: 72/255, blue: 25/255, alpha: 1)
                Theme.grayColor = .gray
            case "sunset":
                Theme.themeName = "sunset"
                Theme.navigationbarBarTintColor = UIColor(red: 38/255, green: 7/255, blue: 13/255, alpha: 1)
                Theme.baseColor = UIColor(red: 59/255, green: 12/255, blue: 20/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 193/255, green: 150/255, blue: 120/255, alpha: 1)
                Theme.mainColor = UIColor(red: 193/255, green: 150/255, blue: 120/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 39/255, green: 40/255, blue: 24/255, alpha: 1)
                Theme.accentColor = UIColor(red: 212/255, green: 72/255, blue: 62/255, alpha: 1)
                Theme.tintColor = UIColor(red: 170/255, green: 110/255, blue: 12/255, alpha: 1)
                Theme.grayColor = .lightGray
            default:
                Theme.themeName = "default"
                Theme.navigationbarBarTintColor = UIColor(red: 19/255, green: 21/255, blue: 33/255, alpha: 1)
                Theme.baseColor = UIColor(red: 33/255, green: 37/255, blue: 58/255, alpha: 1)
                Theme.baseLetterColor = UIColor(red: 242/255, green: 242/255, blue: 244/255, alpha: 1)
                Theme.mainColor = UIColor(red: 69/255, green: 78/255, blue: 125/255, alpha: 1)
                Theme.mainLetterColor = UIColor(red: 242/255, green: 242/255, blue: 244/255, alpha: 1)
                Theme.accentColor = UIColor(red: 200/255, green: 217/255, blue: 45/255, alpha: 1)
                Theme.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
                Theme.grayColor = .lightGray
        }
    }
}
