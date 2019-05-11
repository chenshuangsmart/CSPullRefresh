//
//  NewsHandler.m
//  MVC-Demo
//
//  Created by chenshuang on 2019/4/16.
//  Copyright © 2019年 cs. All rights reserved.
//

#import "NewsHandler.h"

@implementation NewsHandler

+ (instancetype)shareInstance {
    static NewsHandler *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NewsHandler alloc] init];
    });
    return _instance;
}

- (NSArray *)icons {
    if (_icons == nil) {
        NSMutableArray *icons = [NSMutableArray array];
        [icons addObject:@"http://img2.imgtn.bdimg.com/it/u=1718891758,1099874998&fm=26&gp=0.jpg"];
        [icons addObject:@"http://img.zcool.cn/community/01f68156e9044c32f875520fcce16f.jpg"];
        [icons addObject:@"http://cdn.duitang.com/uploads/item/201510/02/20151002153826_EuhaZ.jpeg"];
        [icons addObject:@"http://hbimg.b0.upaiyun.com/826efe6e150b57cdbf7b212931bca5f702725a0d5e68-OtrpRK_fw658"];
        [icons addObject:@"http://img2.imgtn.bdimg.com/it/u=1590474806,2567531124&fm=26&gp=0.jpg"];
        [icons addObject:@"http://hbimg.b0.upaiyun.com/21a7721b6932c2cd72663b7398571dac817d03f9d171-fcttqZ_fw658"];
        [icons addObject:@"http://img4.imgtn.bdimg.com/it/u=1276134862,2456438544&fm=26&gp=0.jpg"];
        [icons addObject:@"http://img5.imgtn.bdimg.com/it/u=1119510787,2846938198&fm=26&gp=0.jpg"];
        [icons addObject:@"http://b-ssl.duitang.com/uploads/blog/201512/18/20151218174116_JnheE.jpeg"];
        [icons addObject:@"http://b-ssl.duitang.com/uploads/item/201706/10/20170610104733_Fyc4e.jpeg"];
        _icons = icons.copy;
    }
    return _icons;
}

- (NSArray *)imgs {
    if (_imgs == nil) {
        NSMutableArray *imgs = [NSMutableArray array];
        [imgs addObject:@"http://b-ssl.duitang.com/uploads/item/201801/19/20180119104003_gxfdt.thumb.700_0.jpeg"];
        [imgs addObject:@"http://b-ssl.duitang.com/uploads/item/201708/09/20170809202725_XPYtZ.thumb.700_0.jpeg"];
        [imgs addObject:@"http://hbimg.b0.upaiyun.com/b0c46c19483a3d43345a5cbe8ecd150ccdbdc5e31ffab9-SZBawH_fw658"];
        [imgs addObject:@"http://img3.duitang.com/uploads/item/201606/24/20160624071015_NWeVt.thumb.700_0.jpeg"];
        [imgs addObject:@"http://b-ssl.duitang.com/uploads/item/201804/23/20180423224748_m4TiK.jpeg"];
        [imgs addObject:@"http://b-ssl.duitang.com/uploads/item/201805/03/20180503114902_yCSvX.jpeg"];
        [imgs addObject:@"http://www.banbaowang.com/uploads/allimg/180928/32-1P92QI532.jpg"];
        [imgs addObject:@"http://img3.doubanio.com/view/photo/l_ratio_poster/public/p2522222464.jpg"];
        [imgs addObject:@"http://pic1.win4000.com/mobile/2018-04-20/5ad995c938278.jpg"];
        [imgs addObject:@"http://www.agri35.com/UploadFiles/img_0_22685221_4133134073_26.jpg"];
        [imgs addObject:@"http://hbimg.b0.upaiyun.com/b0c46c19483a3d43345a5cbe8ecd150ccdbdc5e31ffab9-SZBawH_fw658"];
        [imgs addObject:@"http://n.sinaimg.cn/sinacn/w531h800/20180113/9763-fyqrewh6778620.jpg"];
        [imgs addObject:@"http://b-ssl.duitang.com/uploads/item/201801/19/20180119104003_gxfdt.thumb.700_0.jpeg"];
        [imgs addObject:@"http://res.youth.cn/article_201801_17_176_5a5e9b85a6eaa.jpg"];
        [imgs addObject:@"http://5b0988e595225.cdn.sohucs.com/q_70,c_zoom,w_640/images/20171126/13a1e12eb63c44b39ab58d0f01495dba.jpeg"];
        [imgs addObject:@"http://s1.sinaimg.cn/large/006DeSQezy7g7UtCGgz0b"];
        [imgs addObject:@"http://www.desktx.com/d/file/phone/love/20180820/2cb7fb5117f57eb8e3ac27f9487415fd.jpg"];
        [imgs addObject:@"http://b-ssl.duitang.com/uploads/item/201804/19/20180419093634_CnRrx.thumb.700_0.jpeg"];
        [imgs addObject:@"http://img1.imgtn.bdimg.com/it/u=3535174064,289328435&fm=26&gp=0.jpg"];
        [imgs addObject:@"http://hbimg.b0.upaiyun.com/5ae2b7df3625988d0b203ad69df0078990c574cc171da-P3b54h_fw658"];
        _imgs = imgs.copy;
    }
    return _imgs;
}

