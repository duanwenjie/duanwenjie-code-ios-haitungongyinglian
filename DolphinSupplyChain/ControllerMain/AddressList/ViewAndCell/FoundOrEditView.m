//
//  FoundOrEditView.m
//  DolphinSupplyChain
//
//  Created by ZhengXueNing on 2016/12/4.
//  Copyright © 2016年 学宁. All rights reserved.
//

#import "FoundOrEditView.h"

@interface FoundOrEditView () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfName;

@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *tfIdentityNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblAddressInfoHint;


@property (weak, nonatomic) IBOutlet UITextView *tfAddressInfo;


@property (weak, nonatomic) IBOutlet UIButton *btnSave;


@property (weak, nonatomic) IBOutlet UILabel *lblProvince;



@end

@implementation FoundOrEditView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        if (textView.text.length == 0) {
            self.lblAddressInfoHint.hidden = NO;
        }
        else
        {
            self.lblAddressInfoHint.hidden = YES;
        }
        [self endEditing:YES];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.lblAddressInfoHint.hidden = YES;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.tfName.delegate = self;
    self.tfAddressInfo.delegate = self;
    self.tfPhoneNumber.delegate = self;
    self.tfIdentityNumber.delegate = self;
    
    UITapGestureRecognizer *tapProvince = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapArea)];
    self.lblProvince.userInteractionEnabled = YES;
    [self.lblProvince addGestureRecognizer:tapProvince];
}




- (void)tapArea
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectArea)]) {
        [self.delegate selectArea];
    }
}


- (IBAction)tapSave:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(infoSaveName:PhoneNumber:IdentityNumber:AddressInfo:)]) {
        
        [self.delegate infoSaveName:self.tfName.text PhoneNumber:self.tfPhoneNumber.text IdentityNumber:self.tfIdentityNumber.text AddressInfo:self.tfAddressInfo.text];
    }
    
}

- (void)loadViewName:(NSString *)sName
               Phone:(NSString *)sPhone
            NumberID:(NSString *)sNumberID
            Province:(NSString *)sProvince
                City:(NSString *)sCity
                Area:(NSString *)sArea
         AddressInfo:(NSString *)sAddressInfo
{
    self.tfName.text = sName;
    self.tfPhoneNumber.text = sPhone;
    self.tfIdentityNumber.text = sNumberID;
    self.lblProvince.text = [NSString stringWithFormat:@"%@ %@ %@",sProvince,sCity,sArea];

    if (sAddressInfo.length != 0) {
        self.tfAddressInfo.text = sAddressInfo;
        self.lblAddressInfoHint.hidden = YES;
    }
    else
    {
        self.lblAddressInfoHint.hidden = NO;
    }
}


- (void)loadViewProvince:(NSString *)sProvince
                    City:(NSString *)sCity
                    Area:(NSString *)sArea
{
    self.lblProvince.text = [NSString stringWithFormat:@"%@ %@ %@",sProvince,sCity,sArea];
}


@end
