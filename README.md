# XML课程作业，运用XML和XSL开发HTML页面
### 概述：
XML结课作业要求运用某一语料库，面向某一特定用户群体，通过不同的XSL代码自动生成相应HTML网页，帮助原网站实现内容优化，更好地满足用户需求。本项目面向都市白领，从Time Out London网站收集了10篇区域美食推荐文章并重新标记（例：https://www.timeout.com/london/restaurants/south-kensingtons-best-restaurants ），采样区域均为繁荣商业区，覆盖了Piccadilly线的核心区域。
最终该项目获得A级评分。

### 需求分析 - 白领：
#### 概述：
面向都市青年的TimeOut London网站虽提供了许多餐厅清单，并以杂志口吻对其进行介绍，但其文章过于冗长，缺乏重点与合理排序的餐厅清单使得缺乏耐心的年轻人用户体验不佳，无法快速高效地定位高质量且符合通勤路线的餐厅，本项目面向都市白领，精简信息，优化排版，提供餐厅之间轻重有序的横向对比，旨在帮助用户实现快速选择餐厅。通过在同学、教授、舍友之间展开的访谈，本项目收集并提炼用户需求。
#### 用户需求：
- 必备需求：提供餐厅相关信息，包括餐厅名称、价格、特色菜、菜系、场合；
- 期望需求：餐厅评价精简有条理，详略得当且真实可信；提供相关交通信息，方便定位；页面具有层次感，方便用户灵活定位产品
- 魅力需求：区分vegan
- 反向需求：广告穿插过多，无用信息过多
- 无差异需求：提供某道菜的图片
#### 用户画像：
- 小胖白领：住在伦敦的小胖热爱美食，今年27岁，工作三年了，热爱生活但没有时间做饭，每天都需要外食。小胖清楚自己的用餐时间和场合，但缺少餐厅目标；关注性价比，但没有时间阅读过长的篇幅，需要精简的餐厅推荐帮助自己快速做出决定。
###用户场景
- 在上班路上、工作休息时间，大明打开网站，搜索通勤线路上的站点附近的餐厅，在浏览中寻找感兴趣喜欢的菜系，进一步筛选餐厅，在不断的阅读评价中食欲大增。最终考虑价格，选出一家评价优又性价比最高的餐厅。

### 现有产品分析
#### 概述：
《TimeOut》系列杂志是致力于展示“Best Things To Do and Events In Cities World”的世界顶级城市生活杂志，内容覆盖时尚消费、餐饮美食、文化艺术、市政民生等生活的各个方面。1968年创刊于伦敦，创始人为Tony Elliot，至今已有43年历史。随着疫情发展，其线上网站用户倍增。本项目聚焦其伦敦官网的美食推荐模块，包括海量餐厅推荐清单，支持关键词搜索但不支持筛选。
#### 商业模式：
以广告变现盈利，在多个帖子中间穿插餐厅的广告。
#### 目标用户：
TimeOut面向生活在都市的年轻人，其美食版块的用户多为没有明确用餐需求的读者，不常用搜索框，在浏览TimeOut大段推荐语之中触发食欲，做出性价比高的用餐决定。
#### 产品分析：
- 战略层：网站依托杂志本身的知名度和信誉，发表大量伦敦美食清单，以明星效应、文采、全面的信息吸引用户，以用户流量吸引商资
- 范围层：可进行关键词检索，但没有进一步筛选，部分餐厅缺少价格信息，用户需要借用其他网站搜索价格
- 结构层：信息呈现以列表式为主，内容齐全，满足用户浏览需求，但缺少重点和明显的主题结构，影响阅读效率；列表以字母顺序排列
- 框架层：不断下拉的界面缺少返回顶部的快捷按钮、导航条清晰可见，提供返回网站主页入口
- 表现层：网站整体视觉效果潮流，但图片尺寸过大，数量过多，且缺少注释，不清楚是餐厅的特色菜还是装饰图片；页面文段为块状，排列较为整齐；
#### 总结：
- 优点：1. 文案具备文采，且情绪饱满，能煽动用户情绪
       2. 界面设计时髦，符合用户群体调性
- 缺点：1. 缺少筛选条件、快捷键返回顶部，操作不够灵活
       2. 除顶部广告，中间穿插过多广告，篇幅过大且插入生硬，影响使用体验
       3. 重要信息缺乏过多，内容模块之间缺少一致性
       4. 保持杂志风格的长文段缺少重点和层次，影响用户阅读体验

### 新网页开发
- 版本：v1.0
- 时间：2021.5.1
#### 背景：
白领的核心诉求是需要快速找到一个日常通勤便利的高质量餐饮目的地，而不是浪费时间阅读Timeout上冗长的推荐帖和夸大其词的广告。其冗长的描述、纯粹按字母顺序排序的列表以及缺乏重点使读者精疲力尽，尤其是缺乏耐心的年轻人。本项目旨在帮助白领有效选择餐厅，重新组织、编排文案，增减功能为观众提供跨餐厅的更清晰比较，以便他们能够以更少的努力做出决定。
#### 产品设计：
- 战略层：依托TimeOut网站美食推荐板块进行功能及内容上的优化，面向日常通勤的伦敦白领，根据地铁站点重新划分推荐列表，将多个分文章合为一个页面增加主题感，使得用户定位更清晰。
- 范围层：增加列表层次，暂未上线筛选功能
- 结构层：整个页面切割为四个模块，从左上顺时针分别为编辑信息及简介，标题，正文，筛选条。正文部分根据地铁站点分为五个子模块，每个子模块可局部下拉，避免整体页面长滚动。子模块信息呈现为按照价格排列的块状列表式，满足用户浏览需求且主题结构明显
- 框架层：筛选框清晰可见，导航条暂未添加
- 表现层：受课程要求限制视觉设计从简
#### 项目管理：
- 4.10-4.13 根据需求进行功能设计，产出简易原型图；对原文本进行结构划分。
- 4.14-4.26 使用XML进行标记并整合。
- 4.27-4.29 使用XSLT自动组织、排版文本，使网页根据地铁站、用餐场合呈现信息。
- 4.30-5.1 上线两个版本进行用户测试，version 1.0设计较为现代化版本，version 1.1较为简易版本，简易版本收获更多好评，完成产品交付。
#### demo网站：
http://wwwdis.ucl.ac.uk/~uczcjyu/htmlForOfficers.html

### 未来迭代方向：
  1. 战略：依托网站资源上线APP
  2. 范围：添加更多功能，支持列表内以价格/用餐场合进行快速筛选
  3. 结构：将局部下拉模块改为随机生成卡片，点击即可刷新一个餐厅，左滑表示不喜欢，右滑表示喜欢，后台根据算法模型计算匹配的餐厅
  4. 信息：内容上扩大语料库，应该包括整个列表，并且可添加更多的区域
  5. 框架：添加导航bar及子功能模块图标；与TimeOut网站连接
  6. 表现：将两个版本视觉效果进行结合；改为响应式设计

