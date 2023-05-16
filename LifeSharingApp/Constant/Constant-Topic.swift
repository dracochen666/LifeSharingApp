//
//  Constant-Topic.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/4/6.
//

import UIKit

//SubTopic例子
let kTopicsExample: [String] = ["美食", "汽车", "音乐", "游戏", "风景"]
//let kTopics: [String] = ["游戏"]

let kSubTopicsExample: [String:[String]] = [
    "美食":["# 意式咖啡","# 冰美式","# 卡布奇诺","# 鸡尾酒", "# 苏格兰威士忌", "# 波本威士忌", "蛋糕"],
    "汽车":["# 法拉利","# 兰博基尼","# 保时捷"],
    "音乐":["# 流行音乐","# 乡村音乐","# 华语音乐"],
    "游戏":["# 守望先锋","# WarThunder"],
    "风景":["# 山景","# 海景","# 奥地利"]]

let kTopics: Topic = Topic(topics: kTopicsExample, subTopics: kSubTopicsExample)

//正文空间placeholder
let kContentTextViewPlaceholder: String = "输入正文"

//话题选择数量
let kSubTopicLimit = 3
