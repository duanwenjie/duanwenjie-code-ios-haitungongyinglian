//
//  AddressListCell.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "AddressListCell.h"

@interface AddressListCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIView *vBack;

@property (nonatomic, strong) UILabel *lblNameAndNumber;

@property (nonatomic, strong) UILabel *lblIdentityNumber;

@property (nonatomic, strong) UILabel *lblAddress;

@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIButton *btnDefault;

@property (nonatomic, strong) UIButton *btnCompile;

@property (nonatomic, strong) UIButton *btnDelete;

@end

@implementation AddressListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.vBack];
    [self.vBack addSubview:self.lblNameAndNumber];
    [self.vBack addSubview:self.lblIdentityNumber];
    [self.vBack addSubview:self.lblAddress];
    [self.vBack addSubview:self.vLine];
    [self.vBack addSubview:self.btnDefault];
    [self.vBack addSubview:self.btnCompile];
    [self.vBack addSubview:self.btnDelete];
    
    [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    [self.lblNameAndNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBack.mas_top).offset(3);
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lblIdentityNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblNameAndNumber.mas_bottom).offset(3);
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.lblAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblIdentityNumber.mas_bottom).offset(0);
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.right.equalTo(self.vBack.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblAddress.mas_bottom).offset(7);
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.right.equalTo(self.vBack.mas_right).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.btnDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
        make.left.equalTo(self.vBack.mas_left).offset(15);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(self.vBack.mas_bottom).offset(0);
    }];
    
    [self.btnCompile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
        make.bottom.equalTo(self.vBack.mas_bottom).offset(0);
        make.width.mas_equalTo(70);
        make.right.equalTo(self.btnDelete.mas_left).offset(0);
    }];
    
    [self.btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(0);
        make.bottom.equalTo(self.vBack.mas_bottom).offset(0);
        make.width.mas_equalTo(70);
        make.left.equalTo(self.btnCompile.mas_right).offset(0);
        make.right.equalTo(self.vBack.mas_right).offset(-10);
    }];
     
}

- (void)loadViewName:(NSString *)sName
         PhoneNumber:(NSString *)sPhoneNumber
      IdentityNumber:(NSString *)sIdentityNumber
             Address:(NSString *)sAddress
          IndextPath:(NSIndexPath *)index
           isDefault:(BOOL      )bDefault
{
    self.indexPath = index;
    self.lblNameAndNumber.text = [NSString stringWithFormat:@"%@   %@",sName, sPhoneNumber];
    self.lblIdentityNumber.text = sIdentityNumber;
    self.lblAddress.text = sAddress;
    self.btnDefault.selected = bDefault;
    
    [self setNeedsLayout];
}



#pragma mark - 按钮事件
- (void)selectorDefault
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapDefault:)]) {
        [self.delegate tapDefault:self.indexPath];
    }
}

- (void)selectorCompile
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCompile:)]) {
        [self.delegate tapCompile:self.indexPath];
    }
}

- (void)selectorDelete
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapDelete:)]) {
        [self.delegate tapDelete:self.indexPath];
    }
}


#pragma mark - 懒加载

- (UIView *)vBack
{
    if (!_vBack) {
        _vBack = [[UIView alloc] init];
        _vBack.backgroundColor = [UIColor whiteColor];
    }
    return _vBack;
}

- (UILabel *)lblNameAndNumber
{
    if (!_lblNameAndNumber) {
        _lblNameAndNumber = [[UILabel alloc] init];
        _lblNameAndNumber.font = [UIFont systemFontOfSize:14];
    }
    return _lblNameAndNumber;
}

- (UILabel *)lblIdentityNumber
{
    if (!_lblIdentityNumber) {
        _lblIdentityNumber = [[UILabel alloc] init];
        _lblIdentityNumber.font = [UIFont systemFontOfSize:13];
        _lblIdentityNumber.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _lblIdentityNumber;
}

- (UILabel *)lblAddress
{
    if (!_lblAddress) {
        _lblAddress = [[UILabel alloc] init];
        _lblAddress.font = [UIFont systemFontOfSize:12];
        _lblAddress.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _lblAddress;
}

- (UIView *)vLine
{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    }
    return _vLine;
}

- (UIButton *)btnDefault
{
    if (!_btnDefault) {
        _btnDefault = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDefault setTitle:@"设为默认" forState:UIControlStateNormal];
        [_btnDefault setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [_btnDefault setImage:[UIImage drawImageWithName:@"choose_default" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        
        [_btnDefault setTitle:@"默认地址" forState:UIControlStateSelected];
        [_btnDefault setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateSelected];
        [_btnDefault setImage:[UIImage drawImageWithName:@"choose_selected" size:CGSizeMake(20, 20)] forState:UIControlStateSelected];
        
        [_btnDefault addTarget:self action:@selector(selectorDefault) forControlEvents:UIControlEventTouchUpInside];
        
        _btnDefault.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnDefault setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    }
    return _btnDefault;
}

- (UIButton *)btnCompile
{
    if (!_btnCompile) {
        _btnCompile = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCompile setTitle:@"编辑" forState:UIControlStateNormal];
        [_btnCompile setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        
        [_btnCompile setImage:[UIImage drawImageWithName:@"Address_Edit" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        [_btnCompile addTarget:self action:@selector(selectorCompile) forControlEvents:UIControlEventTouchUpInside];
        
        _btnCompile.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnCompile setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
    }
    return _btnCompile;
}

- (UIButton *)btnDelete
{
    if (!_btnDelete) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        [_btnDelete setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [_btnDelete setImage:[UIImage drawImageWithName:@"Address_Delete" size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        
        [_btnDelete addTarget:self action:@selector(selectorDelete) forControlEvents:UIControlEventTouchUpInside];
        
        _btnDelete.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnDelete setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
    }
    return _btnDelete;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
