//
//  NoteWaterFall-loadData.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/5/10.
//

import UIKit
import CoreData

extension NoteWaterFallView {
    
    func getDraftNotes() {
        let fetchRequest = DraftNote.fetchRequest() as! NSFetchRequest<DraftNote>
        //设置分页 每次刷新增加5
        fetchRequest.fetchLimit = 20
        fetchRequest.fetchOffset = 0
        //设置筛选
//        fetchRequest.predicate = NSPredicate(format: "title=%@", "风景")
        let draftNotes = try? context.fetch(fetchRequest)
        self.drafts = draftNotes!
    }

    
}
