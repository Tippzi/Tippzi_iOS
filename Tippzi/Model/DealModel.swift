
import Foundation

struct DealModel {
    var deal_name        : String?
    var deal_description : String?
    var deal_quantity    : String? 
    var deal_duration    : String?
    var monday           : String?
    var tuesday          : String?
    var wednesday        : String?
    var thursday         : String?
    var friday           : String?
    var saturday         : String?
    var sunday           : String?
    
    var deal_name1        : String?
    var deal_description1 : String?
    var deal_quantity1    : String?
    var deal_duration1    : String?
    var monday1           : String?
    var tuesday1          : String?
    var wednesday1       : String?
    var thursday1         : String?
    var friday1           : String?
    var saturday1         : String?
    var sunday1           : String?

    var add_deal_flag : Int = 0
    var flag : Int = 0
    var all_days_flag : Bool = false
    
    init(){
        deal_name = ""
        deal_description = ""
        deal_quantity = ""
        deal_duration = ""
        monday = ""
        tuesday = ""
        wednesday = ""
        thursday = ""
        friday = ""
        saturday = ""
        sunday = ""
        deal_name1 = ""
        deal_description1 = ""
        deal_quantity = ""
        deal_duration1 = ""
        monday1 = ""
        tuesday1 = ""
        wednesday1 = ""
        thursday1 = ""
        friday1 = ""
        saturday1 = ""
        sunday1 = ""
    }
}
