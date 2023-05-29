//
//  Constant-Topic.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit

//SubTopic例子
let kTopicsExample: [String] = ["美食", "摄影", "音乐", "游戏", "风景"]
//let kTopics: [String] = ["游戏"]

let kSubTopicsExample: [String:[String]] = [
    "美食":["意式咖啡","冰美式","卡布奇诺","鸡尾酒", "威士忌", "蛋糕"],
    "摄影":["相机","胶片","拍立得"],
    "音乐":["流行音乐","乡村音乐","华语音乐"],
    "游戏":["Overwatch"],
    "风景":["山景","海景","夜景","奥地利"]]

let kTopics: Topic = Topic(topics: kTopicsExample, subTopics: kSubTopicsExample)

//正文空间placeholder
let kContentTextViewPlaceholder: String = "正文"

//话题选择数量
let kSubTopicLimit = 1
