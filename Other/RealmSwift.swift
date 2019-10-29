//  RealmSwift.swift

import Foundation
import RealmSwift

// themeName: default, simple, lovely-candy, happy-bitter, nature, rock-mode, deep-ocean, ice, sunset
// langName: default, english
class SettingData: Object {
    @objc dynamic var themeName = "default"
    @objc dynamic var langName = "default"
}

// status: present, past, later, log
// genre:   0 (Nothing)
//          1 (Action/Battle)
//          2 (SF/Fantasy/Different World)
//          3 (Comedy/Gag)
//          4 (Short)
//          5 (Sports/Competition)
//          6 (Drama/Youth)
//          7 (Everyday/Honobono)
//          8 (Horror/Suspense/Mystery)
//          9 (History/Military history)
//         10 (War/Military)
//         11 (Love/Romantic comedy)
//         12 (Robot/Mechanic)
//         13 (Other)
class AnimeData: Object {
    @objc dynamic var status = ""
    @objc dynamic var title = ""
    @objc dynamic var imgName = ""
    @objc dynamic var startYear = 0
    @objc dynamic var startMonth = 0
    @objc dynamic var endYear = 0
    @objc dynamic var endMonth = 0
    @objc dynamic var fullEp = 0
    @objc dynamic var nowEp = 0
    @objc dynamic var dayOfTheWeek = ""
    @objc dynamic var startTime = ""
    @objc dynamic var broadcaster = ""
    @objc dynamic var genre = 0
    @objc dynamic var registeredTime = ""
}

class NumOfLogAnime: Object {
    @objc dynamic var year = 0
    @objc dynamic var num = 0
}
