//
//  LFPoem+LFStorage.m
//  LFPoems
//
//  Created by Xiangconnie on 2018/9/22.
//  Copyright © 2018年 HUST. All rights reserved.
//

#import "LFPoem+LFStorage.h"
#import "LFPoemsDatabaseHelper.h"
#import "LFPoet.h"

NSString * const kTablePoems = @"poem";
NSString * const kColumnModelID = @"id";
NSString * const kColumnModelTitle = @"title";
NSString * const kColumnModelAuthor = @"author";
NSString * const kColumnModelContent = @"txt";
NSString * const kColumnModelIsFavorite = @"favorite";
NSString * const kColumnModelIsRecommended = @"recommended";
NSString * const kColumnModelType = @"type";
NSString * const kColumeModelTags = @"tags";
// 代码自动格式化:  快捷键：. ctrl+ i

@implementation LFPoem (LFStorage)

+ (instancetype)instanceFromCursor:(FMResultSet *)result {
    if (nil == result) {
        return nil;
    }
    
    // TODO: Organize the data better.
    LFPoem *model = [[LFPoem alloc] init];
    model.poemId = [[result stringForColumn:kColumnModelID] integerValue];
    NSString *title = [result stringForColumn:kColumnModelTitle];
    NSArray *titleArray = [title componentsSeparatedByString:@" "];
    if (titleArray.count == 2) {
        model.title = [self isNumber:titleArray[1]] ? title : titleArray[1];
    } else {
        model.title = title;
    }
    NSString *authorName = [result stringForColumn:kColumnModelAuthor];
    NSString *content = [result stringForColumn:kColumnModelContent];
    LFPoet *poet = [[LFPoet alloc] init];
    poet.name = authorName;
    model.poet = poet;
    model.content = content;
    model.isFavorite = [result boolForColumn:kColumnModelIsFavorite];
    model.isRecommended = [result boolForColumn:kColumnModelIsRecommended];
    model.type = [result intForColumn:kColumnModelType];
    
    return model;
}

// 首页. 数据库升级完毕后用精选诗来代替.
+ (NSDictionary<NSString *, NSArray *> *)lf_loadPoems {
    // 用李白的诗来做测试
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE author = '李白' OR author = '杜甫'", kTablePoems];
    return [self loadPoemsDicWithSql:sql];
}

// 全部诗.
+ (NSArray *)lf_loadAllPoems {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", kTablePoems];
    return [self loadPoemsWithSql:sql];
}

