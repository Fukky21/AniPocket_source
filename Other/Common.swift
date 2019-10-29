//  Common.swift

import Foundation
import Material
import TextFieldEffects
import UIKit

let dayOfTheWeekList = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

extension UIScrollView {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}

extension HoshiTextField {
    
    func setupHoshiTF(placeholder: String) {
        self.borderInactiveColor = Theme.grayColor
        self.borderActiveColor = Theme.accentColor
        self.placeholderColor = Theme.grayColor
        self.placeholderFontScale = 0.6
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : Theme.grayColor])
        self.textColor = Theme.baseLetterColor
        self.font = .systemFont(ofSize: 20)
    }
}

struct SendAnimeData {
    var title: String = ""
    var imgName: String = ""
    var startYear: Int = 0
    var startMonth: Int = 0
    var endYear: Int = 0
    var endMonth: Int = 0
    var fullEp: Int = 0
    var nowEp: Int = 0
    var dayOfTheWeek: String = ""
    var startTime: String = ""
    var broadcaster: String = ""
    var genre: Int = 0
    var registeredTime: String = ""
}
