//
//  NoteDetailViewController-loadData.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/19.
//

import Foundation
import Alamofire
import Anchorage
import SwiftyJSON

extension NoteDetailViewController {
    
    func getNoteById(_ noteId: Int) -> Note{
        let group = DispatchGroup()

        group.enter()

        var note: Note = Note()
        AF.request(kUrlGetNoteById+"?noteId=\(noteId)",
                   method: .get,
                   headers: headers).responseDecodable(of: Note.self) { response in
            if let data = response.data {
                let result = try? JSON(data: data )
                note.noteTitle = result!["noteTitle"].stringValue
                note.noteContent = result!["noteContent"].stringValue
                note.noteTopics = result!["noteTopics"].stringValue
                note.noteSubTopics = result!["noteSubtopics"].stringValue
                note.notePositions = result!["notePositions"].stringValue
                
                note.createTimeStr = "编辑于: \(result!["createTime"].stringValue)"
                note.noteComments = result!["noteComments"].stringValue
                note.noteOwner = result!["noteOwner"].intValue
                note.noteLikedNumber = result!["noteLikedNumber"].intValue
                
                let decoder = JSONDecoder()
                
                if let imageBase64 = result!["notePhotos"].string {
                    let imageBase64 = NSData(base64Encoded: imageBase64)
                    let imageData = Data(referencing: imageBase64!)
                    self.note?.notePhotos = imageData

                }
                
                
            }
            print(note.createTime)

            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.titleLabel.text = note.noteTitle
                self.bodyLabel.text = note.noteContent

                self.dateLabel.text = note.createTimeStr
                self.userIdLabel.text = "用户ID：" + (note.noteOwner?.description ?? "未知ID")
//                self.view.layoutIfNeeded()
                tabBarViewController.hideLoadingAni()
            }
        }
        group.leave()

        return note
    }
    
    func getNoteCommentById(noteId: Int) {
        AF.request(kUrlGetCommentsByNoteId+"?noteId=\(noteId)",
                   method: .get,
                   headers: headers).response { response in
            if let data = response.data, let result = try? JSON(data: data) {
                for comment in result.arrayValue {
                    
                    let userId = comment["commentUserId"].intValue
                    let noteId = comment["commentNoteId"].intValue
                    let commentContent = comment["commentContent"].stringValue
                    
                    let comment = NoteComment(commentUserId: userId, commentNoteId: noteId, comment: commentContent)
                    
                    self.noteComments.append(comment)
                    
                }
                self.commentTableView.reloadData()
            }
        }
    }
}