// 搜索. 用于全唐诗页面.
+ (NSArray *)lf_searchPoems:(NSString *)searchTerm {
    if (searchTerm.length == 0) {
        return [self lf_loadAllPoems];
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE author = '%@' OR title LIKE '%@%@%@'", kTablePoems, searchTerm, @"%", searchTerm, @"%"];
    return [self loadPoemsWithSql:sql];
}

// 将来用于首页精选诗歌
+ (NSArray *)lf_loadRecommendedPoems {
    NSString *sql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE recommended = 1", kTablePoems];
    return [self loadPoemsWithSql:sql];
}

// 每日随机推荐的诗. 一定是从精选中挑一首.
+ (NSArray *)lf_loadRandomPoems {
    return [self lf_loadRecommendedPoems];
}

// 收藏的诗
+ (NSArray *)lf_loadFavoritePoems {
    NSString *sql =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE favorite = 1", kTablePoems];
    return [self loadPoemsWithSql:sql];
}

- (BOOL)lf_markAsFavorite:(BOOL)isFavorite {
    if (!(self.isFavorite ^ isFavorite)) {
        NSLog(@"Unnecessary to update database");
        return YES;
    }
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET favorite = %@ WHERE id = %@", kTablePoems, isFavorite ? @"1": @"0", @(self.poemId)];
    [LF_POEMS_DB executeUpdate:sql];
    self.isFavorite = isFavorite;
    return YES;
}

// 这个功能不开放给用户. 用于我自己来设置数据库用.
- (BOOL)lf_markAsRecommended:(BOOL)isRecommended {
    if (self.isRecommended ^ isRecommended) {
        NSLog(@"Unnecessary to update database");
        return YES;
    }
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET recommended = %@ WHERE id = %@", kTablePoems, isRecommended ? @"1": @"0", @(self.poemId)];
    [LF_POEMS_DB executeUpdate:sql];
    self.isRecommended = isRecommended;
    return NO;
    
    /*
     // 五绝
     UPDATE poem SET recommended = 1, type= 1 WHERE title = '行宫'
     OR title = '登鹳雀楼'
     OR title = '新嫁娘词'
     OR title = '相思'
     OR (title = '杂诗' AND author = '王维')
     OR title = '鹿柴'
     OR title = '竹里馆'
     OR title = '山中送别'
     OR title = '问刘十九'
     OR title = '哥舒歌'
     OR title = '静夜思'
     OR title = '怨情'
     OR title = '登乐游原'
     OR title = '听筝'
     OR title = '玉台体'
     OR title = '送上人'
     OR title = '听弹琴'
     OR title = '送灵澈上人'
     OR title = '送崔九'
     OR title = '寻隐者不遇'
     OR (title = '宫词' AND author = '张祜') // TODO: Update this
     OR title = '终南望余雪'
     OR title = '秋夜寄邱员外'
     OR title = '江雪'
     OR title = '春怨'
     OR title = '春晓'
     OR title = '宿建德江'
     OR title = '八阵图'
     OR title = '渡汉江'
     
     // 七绝
     UPDATE poem SET recommended = 1, type= 2 WHERE title = '江南逢李龟年'
     OR title = '为有'
     OR title LIKE '%出塞%' AND author = '王昌龄'
     OR title = '寄令狐郎中'
     OR title = '夜雨寄北'
     OR (title = '嫦娥' AND author = '李商隐')
     OR title = '瑶池'
     OR title = '隋宫'
     OR title = '贾生'
     OR title = '夜上受降城闻笛'
     OR title = '早发白帝城'
     OR title = '黄鹤楼送孟浩然之广陵'
     OR title = '逢入京使'
     OR title = '近试上张水部'
     OR title = '宫中词'
     OR title = '后宫词'
     OR title = '凉州词'
     OR title = '九月九日忆山东兄弟'
     OR title = '春宫曲'
     OR title = '闺怨'
     OR title = '芙蓉楼送辛渐'
     OR title = '宫词'
     OR title = '已凉'
     OR title = '寒食'
     OR title = '马嵬坡'
     OR title = '春词'
     OR title = '乌衣巷'
     OR title = '春怨'
     OR title = '月夜'
     OR title = '瑶瑟怨'
     OR title = '回乡偶书'
     OR title = '杂诗'
     OR title = '陇西行'
     OR title = '枫桥夜泊'
     OR title = '集灵台·其二'
     OR title = '集灵台·其一'
     OR title = '赠内人'
     OR title = '题金陵渡'
     OR title = '寄人'
     OR title = '桃花溪'
     OR title = '滁州西涧'
     OR title = '金陵图'
     OR title = '征人怨'
     OR title = '泊秦淮'
     OR title = '赤壁'
     OR title = '将赴吴兴登乐游原一绝'
     OR title = '秋夕'
     OR title = '遣怀'
     OR title = '寄扬州韩绰判官'
     OR title = '金谷园'
     OR title = '赠别·其二'
     OR title = '赠别·其一'
     
     // 五律
     UPDATE poem SET recommended = 1, type= 3 WHERE title = '月夜'
     OR title = '天末怀李白'
     OR title = '月夜忆舍弟'
     OR title = '至德二载甫自京金光门'
     OR title = '旅夜书怀'
     OR title = '别房太尉墓'
     OR title = '奉济驿重送严公四韵'
     OR title = '登岳阳楼'
     OR title = '落花'
     OR title = '风雨'
     OR title = '蝉'
     OR title = '北青萝'
     OR title = '凉思'
     OR title = '喜见外弟又言别'
     OR title = '送友人'
     OR title = '渡荆门送别'
     OR title = '赠孟浩然'
     OR title = '夜泊牛渚怀古'
     OR title = '听蜀僧浚弹琴'
     OR title = '寄左省杜拾遗'
     OR title = '题大庾岭北驿'
     OR title = '赋得古原草送别'
     OR title = '贼平后送人北归'
     OR title = '喜外弟卢纶见宿'
     OR title = '云阳馆与韩绅宿别'
     OR title = '次北固山下'
     OR title = '归嵩山作'
     OR title = '山居秋暝'
     OR title = '辋川闲居赠裴秀才迪'
     OR title = '过香积寺'
     OR title = '酬张少府'
     OR title = '终南山'
     OR title = '终南别业'
     OR title = '汉江临眺'
     OR title = '送梓州李使君'
     OR title = '送杜少府之任蜀州'
     OR title = '送李端'
     OR title = '阙题'
     OR title = '蜀先主庙'
     OR title = '饯别王十一南游'
     OR title = '送李中丞归汉阳别业'
     OR title = '秋日登吴公台上寺远眺'
     OR title = '新年作'
     OR title = '寻南溪常道士'
     OR title = '寻陆鸿渐不遇'
     OR title = '送人东游'
     OR title = '早秋'
     OR title = '秋日赴阙题潼关驿楼'
     OR title = '没蕃故人'
     OR title = '书边事'
     OR title = '望月怀远'
     OR title = '题破山寺后禅院'
     OR title = '孤雁'
     OR title = '除夜有怀'
     OR title = '楚江怀古三首·其一'
     OR title = '灞上秋居'
     OR title = '经邹鲁祭孔子而叹之'
     OR title = '赋得暮雨送李曹'
     OR title = '淮上喜会梁州故人'
     OR title = '章台夜思'
     OR title = '宴梅道士山房'
     OR title = '与诸子登岘山'
     OR title = '望洞庭湖赠张丞相'
     OR title = '秦中寄远上人'
     OR title = '过故人庄'
     OR title = '岁暮归南山'
     OR title = '早寒有怀'
     OR title = '留别王维'
     OR title = '宿桐庐江寄广陵旧游'
     OR title = '杂诗三首·其三'
     OR title = '和晋陵陆丞早春游望'
     OR title = '春宫怨'
     OR title = '旅宿'
     OR title = '春宿左省'
     OR title = '春望'
     OR title = '月夜'
     OR title = '酬程延秋夜即事见赠'
     OR title = '江乡故人偶集客舍'
     OR title = '在狱咏蝉'
     OR title = '谷口书斋寄杨补阙'
     OR title = '送僧归日本'
     OR title = '送李端'
     OR title = '月夜'
     
     // 七律
//     TODO
     UPDATE poem SET recommended = 1, type= 4 WHERE title = '长沙过贾谊宅'
     OR title = '江州重别薛六柳'
     OR title = '苏武庙'
     OR title = '利州南渡'
     OR (title LIKE '%无题%' AND author = '李商隐')
     OR title = '行经华阴'
     OR title = '登黄鹤楼'
     OR title = '九日登望仙台呈刘明府'
     OR title = '送李少府贬峡中王少府贬'
     OR title = '贫女'
     OR title = '望蓟门'
     OR title = '寄李儋元锡'
     OR title = '春思'
     OR title = '登柳州城楼寄漳汀封连四州'
     OR title = '野望'
     OR title = '客至'
     OR title = '蜀相'
     OR title = '登楼'
     OR title = '登高'
     OR title = '闻官军收河南河北'
     OR title = '阁夜'
     OR title = '宿府'
     OR (title LIKE '%咏怀古迹%' AND author = '杜甫')
     OR title = '送魏万之京'
     OR title = '隋宫'
     OR title = '锦瑟'
     OR title = '筹笔驿'
     OR title = '春雨'
     OR (title = '无题' AND author = '李商隐')
     OR title = '无题·重帏深下莫愁堂'
     OR title = '登金陵凤凰台'
     OR title = '奉和中书舍人贾至早朝'
     OR title = '望月有感'
     OR title = '积雨辋川庄作'
     OR title = '奉和圣制从蓬莱向兴庆阁道'
     OR title = '和贾至舍人早朝大明宫'
     OR title = '赠郭给事'
     OR title = '遣悲怀三首·其三'
     OR title = '遣悲怀三首·其二'
     OR title = '遣悲怀三首·其一'
     OR title LIKE '%遣悲怀三首%'
     OR title = '长沙过贾谊宅'
     OR title = '江州重别薛六柳'
     OR title = '苏武庙'
     OR title = '利州南渡'
     OR title = '行经华阴'
     OR title = '登黄鹤楼'
     OR title = '九日登望仙台呈刘明府'
     OR title = '同题仙游观'
     OR title = '宫词'
     OR title = '赠阙下裴舍人'
     OR title = '晚次鄂州'
     OR title = '西塞山怀古'
     OR title = '自夏口至鹦鹉洲夕望岳阳'
     OR title = '九日登望仙台呈刘明府'
     
     // 五言古诗
     UPDATE poem SET recommended = 1, type= 5 WHERE title = '春泛若耶溪'
     OR (title LIKE '%感遇%' AND title = '张九龄')
     OR title = '宿王昌龄隐居'
     OR title = '寄全椒山中道士'
     OR title = '初发扬子寄元大校书'
     OR title = '郡斋雨中与诸文士燕集'
     OR title = '东郊'
     OR title = '夕次盱眙县'
     OR title = '长安遇冯著'
     OR title = '送杨氏女'
     OR title = '溪居'
     OR title = '晨诣超师院读禅经'
     OR title = '寻西山隐者不遇'
     OR title = '宿业师山房待丁大不至'
     OR title = '夏日南亭怀辛大'
     OR title = '秋登兰山寄张五'
     OR title = '佳人'
     OR title = '赠卫八处士'
     OR title = '望岳'
     OR (title LIKE '%梦李白%' AND author = '杜甫')
     OR title = '春思'
     OR (title LIKE '%月下独酌%' AND author = '李白')
     OR title = '下终南山过斛斯山人宿置酒'
     OR title = '与高适薛据同登慈恩寺'
     OR title = '青溪'
     OR title = '送綦毋潜落第还乡'
     OR title = '送别'
     OR title = '西施咏'
     OR title = '渭川田家'
     OR title = '同从弟销南斋玩月忆山阴'
     OR title = '贼退示官吏'
     
     // view-source:https://www.gushiwen.org/gushi/tangshi.aspx
     // http://www.diyifanwen.com/
     // 七言古诗
     UPDATE poem SET recommended = 1, type= 6 WHERE title = '石鱼湖上醉歌'
     OR title = '长恨歌'
     OR title = '琵琶行'
     OR title = '走马川行奉送封大夫出师'
     OR title = '轮台歌奉送封大夫出师'
     OR title = '白雪歌送武判官归京'
     OR title = '宣州谢脁楼饯别校书叔云'
     OR title = '庐山谣寄卢侍御虚舟'
     OR title = '梦游天姥吟留别'
     OR title = '金陵酒肆留别'
     OR title = '韩碑'
     OR title = '听董大弹胡笳声兼寄语'
     OR title = '听安万善吹觱篥歌'
     OR title = '古意'
     OR title = '送陈章甫'
     OR title = '琴歌'
     OR title = '古柏行'
     OR title = '观公孙大娘弟子舞剑器行'
     OR title = '韦讽录事宅观曹将军画马'
     OR title = '丹青引赠曹霸将军'
     OR title = '寄韩谏议'
     OR title = '夜归鹿门山歌'
     OR title = '渔翁'
     OR title = '登幽州台歌'
     OR title = '石鼓歌'
     
     UPDATE poem SET recommended = 1, type= 7 WHERE title = '燕歌行'
     OR (title = '凉州词' AND author = '王之涣')
     OR (title = '塞上曲' AND author = '王昌龄')
     OR (title = '塞下曲' AND author = '王昌龄')
     OR (title LIKE '%长干行%' AND author = '崔颢')
     OR (title LIKE '%塞下曲%' AND author = '卢纶')
     OR title = '长信怨'
     OR title = '渭城曲'
     OR title = '秋夜曲'
     OR title = '洛阳女儿行'
     OR title = '老将行'
     OR title = '桃源行'
     OR (title LIKE '%清平调%' AND author = '李白')
     OR (title LIKE '%行路难%' AND author = '李白')
     OR (title LIKE '%将进酒%' AND author = '李白')
     OR title = '玉阶怨'
     OR (title LIKE '%长相思%' AND author = '李白')
     OR (title LIKE '%长干行%' AND author = '李白')
     OR (title LIKE '%蜀道难%' AND author = '李白')
     OR (title LIKE '%子夜吴歌%' AND author = '李白')
     OR title = '关山月'
     OR title = '江南曲'
     OR title = '古从军行'
     OR title = '哀王孙'
     OR title = '兵车行'
     OR title = '丽人行'
     OR title = '哀江头'
     OR title = '金缕衣'
     OR title = '独不见'
     OR title = '烈女操'
     OR title = '游子吟'
     */
}

#pragma mark - Private Methods

+ (NSDictionary<NSString *, NSArray *> *)loadPoemsDicWithSql:(NSString *)sql {
    NSMutableDictionary<NSString *, NSMutableArray *> *poemsDic = [[NSMutableDictionary alloc] init];
    [LF_POEMS_DB executeQuery:sql result:^(FMResultSet *rs, BOOL *end) {
        LFPoem *model = [self instanceFromCursor:rs];
        if (nil != model && nil != model.poet) {
            NSMutableArray *poems = poemsDic[model.poet.name];
            if (nil == poems) {
                poems = [[NSMutableArray alloc] init];
                poemsDic[model.poet.name] = poems;
            }
            [poems addObject:model];
        }
    }];
    
    return poemsDic;
}

+ (NSArray *)loadPoemsWithSql:(NSString *)sql {
    NSMutableArray *poems = [[NSMutableArray alloc] init];
    [LF_POEMS_DB executeQuery:sql result:^(FMResultSet *rs, BOOL *end) {
        LFPoem *model = [self instanceFromCursor:rs];
        [poems addObject:model];
    }];
    
    return poems;
}

+ (BOOL)isNumber:(NSString *)title {
    if (title.length <= 1) {
        return TRUE;
    }
    
    static NSArray *chineseNumbers = nil;
    if (chineseNumbers == nil) {
        chineseNumbers = @[@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"二十一", @"二十二", @"二十三", @"二十四", @"二十五", @"二十六", @"二十七", @"二十八", @"二十九", @"三十", @"三十一", @"三十二", @"三十三", @"三十四", @"三十五", @"三十六", @"三十七", @"三十八", @"三十九", @"四十", @"四十一", @"四十二", @"四十三", @"四十四", @"四十五", @"四十六", @"四十七", @"四十八", @"四十九", @"五十"];
    }
    
    return [chineseNumbers containsObject:title];
}

@end
