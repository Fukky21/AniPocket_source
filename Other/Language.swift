//  Language.swift

import Foundation
import UIKit

class Language {
    
    static var langName: String!
    static var homeTitle: String!
    static var watchingTitle: String!
    static var watchingAddTitle: String!
    static var logTitle: String!
    static var logAddTitle: String!
    static var watchLaterTitle: String!
    static var watchLaterAddTitle: String!
    static var dataTitle: String!
    static var settingTitle: String!
    static var title: String!
    static var start: String!
    static var end: String!
    static var fullEp: String!
    static var dayOfTheWeek: String!
    static var startTime: String!
    static var broadcaster: String!
    static var genre: String!
    static var dayOfTheWeekList: [String]!
    static var genreList: [String]!
    static var deleteAlertTitle: String!
    static var moveAlertTitleInWatchingPresent: String!
    static var moveAlertMessageInWatchingPresent: String!
    static var moveAlertTitleInWatchingPast: String!
    static var moveAlertMessageInWatchingPast: String!
    static var moveAlertTitleInWatchLater: String!
    static var moveAlertMessageInWatchLater: String!
    static var resetImgAlertTitle: String!
    static var sort: String!
    static var sortByAdd: String!
    static var sortByTitle: String!
    static var sortByStart: String!
    static var sortByEnd: String!
    static var sortByFullEp: String!
    static var sortByGenre: String!
    static var watchingViewSwitchItems: [String]!
    static var dataTabBarItemTitles: [String]!
    static var dataTVItems: [[String]]!
    static var ratioByGenre: String!
    static var settingTVItems: [String]!
    
