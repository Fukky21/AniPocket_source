//  BarChartFormatter.swift

import Charts
import Foundation

class BarChartFormatter: NSObject, IAxisValueFormatter {
    
    var names = [String]()
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return names[Int(value)]
    }
    
    func setValues(values: [String]) {
        self.names = values
    }
}
