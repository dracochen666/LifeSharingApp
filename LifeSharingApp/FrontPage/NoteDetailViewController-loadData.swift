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
                print(result!["noteTitle"].stringValue)
                note.noteContent = result!["noteContent"].stringValue
                note.topics = result!["noteTopics"].stringValue
                note.subtopics = result!["noteSubtopics"].stringValue
                note.notePositions = result!["notePositions"].stringValue

                print(result!["createTime"].stringValue)

                note.createTimeStr = "编辑于: \(result!["createTime"].stringValue)"
                note.noteComments = result!["noteComments"].stringValue
                note.noteOwner = result!["noteOwner"].intValue
                note.noteLikedNumber = result!["noteLikedNumber"].intValue
                note.noteCollectedNumber = result!["noteCollectedNumber"].intValue
                let decoder = JSONDecoder()
                
                if let imageBase64 = result!["notePhotos"].string {
                    print("file")
                    let imageBase64 = NSData(base64Encoded: imageBase64)
                    let imageData = Data(referencing: imageBase64!)
//                    let photosDataArr = try? decoder.decode(Data.self, from: imageData)
                    self.note?.notePhotos = imageData
//                    for data in photosDataArr! {
//                        note.notePhotos?.append(data)
//                    }
                }
                
                
            }
            print(note.createTime)
//            print("notephotos: ",note.notePhotos)

//            self.note = note
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.titleLabel.text = note.noteTitle
                self.bodyLabel.text = note.noteContent
//                self.dateLabel.text = note.createTime
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
                self.dateLabel.text = note.createTimeStr
//                self.view.layoutIfNeeded()
                tabBarViewController.hideLoadingAni()
            }
        }
        group.leave()
//        group.notify(queue: .main) {
//            self.collectionView.reloadData()
//            self.view.layoutIfNeeded()
//            self.hideLoadingAni()
//        }
//

        return note
    }
}