    static func setLanguage(langName: String) {
        switch langName {
            case "english":
                Language.langName = "english"
                Language.homeTitle = "Home"
                Language.watchingTitle = "Watching"
                Language.watchingAddTitle = "Watching Add"
                Language.logTitle = "Log"
                Language.logAddTitle = "Log Add"
                Language.watchLaterTitle = "Watch Later"
                Language.watchLaterAddTitle = "Watch Later Add"
                Language.dataTitle = "Data"
                Language.settingTitle = "Setting"
                Language.title = "Title"
                Language.start = "Start date"
                Language.end = "End date"
                Language.fullEp = "Full episodes"
                Language.dayOfTheWeek = "Day of the week"
                Language.startTime = "Start time"
                Language.broadcaster = "Broadcaster"
                Language.genre = "Genre"
                Language.dayOfTheWeekList = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                Language.genreList = ["Action/Battle",
                                      "SF/Fantasy/Different World",
                                      "Comedy/Gag",
                                      "Short",
                                      "Sports/Competition",
                                      "Drama/Youth",
                                      "Everyday/Honobono",
                                      "Horror/Suspense/Mystery",
                                      "History/Military history",
                                      "War/Military",
                                      "Love/Romantic comedy",
                                      "Robot/Mechanic",
                                      "Other"]
                Language.deleteAlertTitle = "Do you want to delete?"
                Language.moveAlertTitleInWatchingPresent = "Do you want to move data to \"Log\"?"
                Language.moveAlertMessageInWatchingPresent = "Data will be removed from \"Watching(Present)\"."
                Language.moveAlertTitleInWatchingPast = "Do you want to move data to \"Log\"?"
                Language.moveAlertMessageInWatchingPast = "Data will be removed from \"Watching(Past)\"."
                Language.moveAlertTitleInWatchLater = "Do you want to move data to \"Watching(Past)\"?"
                Language.moveAlertMessageInWatchLater = "Data will be removed from \"Watch Later\"."
                Language.resetImgAlertTitle = "Do you want to initialize the image?"
                Language.sort = "Sort"
                Language.sortByAdd = "by Add"
                Language.sortByTitle = "by Title"
                Language.sortByStart = "by Start date"
                Language.sortByEnd = "by End date"
                Language.sortByFullEp = "by Episode"
                Language.sortByGenre = "by Genre"
                Language.watchingViewSwitchItems = ["Present", "Past"]
                Language.dataTabBarItemTitles = ["Various values", "Num of titles by year", "Num of titles by genre"]
                Language.dataTVItems = [["Number of titles (Present)", "Number of titles (Past)"],
                                        ["Number of titles", "Total number of episodes"],
                                        ["Number of titles"]]
                Language.ratioByGenre = "Ratio by genre"
                Language.settingTVItems = ["Basic usage", "Change theme", "Change language", "FAQ", "License", "Privacy Policy", "Contact us"]
            default:
                Language.langName = "default"
                Language.homeTitle = "ホーム"
                Language.watchingTitle = "見ているアニメ"
                Language.watchingAddTitle = "見ているアニメ 追加"
                Language.logTitle = "ログ"
                Language.logAddTitle = "ログ 追加"
                Language.watchLaterTitle = "あとで見るアニメ"
                Language.watchLaterAddTitle = "あとで見るアニメ 追加"
                Language.dataTitle = "データ"
                Language.settingTitle = "設定"
                Language.title = "タイトル"
                Language.start = "開始年月"
                Language.end = "終了年月"
                Language.fullEp = "全話数"
                Language.dayOfTheWeek = "曜日"
                Language.startTime = "開始時間"
                Language.broadcaster = "放送局"
                Language.genre = "ジャンル"
                Language.dayOfTheWeekList = ["日", "月", "火", "水", "木", "金", "土"]
                Language.genreList = ["アクション/バトル",
                                      "SF/ファンタジー/異世界",
                                      "コメディ/ギャグ",
                                      "ショート",
                                      "スポーツ/競技",
                                      "ドラマ/青春",
                                      "日常/ほのぼの",
                                      "ホラー/サスペンス/推理",
                                      "歴史/戦記",
                                      "戦争/ミリタリー",
                                      "恋愛/ラブコメ",
                                      "ロボット/メカ",
                                      "その他"]
                Language.deleteAlertTitle = "消去しますか？"
                Language.moveAlertTitleInWatchingPresent = "データを\"ログ\"に移動しますか？"
                Language.moveAlertMessageInWatchingPresent = "\"見ているアニメ(放送中)\"からは削除されます"
                Language.moveAlertTitleInWatchingPast = "データを\"ログ\"に移動しますか？"
                Language.moveAlertMessageInWatchingPast = "\"見ているアニメ(過去作品)\"からは削除されます"
                Language.moveAlertTitleInWatchLater = "データを\"見ているアニメ(過去作品)\"に移動しますか？"
                Language.moveAlertMessageInWatchLater = "\"あとで見るアニメ\"からは削除されます"
                Language.resetImgAlertTitle = "画像を初期化しますか？"
                Language.sort = "並び替え"
                Language.sortByAdd = "追加順"
                Language.sortByTitle = "タイトル順"
                Language.sortByStart = "開始年月順"
                Language.sortByEnd = "終了年月順"
                Language.sortByFullEp = "話数順"
                Language.sortByGenre = "ジャンル順"
                Language.watchingViewSwitchItems = ["放送中", "過去作品"]
                Language.dataTabBarItemTitles = ["各種数値", "年別タイトル数", "ジャンル別タイトル数"]
                Language.dataTVItems = [["タイトル数 (放送中)", "タイトル数 (過去作品)"],
                                        ["タイトル数", "総話数"],
                                        ["タイトル数"]]
                Language.ratioByGenre = "ジャンル別割合"
                Language.settingTVItems = ["基本的な使い方", "テーマ変更", "言語変更", "よくある質問", "ライセンス", "プライバシーポリシー", "お問い合わせ"]
        }
    }
    
    static func writeFullEpText(langName: String, fullEp: Int) -> String {
        switch langName {
            case "english":
                if fullEp == 1 {
                    return "1 episode"
                } else {
                    return "\(fullEp) episodes"
                }
            default:
                return "全\(fullEp)話"
        }
    }
    
    static func writeRequiredMessage(langName: String, req: String) -> String {
        switch langName {
            case "english":
                return "\"\(req)\" is required."
            default:
                return "「\(req)」の入力は必須です"
        }
    }
    
    static func writeRequiredMessage2(langName: String, req1: String, req2: String) -> String {
        switch langName {
            case "english":
                return "\"\(req1)\" and \"\(req2)\" are required."
            default:
                return "「\(req1)」と「\(req2)」の入力は必須です"
        }
    }
    
    static func writeInvalidMessage(langName: String) -> String {
        switch langName {
            case "english":
                return "\"\(Language.start!)\" and \"\(Language.end!)\" are invalid."
            default:
                return "「\(Language.start!)」と「\(Language.end!)」の入力が不正です"
        }
    }
    
    static func writeCharacterLimitMessage(langName: String, exceedingLimitItem: String, charLimit: Int) ->  String {
        switch langName {
            case "english":
                return "\"\(exceedingLimitItem)\" character limit is \(charLimit)."
            default:
                return "「\(exceedingLimitItem)」は\(charLimit)文字までです。"
        }
    }
}
