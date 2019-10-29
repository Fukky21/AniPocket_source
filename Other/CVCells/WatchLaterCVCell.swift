//  WatchLaterCVCell.swift

import UIKit

class WatchLaterCVCell: BaseCollectionViewCell {
    
    var start: String!
    var end: String!
    
    func setupCell(imgName: String?, title: String?, startYear: Int?, startMonth: Int?, endYear: Int?, endMonth: Int?, fullEp: Int?, genre: Int?, indexPath: IndexPath) {
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
        
        if fullEp == 0 {
            setupMiddleSubLabel(text: "---")
        } else {
            setupMiddleSubLabel(text: Language.writeFullEpText(langName: Language.langName, fullEp: fullEp!))
        }
        
        if genre == 0 {
            setupLowerSubLabel(text: "---")
        } else {
            setupLowerSubLabel(text: Language.genreList[genre! - 1])
        }
        
        setupEditBtn(indexPath: indexPath)
        
        setupMoveBtn(indexPath: indexPath)
    }
}
