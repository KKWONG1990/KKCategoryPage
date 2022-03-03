//
//  KKCustomCell.m
//  KKCategoryPage_Example
//
//  Created by BYMac on 2022/2/4.
//  Copyright © 2022 kkwong90@163.com. All rights reserved.
//

#import "KKCustomCell.h"

@implementation KKCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.textLabel.font = selected ? [UIFont systemFontOfSize:22] : [UIFont systemFontOfSize:16];
    self.textLabel.textColor = selected ? UIColor.whiteColor : UIColor.darkTextColor;
    self.contentView.backgroundColor = selected ? UIColor.brownColor : UIColor.whiteColor;
    
    
}

@end
