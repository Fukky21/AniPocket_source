//  XYMarkerView.swift

import Charts
import Foundation

class XYMarkerView: BalloonMarker {
    
    @objc open var xAxisValueFormatter: IAxisValueFormatter?
    fileprivate var yFormatter = NumberFormatter()
    
    @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                      xAxisValueFormatter: IAxisValueFormatter) {
        super.init(color: color, font: font, textColor: textColor, insets: insets)
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 0
        yFormatter.maximumFractionDigits = 0
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        setLabel(xAxisValueFormatter!.stringForValue(entry.x, axis: nil) + ": " + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!)
    }
}
