//  WatchingPresentCVCell.swift

import Material
import UIKit

class WatchingPresentCVCell: BaseCollectionViewCell {

    func setupCell(imgName: String?, title: String?, startTime: String?, broadcaster: String?, genre: Int?, indexPath: IndexPath) {
        determineUnit()
        
        setupImgView(imgName: imgName)
        
        setupTitleLabel(title: title)
        
        if startTime == "" {
            setupUpperSubLabel(text: "--:--")
        } else {
            setupUpperSubLabel(text: startTime! + "~")
        }
        
        if broadcaster == "" {
            setupMiddleSubLabel(text: "---")
        } else {
            setupMiddleSubLabel(text: broadcaster!)
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
