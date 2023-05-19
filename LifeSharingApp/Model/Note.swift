//
//  Note.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit

enum NoteType {
    case photoNote
    case videoNote
}
class Note: Codable {
    
    var noteId: Int?
    var notePhotos: Data?
    var noteCoverPhoto: Data?
    var noteTitle: String = ""
    var noteContent: String = ""
    var subtopics: String = ""
    var topics: String = ""
    var notePositions: String = ""
    var noteComments: String = ""
    var createTime: Date?
    
    var noteOwner: Int?
    var noteLikedNumber: Int?
    var noteCollectedNumber: Int?


}
