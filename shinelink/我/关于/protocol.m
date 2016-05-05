//
//  protocol.m
//  shinelink
//
//  Created by sky on 16/4/25.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "protocol.h"

@interface protocol ()
@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, strong) UITextView *detail;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *detailText;
@end

@implementation protocol

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    
    [self getText];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,1000*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    _title1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*NOW_SIZE, 300*NOW_SIZE,35*NOW_SIZE )];
    _title1.text=@"<<ShinePhone Terms of Use>>";
    _title1.textAlignment=NSTextAlignmentCenter;
    _title1.textColor=COLOR(0, 0, 0, 1);
    _title1.font = [UIFont systemFontOfSize:18*NOW_SIZE];
    [_scrollView addSubview:_title1];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,15*NOW_SIZE+30*NOW_SIZE, 300*NOW_SIZE,1*NOW_SIZE )];
    line3.backgroundColor=[UIColor grayColor];
    [_scrollView addSubview:line3];
    
    _detail=[[UITextView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,50*NOW_SIZE, 300*NOW_SIZE,900*NOW_SIZE )];
    _detail.text=_detailText;
    _detail.textAlignment=NSTextAlignmentLeft;
    _detail.textColor=COLOR(60, 60, 60, 1);
    _detail.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [_scrollView addSubview:_detail];
    
}

