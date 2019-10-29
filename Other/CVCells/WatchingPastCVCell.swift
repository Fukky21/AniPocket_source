//  WatchingPastCVCell.swift

import UIKit

class WatchingPastCVCell: BaseCollectionViewCell {
    
    var start: String!
    var end: String!
    
    func setupCell(imgName: String?, title: String?, startYear: Int?, startMonth: Int?, endYear: Int?, endMonth: Int?, nowEp: Int?, fullEp: Int?, genre: Int?, indexPath: IndexPath) {
        determineUnit()
        
        setupImgView(imgName: imgName)
        
        setupTitleLabel(title: title)
        
        if startYear == 0 {
            start = "----.--"
        } else {
            if startMonth! < 10 {
                start = "\(startYear!).0\(startMonth!)"
            } else {
                start = "\(startYear!).\(startMonth!)"
            }
        }
        
        if endYear == 0 {
            end = "----.--"
        } else {
            if endMonth! < 10 {
                end = "\(endYear!).0\(endMonth!)"
            } else {
                end = "\(endYear!).\(endMonth!)"
            }
        }
        
        setupUpperSubLabel(text: "\(start!)   ~   \(end!)")
        
        setupMiddleSubLabel(text: "\(nowEp!) / \(fullEp!)")
        
        if genre == 0 {
            setupLowerSubLabel(text: "---")
        } else {
            setupLowerSubLabel(text: Language.genreList[genre! - 1])
        }
    
        setupEditBtn(indexPath: indexPath)
        
        setupMoveBtn(indexPath: indexPath)
    }
}
