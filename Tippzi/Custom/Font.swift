//
//  Font.swift
//  Tippzi
//
//  Created by Admin on 11/20/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

struct Font {
    var button_size : CGFloat = 0
    var bar_name_size : CGFloat = 0
    var deal_name_size : CGFloat = 0
    var comment_size : CGFloat = 0
    var description_size : CGFloat = 0
    var edit_box_size : CGFloat = 0
    var small_comment_size : CGFloat = 0
    var big_comment_size : CGFloat = 0
    var sub_button_size : CGFloat = 0
    var title_size : CGFloat = 0
    var count_size : CGFloat = 0
    var bottom_labelfont : CGFloat = 0
    var scale_value : Int = 0
    var open_time : CGFloat = 0
    init(_ button_size: CGFloat, _ bar_name_size : CGFloat, _ deal_name_size : CGFloat, _ comment_size : CGFloat, _ description_size: CGFloat, _ edit_box_size : CGFloat, _ small_comment_size : CGFloat, _ big_comment_size : CGFloat, _ sub_button_size: CGFloat, _ title_size : CGFloat, _ count_size : CGFloat, _ bottom_labelfont: CGFloat, _ scale_value : Int, _ open_time : CGFloat) {
        self.button_size = button_size
        self.bar_name_size = bar_name_size
        self.deal_name_size = deal_name_size
        self.comment_size = comment_size
        self.description_size = description_size
        self.edit_box_size = edit_box_size
        self.small_comment_size = small_comment_size
        self.big_comment_size = big_comment_size
        self.sub_button_size = sub_button_size
        self.title_size = title_size
        self.count_size = count_size
        self.bottom_labelfont = bottom_labelfont
        self.scale_value = scale_value
        self.open_time = open_time
    }
}