-(void)getText{
    _detailText=@"    Welcome to register and use the service of Shenzhen Growatt New Energy Co., Ltd (which in the following referred as Growatt, ShineServer, Our company, Our website, We.), before use Our website please read the ShineServer Terms of Use (which in following referred as Terms of Use or Agreement).\n    Users must notice that if users want to visit or use our website (including in ways of using mobile phone apps to log in and use our website) and accept the service provided by us, please carefully read all the clauses in this Terms of Use document especially clauses related to your rights or disclaimers. If you have any queries on this Terms of Use please contact service@ginverter.com.\n   Please read and decided to agree all the content of this Terms of Use or not, if you disagree to follow the Terms of Use you should not use ShineServer service or you should quit to continue using this service provided by Growatt. \n    Once you selected the option I have read and accept ShineServer Terms of Use, the action will be regarded as acceptance to the Terms of Use including accepting any changes or supplementary to the Terms of Use done by Growatt, and simultaneously it will be regarded as finish the agreement between users and Growatt. \n    After acceptance to the Terms of Use,     \n -	Users should not use the reason of not read the full content of the Terms of Use to make any opposition.";
//           \n -	Users should not use the reason of not be answered or informed for any queries or changes or supplementary from Growatt to make any opposition.
//             \n   1.General Clauses
//              \n  1.1	The legal document you are reading now is an agreement only between you (or referred as user(s) or buyer(s)) and us (Growatt).
//                1.2	Please read the agreement carefully. While you
//                - Visit or
//                - Use our website or
//                - Use any devices or services provided by our website or
//                - Use any services via our website
//                You will be regarded as to accept and agree all the clauses and the agreement. All the services, usage of our website and any buying behaviors must be complied with the Terms of Use. We keep the right of change or complement the Terms of Use whenever necessary. Any changes or supplementary will be published on our website, the modified clauses or terms will be effect once they are published on our website. If you choose to continuously use the service or our website, you will be regarded as accepted the modified Terms of Use.
//                1.3	All the services provided by our website are aimed at users who visit our website worldwide. You should never temper or attack our website. According to applicable laws we keep the right of prevent you from using our services and our website and retroactive your liability.
//                1.4	To use our website, accept the services or implement any purchasing or buying behavior, you need to prepare computer, other necessary devices, internet connection and related telecommunication connections. We will not take responsibility to the possible cost of telephone charges, telecommunication charges and other expenses.
//                2.User Account
//                2.1	User(s) can make registration on our website to use the services provided by our website. After purchased the data logger of Growatt, user(s) can apply to register account using serial number and check code of data logger (only based on serial number and check code can user(s) register an account). After successful registration user(s) will get an account and corresponded password. User(s) can enjoy the right of use of the account, while Growatt will keep the ownership of the account.
//                    2.2	User(s) should self-custody their account and password. The right of use of the account and password belongs to the original register. You agree that once you disclose your account and password information to third one, the one is authorized to use your account and password to visit and use the services and our website (and make transaction through our website). Please notice that if your exposed your password because of your own actions, you should take responsibility by yourself.
//                        2.3	User(s) should provide completed, factual, accurate and latest personal information while register or edit the account, comprehensive user(s) information is very important during retrieve account and password. You should take responsibility to loss and problem caused by uncompleted, unreal, inaccurate user information we will not be responsible to such accounts and keep the right of pausing or stopping the usage of such accounts.
//    2.4	If your account is illegal used or has safety problems, you should inform Growatt immediately. When Growatt received users application of pause the usage of the account, we will require user to provide the corresponding registration and personal information and check the reality before take action. After checked the reality of personal information and account information, if its correct we will take action to pause the usage of your account, but if not we have right to refuse users application.
//        2.5	If the illegal usage of the account and password is caused by hackers, we are not responsible to such event.
//        2.6	Its strictly prohibited for any organizations or persons to illegally register account on our website. To organize, copy, transit information and content of our website, one should use factual personal, company or organization information, should never register account on our website use false or fraudulent personal, company or organization information to make registration.
//            2.7	We will build a comprehensive user information security system to protect user(s) account and personal information.
//            3.Contents of Services
//            3.1	The detailed content of the online service of our website is provided base on actual situation by us. Growatt keep the right of change, pause or stop part or whole online services whenever.
//            3.2	Our website provides user(s) remote monitoring solution for solar photovoltaic plant (or project, station), considering the operation cost we will provide user(s) differentiated services which will charge indicated kinds of accounts. Simultaneously, there are possibilities that we cancel free services in the future. Under such circumstances, we will publish significantly information on related pages of our website. If user(s) are not willing to pay for these charges then you should give up continuously use our website and the services.
//                3.3	We only provide related online services, costs (charges) of
//                -Devices related to internet services: e.g. computer, modem and other devices related to internet connection, and
//                -Corresponding costs or charges to internet services: e.g. Internet cost and telephone charges because of using internet services
//                should be paid by user(s).
//                3.4	User(s) should use authorized and genuine software or operation system to use the services and our website.
//                4. Usage and Limitation
//                4.1	You should take all the legal responsibility of events and activities on your account or occurred via your account (include but not limited to your expression and speech and relevant consequences).
//                4.2	User(s) should promise not to use or authorize any third one to use the service or our website to engage following activities (not limited to)
//                -Transmitting any illegal, immoral, violation materials or information or information which are of infringement to others right or have technical hazards or any material that are unauthorized by us or third party. Or
//                -Intercepting or trying to intercept any information transmitted via telecommunication network. Or
//                -Applying the services and our website to unspecified application. Or
//                -Activities that can be regarded as illegal, criminal or activities that can be regarded to be illegal or of infringement to the right of any third party. Or
//                -Other activities that violate to general recognition of the Internet.
//                4.3 User(s) must promise not to use the services and our website in following ways, including but not limited to
//                -Fraudulence.
//                -Providing false information.
//                -Trying to circumvent the security settings or network system of our website.
//                -Catching information of the services and our website via activities that may cause our server and computer system and devices to be unreasonable loaded or engaging activities that will leads to such situation.
//                -Implementing any kind of internet monitoring actions to intercept information without your business.
//                -Sending email information without permission from the receiver.
//                -Falsifying or using mail header information without permission or authorization from us.
//                -Composing, sending or forwarding malicious massages or mail or any kind of MLM materials or information no matter whether the receiver is willing to receive those information and materials or not.
//                -Engaging any illegal activities.
//                -Engaging any activities we believe which will infringe or restrict others right of normally using our website and services.
//                -Violating the agreement.
//                4.4	User(s) agree to receive promotion and business information by email or other ways from us (Growatt). We have right to promote advertising and other business information during providing the services.
//                4.5	User(s) must obey following rules and principles when use the online service of our website
//                -Compliance with laws and regulations of China.
//                -Prohibit using the Internet services for any illegal purposes.
//                    -Follow relevant internet agreements, regulations and procedures.
//                    -Prohibit using the services and our website to engage any activities that have negative affection on normally operation of Internet.
//                    -Never use the services and our website to engage any activities that may have negative affection to us (Growatt).
//                    -If there are any illegal usage of the accounts or there are bugs occurred to the accounts please inform us (Growatt) immediately.
//                    4.6 User(s) promise to independently assume the responsibility of the information that they published. The usage of user(s) to the services and our website must be compliance with domestic, national, federal and international laws and regulations that are applicable.
//                    During the usage to services of our website, user(s) must ensure that their behaviors are compliance with relevant principles, regulations and laws of China. User(s) should never make use of the services or our website to organize, copy, publish or transmit following information and materials, including but not limited to
//                    -Go against to the basic principle of Chinese constitution.
//                    -Involve in endangering the countrys security, disclosure of countrys secrets, subversion of the state power and undermine national unity.
//                    -Harm the honor and interests of the country or nation.
//                    -Inciting the ethnic hatred and discrimination, undermining national unity.
//                    -Undermining national religious policy, propagating evil cult and feudal superstition.
//                    -Spreading rumors, disturbing social order, undermining social stability.
//                    -Spreading obscenity, pornographic, gambling, violence, terrorism and abetting crime.
//                    -Insult or slander others and infringing the legal rights of others.
//                    -Inciting illegal demonstrations, association, assembly and other events and activities that disturb the social order.
//                    -Activities and events that under the name of illegal NGO.
//                    -Containing illegal information or information that go against regulations and laws
//                    User(s) shall never disturb the services and operations of our website in any ways.
//                    User(s) should assume the legal responsibility of behaviors during using the services and our website. Liability forms including but not limited to
//                    -Compensating victims. And
//                    -Compensating equal compensation to us after we assumed the administration and legal punishment and compensation caused by users behaviors.
//                    4.7 User(s) should follow relevant service agreements and terms of use during using accounts and password to log in our website and enjoy the services of our website or other kind of services provided by Growatt. It will be deemed as acceptance to relevant service agreements and terms of use once user(s) log into our website or accept or use relevant services.
//                    4.8 There are possibilities that the service providing and accessing to our website might be accidently paused, restricted or stopped even though we are keeping making every effort to provide you undisturbed services. We cannot guarantee or promise that
//                    -You will not get any disturbances during the using the services and our website.
//                    -All the information that transmitted via our website can be accurately, reliably or timely be transferred.
//                    -Our website will never be infected virus or be implanting malicious programs.
//                    We assume no responsibilities to above situations.
//                    4.9	We have right to change, modify, replace, pause or remove any information, services, products or services provided via our websites at any time without informs. There are possibilities the use to the services and our website be restricted caused by modification, maintenance, installation new components or importing new products. Under such circumstance we will try every effort to recovery the normal use and operation for you to use the services and our website. We assume no responsibilities to the running and operation of third parties browser and software.
//                        4.10 We have right to block, edit or delete any information and materials that we believe will violate this agreement or Terms of Use.
//                        4.11 Once there are errors, faults or bugs occurred we will try to fix, modify and solve these problems. We cannot guarantee or promise that the services and our website will never get errors or bugs and if there are no relevant applicable regulations and laws we will assume no responsibilities to these errors, faults and bugs. If there are any errors, faults or bugs occurred please immediately report to our service department to solve the problems: service@ginverter.com
//                            5. Intellectual Property Rights and Copyright
//                            5.1	All the intellectual property rights, website information and service information, our database, all the website design, word and charts, software, pictures and photos, videos, music, voice and their combinations in the services and our website, and all the software compile, relevant source codes and software (including small program, script) are our property. You shall never or try to get these intellectual property rights. Without separately written permission, you shall never use, change, copy or transmit information and materials of our website for commercial purples.
//                                5.2	All the rights contained in our name (including goodwill and trademark) belong to us or our authorizees. Other products, brands and trademarks appeared in our website belong to corresponding brand and trademark owners. Authors of the literary and artistic works that appeared in our website have declared to be the writers hence to have relevant rights.
//                                5.3	Any information and materials like words, charts, audios, videos and software (including but not limited to charts, animations, audios, videos, interface, data and program, code, documentation) are under protection by corresponding copyright laws, trademark laws or other relevant regulations and laws. Without written permission from obligees or right holders, user(s) should never use these information and materials in any ways.
//                                5.4	This agreement (or Terms of Use) has never authorized user(s) the right of use any trademarks, service identifiers, identifications and marks, domain names and other significant brand features.
//                                5.5	Only if it were significantly permitted by this agreement (or Terms of Use), user(s) should never change, modify, sale, distribute, copy part or whole of the Terms of Use or create derivatives or use the foregoing for commercial purposes.
//                                    6. Notice of Rights
//                                    6.1	If you believe your intellectual right or other kind of legal rights were infringed please submit following relevant materials and information during apply for complaints
//                                        -The certificate or evidence of ownership to the intellectual property rights of infringed contents/items.
//                                        -Effect and detailed contact information and qualification of the obligee including person name, copy of ID card or passport, copy of company or organization business license and other kind of information or evidences such as qualification certificates, contact number and address.
//                                        -The location of these contents/items on our website.
//                                        -Description of these contents/items.
//                                        -Add the declaration about the truth of notice information into this Notice of Rights: I or my company will assume all the consequences caused by our above application (or Notice of Rights), there is nothing to do with Shenzhen Growatt New Energy Co., Ltd.
//                                            -After signed or stamped the Notice of Rights, please send these documentations to our service email: service@ginverter.com.
//                                            6.2	After received the Notice of Rights from user(s), we will decided to delete the contents/items suspected to infringed the intellectual property right according to our judgment on it.
//                                            7. Protection to User Information
//                                            7.1	Under the premise of not disclose user information, we have right to analysis the whole user database and use the analyzed and adjusted user database for commercial purposes.
//                                                Even though we have made all efforts to protect user(s) information, its not fully guaranteed that user(s) information will never be infringed for all kinds of reasons under the existing protection technologies and system.
//                                                    7.2	Without permission from user(s), Growatt should never expose or share user(s) registration information to any third party such as name, effect personal ID card number or passport number, contact information, address etc. Expect following situations Including but not limited to
//                                                    -User(s) permitted or authorized Growatt to expose.
//                                                    -Required by relevant laws and regulations to expose.
//                                                    -Required to provide by Justice Office or Administration Organ (or similar organizations) based on legal procedures.
//                                                    -When Growatt apply litigation or arbitration on user(s) for reason of protect our own legal rights.
//                                                        -Required by user(s) guardians for legal and moral reasons or requirements.
//                                                            -To protect the legal right of public.
//                                                            8. Change, Suspension and Termination of Agreement and Services
//                                                            8.1	If you illegal use (or permitted others to) the services or our website in ways beach of the agreement, we have right to suspend your part or whole right of using or purchasing the services or product or visiting our website. We will obey the requirements from related government departments or legal departments and cooperate to determine and expose the information of user(s) who made violation.
//                                                            8.2	According to laws and regulations, we have right to fully or partly
//                                                            -Suspend your usage or access to the services and our website. Or
//                                                            -Pause your usage or access to the services and our website. Or
//                                                            -Pause the usage or access to the services and our website of anyone else (in any way) whom be believed to has something to do with you. Or
//                                                                -Immediately stop this agreement in situation of (including but not limited to)
//                                                                -You violate this agreement.
//                                                                -We have reasonable evidence showing you have, perhaps or will violate this agreement.
//                                                                -We have reasonable evidence showing you have or in process of cheating us or any third parties.
//                                                                The termination will not affect on our rights in this agreement and other rights that we should have.
//                                                                8.3	The loss, cost and responsibilities caused by following reasons (including but not limited to any litigations or legal procedures applied by anyone caused by or on following reasons) should be assumed by you:
//                                                                -Inappropriate usage to the services or our website by you or anyone you authorized or permitted.
//                                                                -Inappropriate usage to the services or products (devices) by you or anyone you authorized or permitted.
//                                                                -Inappropriate usage to the services or our website by anyone through your account and password.
//                                                                -Violation to the agreement by you or anyone you authorized or permitted.
//                                                                8.4	If the services and our website have to be paused because of system upgrading or maintenance, we will try to inform all the users as much as possible.
//                                                                8.5	When Growatt take action to suspend user(s) usage to the services and our website because of providing false registration or violation to this agreement, Growatt should inform user(s) the suspension and suspension time, the suspension time should be reasonable. After the due time of suspension, Growatt should recover the user(s) usage to the services and our website.
//                                                                8.6	We keep the right to suspend or stop part or whole services at any time without notices. Any loss caused by the suspension or termination will not be assumed by us.
//                                                                9. Exemption from Liability
//                                                                9.1	We take no responsibilities to
//                                                                -Accuracy, integrity and applicability of information from the services and our website.
//                                                                -Guarantees to situations that the internet services will certainly meet the user(s) requirements or there are no suspension on internet services or the accuracy, timeliness and security of the internet services.
//                                                                -Services and quality, security and applicability of services or other kind of contents.
//                                                                -Missing or loss of your (or any third partys) assets unless caused by our violation to the agreement.
//                                                                -Guarantees that our services will not be disturbed, timely provided, safety or that there are no faults or errors.
//                                                                9.2	User(s) significantly agree to fully assume the risks of using online services of our website. Any consequences of using online services of our website will also be assumed by user(s). We will not assume any responsibilities for these kind or risks.
//                                                                    10. Compensation
//                                                                    10.1 User(s) agree to protect and safeguard the interests of Growatt and other user(s). User(s) agree to assume the responsibilities and loss of Growatt and any other third parties caused by user(s) violation to this agreement or relevant laws and regulations.
//                                                                    11. Notice and Information Delivery
//                                                                    11.1 All the notices and information under this agreement will be published through important page bulletins, emails or general mail delivery etc. These kinds of notices will be deemed to be successfully delivered to user(s) once they are delivered.
//                                                                    12. Other Regulations
//                                                                    12.1 The Copyright is owned by Shenzhen Growatt New Energy Co., Ltd. We keep all the rights of explain or modify this agreement.
//                                                                    12.2 This agreement composes to be the completed agreement for matters agreed upon this agreement and other relevant matters. Expect matters agreed upon this agreement, it has never empowered all parties any kind of rights.
//                                                                        12.3 If any clause in this agreement partly or fully lost effect and applicability, other clauses in this agreement shall be regarded as effect clauses.
//                                                                        12.4 The conclusion, implementation and conflict resolution comply with lays and regulations of Peoples Republic of China, not included other conflict of laws. Once there are conflicts occurred on contents of this agreements between user(s) and Growatt, both sides should try to friendly negotiated first. If the negotiation doesnt work then user(s) agree to submit the conflict to Shenzhen Baoan District Peoples Court to solve the problem in ways of lawsuit.
//                                                                        12.5 The titles in this agreement are settled for convenience so have no legal or contractual effect.
//                                                                            12.6 If you have any opinions and suggestions, welcome to send email to us: services@ginverter.com;";
    
                                                                            }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