- (NSArray *)contents {
    if (_contents == nil) {
        NSMutableArray *contents = [NSMutableArray array];
        [contents addObject:@"美国指控阿桑奇犯电脑黑客攻击罪 最高可判五年\nAI算法能“偷听”：突破伦理的“灰犀牛”并不远"];
        [contents addObject:@"苏丹国防部长宣布已逮捕总统 该国进入3个月紧急状态\n手机被偷后，女孩成功定位到小偷位置！结果她自己都惊.."];
        [contents addObject:@"印度大选拉开帷幕：迎接“大考” 莫迪连任胜算几何"];
        [contents addObject:@"兵马俑在美被损案审判引争议 美国网友：要重审狠判！\nROG发布新款电竞机械键盘 Ctrl键亮了\n再见了手机卡，中国全面开通eSIM卡，网友：好处真.."];
        [contents addObject:@"金正恩主持朝鲜七届四中全会 27次提“自力更生”\n35所高校新增“人工智能”专业，想报考就得先系统化.."];
        [contents addObject:@"美想让中国入美俄核裁条约 外交部:已为国际核裁做重要贡献"];
        [contents addObject:@"视觉中国官网无法访问 被共青团中央点名后曾道歉\n金立已成定局，谁会步入后尘，魅族尤为堪忧"];
        [contents addObject:@"肉价连降25个月后首涨,仔猪价逼近千元,猪又要“起飞”了？"];
        [contents addObject:@"故宫新院长啥来头？出身甘肃农村，误入千佛深处\n谷歌助手迎来更新 Android用户的福利来了"];
        [contents addObject:@"“996”太累了！广州发文鼓励弹性作息，一周休2.5天可能吗"];
        [contents addObject:@"赵薇涉诉案件达512起！涉案金额近6千万，庭审耗时两个多月"];
        [contents addObject:@"神操作！痔疮品牌“肛泰”借黑洞照片做营销 专家:侵权了,又一起假冒iPhone诈骗案！涉案留学生恐面临20.."];
        [contents addObject:@"范冰冰名誉权纠纷案再度胜诉！获赔8万精神损失费,佩服这位设计师，出“超丑”美图手机，网友：改名叫“..\n2019年款iPhone将标配18W快充，后置升级.."];
        [contents addObject:@"童模遭踢又曝新视频，靠网店店主联合抵制还不够,我们所熟知的太阳，它会“爆炸”吗？"];
        [contents addObject:@"信阳8岁女童之死：生前曾说“我妈对我好呢,才打我两次”\n日本面板大衰落？鸿海和夏普10 代面板厂2018 .."];
        [contents addObject:@"幼儿园要求学生拍“我家的车” 网友:没个好车都不敢生孩子\n紫米Lighting快充数据线正式开售 iPhon.."];
        [contents addObject:@"最新进展！胜利与朴寒星老公被曝疑挪用公款高达350万元,荣耀合作Vivienne Tam推出特别版Magi.."];
        [contents addObject:@"天坛奖评委首亮相,评委会主席:北京是中国电影业的核心城市"];
        [contents addObject:@"不要太累了！广州出台促进消费新政，鼓励错峰休假和弹性作息……"];
        [contents addObject:@"剧透！未来湾区内的轨道交通出行新动向，这场大会都讲到啦！"];
        _contents = contents.copy;
    }
    return _contents;
}

