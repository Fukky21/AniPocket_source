//  LogCVCell.swift

import UIKit

class LogCVCell: UICollectionViewCell {
    
    var yearLabel: UILabel!
    
    func setupCell(year: Int) {
        yearLabel = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: contentView.frame.width,
                                          height: contentView.frame.width))
        yearLabel.text = String(year)
        yearLabel.textColor = Theme.mainLetterColor
        yearLabel.textAlignment = .center
        
        contentView.addSubview(yearLabel)
    }
}
