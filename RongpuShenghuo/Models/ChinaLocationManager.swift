//
//  ChinaLocationManager.swift
//  KangyangDemo
//
//  Created by Ziming Qiu on 8/8/24.
//

import Foundation

class ChinaLocationManager {
    static let shared = ChinaLocationManager()
    
    let provinces = [
        "北京市", "上海市", "重庆市", "天津市",
        "广东省", "江苏省", "浙江省", "山东省", "四川省",
        "河南省", "湖北省", "湖南省", "安徽省", "河北省", "江西省", "辽宁省", "陕西省",
        "福建省", "青海省", "新疆维吾尔自治区", "西藏自治区", "内蒙古自治区", "宁夏回族自治区", "广西壮族自治区", "贵州省", "海南省", "云南省"
    ]

    let citiesByProvince = [
        "北京市": ["东城区", "西城区", "朝阳区", "海淀区", "丰台区", "石景山区", "门头沟区", "房山区", "通州区", "顺义区", "怀柔区", "平谷区", "昌平区", "大兴区", "怀柔区", "延庆区"],
        "上海市": ["黄浦区", "静安区", "浦东新区", "徐汇区", "长宁区", "虹口区", "杨浦区", "闵行区", "宝山区", "浦东新区", "奉贤区", "嘉定区", "金山区", "青浦区", "松江区", "崇明区"],
        "重庆市": ["渝中区", "江北区", "沙坪坝区", "九龙坡区", "南岸区", "北碚区", "巴南区", "渝北区", "长寿区", "江津区", "合川区", "永川区", "南川区", "黔江区", "涪陵区", "璧山区", "铜梁区"],
        "天津市": ["和平区", "河东区", "河西区", "南开区", "河北区", "红桥区", "滨海新区", "津南区", "北辰区", "武清区", "宝坻区", "静海区", "蓟县"],
        
        "广东省": ["广州", "深圳", "珠海", "汕头", "韶关", "河源", "梅州", "惠州", "汕尾", "潮州", "揭阳", "云浮"],
        "江苏省": ["南京", "苏州", "无锡", "常州", "镇江", "南通", "扬州", "盐城", "连云港", "淮安", "宿迁", "泰州", "徐州"],
        "浙江省": ["杭州", "宁波", "温州", "绍兴", "湖州", "嘉兴", "台州", "舟山", "丽水"],
        "山东省": ["济南", "青岛", "淄博", "烟台", "潍坊", "济宁", "泰安", "临沂", "德州", "聊城", "滨州", "菏泽"],
        "四川省": ["成都", "绵阳", "德阳", "自贡", "攀枝花", "泸州", "广安", "南充", "达州", "遂宁", "内江", "资阳", "雅安", "眉山", "乐山", "凉山州"],
        
        "河南省": ["郑州", "洛阳", "开封", "南阳", "平顶山", "安阳", "鹤壁", "焦作", "新乡", "濮阳", "许昌", "漯河", "三门峡", "商丘", "信阳", "周口", "驻马店"],
        "湖北省": ["武汉", "黄石", "十堰", "荆州", "宜昌", "襄阳", "鄂州", "荆门", "黄冈", "咸宁", "随州", "恩施", "仙桃", "潜江", "天门", "神农架"],
        "湖南省": ["长沙", "株洲", "湘潭", "岳阳", "常德", "张家界", "益阳", "郴州", "永州", "怀化", "娄底", "湘西州"],
        "安徽省": ["合肥", "芜湖", "蚌埠", "安庆", "马鞍山", "淮南", "淮北", "铜陵", "宣城", "黄山", "池州", "亳州"],
        "河北省": ["石家庄", "唐山", "邯郸", "保定", "张家口", "承德", "沧州", "廊坊", "衡水"],
        "江西省": ["南昌", "九江", "景德镇", "赣州", "萍乡", "新余", "鹰潭", "上饶", "宜春", "抚州", "吉安"],
        "辽宁省": ["沈阳", "大连", "鞍山", "抚顺", "本溪", "丹东", "锦州", "营口", "阜新", "辽阳", "盘锦", "铁岭", "朝阳", "葫芦岛"],
        "陕西省": ["西安", "咸阳", "铜川", "渭南", "延安", "汉中", "榆林", "安康", "商洛"],
        
        "福建省": ["福州", "厦门", "泉州", "漳州", "龙岩", "三明", "南平", "宁德"],
        "青海省": ["西宁", "格尔木", "德令哈", "玉树", "海东", "海北", "海南", "黄南", "果洛", "海西"],
        "新疆维吾尔自治区": ["乌鲁木齐", "喀什", "克拉玛依", "吐鲁番", "哈密", "和田", "阿克苏", "喀什", "巴音郭楞", "昌吉", "博尔塔拉", "伊犁", "塔城", "阿勒泰"],
        "西藏自治区": ["拉萨", "日喀则", "林芝", "昌都", "山南", "那曲", "阿里"],
        "内蒙古自治区": ["呼和浩特", "包头", "鄂尔多斯", "呼伦贝尔", "乌兰察布", "兴安盟", "锡林郭勒盟", "阿拉善盟"],
        "宁夏回族自治区": ["银川", "石嘴山", "吴忠", "中卫"],
        "广西壮族自治区": ["南宁", "桂林", "柳州", "梧州", "北海", "防城港", "钦州", "贵港", "玉林", "百色", "贺州", "河池", "来宾", "崇左"],
        "贵州省": ["贵阳", "遵义", "安顺", "毕节", "铜仁", "六盘水", "黔西南", "黔东南", "黔南"],
        "海南省": ["海口", "三亚", "三沙", "陵水", "儋州", "琼海", "文昌", "万宁", "东方", "五指山", "定安", "屯昌", "澄迈", "临高", "白沙", "昌江", "乐东", "保亭", "琼中"],
        "云南省": ["昆明", "大理", "丽江", "曲靖", "玉溪", "昭通", "楚雄", "红河", "文山", "西双版纳", "普洱", "临沧"]
    ]

    
    private init() {} // Prevent external initialization
}