- (NSArray *)titles {
    if (_titles == nil) {
        NSMutableArray *titles = [NSMutableArray array];
        [titles addObject:@"首页"];
        [titles addObject:@"国内"];
        [titles addObject:@"国际"];
        [titles addObject:@"军事"];
        [titles addObject:@"财经"];
        [titles addObject:@"娱乐"];
        [titles addObject:@"体育"];
        [titles addObject:@"互联网"];
        [titles addObject:@"科技"];
        [titles addObject:@"游戏"];
        _titles = titles.copy;
    }
    return _titles;
}

- (NSArray *)subTitles {
    if (_subTitles == nil) {
        NSMutableArray *subTitles = [NSMutableArray array];
        [subTitles addObject:@"皆大欢喜、逍遥法外"];
        [subTitles addObject:@"掌上明珠、金玉良缘"];
        [subTitles addObject:@"八仙过海、相亲相爱"];
        [subTitles addObject:@"国色天香、绘声绘影"];
        [subTitles addObject:@"花花公子、簪缨世族"];
        [subTitles addObject:@"珠光宝气、卧虎藏龙"];
        [subTitles addObject:@"两小无猜、偷天换日"];
        [subTitles addObject:@"天下无双、黄道吉日"];
        [subTitles addObject:@"插翅难逃、春暖花开"];
        [subTitles addObject:@"兵临城下、满腹经纶"];
        _subTitles = subTitles.copy;
    }
    return _subTitles;
}

- (NSArray *)specialWords {
    if (_specialWords == nil) {
        NSMutableArray *subTitles = [NSMutableArray array];
        [subTitles addObject:@"@皆大欢喜"];
        [subTitles addObject:@"@掌上明珠"];
        [subTitles addObject:@"@八仙过海"];
        [subTitles addObject:@"@国色天香"];
        [subTitles addObject:@"@花花公子"];
        [subTitles addObject:@"@珠光宝气"];
        [subTitles addObject:@"@两小无猜"];
        [subTitles addObject:@"@天下无双"];
        [subTitles addObject:@"@插翅难逃"];
        [subTitles addObject:@"@兵临城下"];
        [subTitles addObject:@"@逍遥法外"];
        [subTitles addObject:@"@金玉良缘"];
        [subTitles addObject:@"@相亲相爱"];
        [subTitles addObject:@"@绘声绘影"];
        [subTitles addObject:@"@簪缨世族"];
        [subTitles addObject:@"@卧虎藏龙"];
        [subTitles addObject:@"@偷天换日"];
        [subTitles addObject:@"@黄道吉日"];
        [subTitles addObject:@"@春暖花开"];
        [subTitles addObject:@"@满腹经纶"];
        
        _specialWords = subTitles.copy;
    }
    return _specialWords;
}


- (NSArray *)links {
    if (_links == nil) {
        NSMutableArray *subTitles = [NSMutableArray array];
        [subTitles addObject:@"http://t.cn.ran"];
        [subTitles addObject:@"http://t.cn.ran.e.fdfj.fod.com"];
        [subTitles addObject:@"http://t.cn.ran34.4t5.fdifj.45.com"];
        [subTitles addObject:@"http://t.cn.rane.44.5.5.fff.e.f.com"];
        [subTitles addObject:@"http://t.cn.ranf4l4.4l4lr"];
        [subTitles addObject:@"http://t.cn.randfsfs4rffsd.s."];
        [subTitles addObject:@"http://t.cn.ran.344f.4.44f.4"];
        [subTitles addObject:@"http://t.cn.ran.e.ref.ef.ef.e"];
        [subTitles addObject:@"http://t.cn.ran.e.fe.fe.fe.fe.f.ef"];
        [subTitles addObject:@"http://t.cn.ran.e.fe.fe.f.ef.ef"];
        _links = subTitles.copy;
    }
    return _links;
}
@end
