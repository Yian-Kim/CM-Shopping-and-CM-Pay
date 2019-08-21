/*
문서명 : CMPay-DDL.sql
작성자 : KCM
작성일자 : 2019.08.16.
프로젝트명 : CM Pay
프로그램명 : CM 페이
프로그램 설명 : 네이버 페이를 벤치마킹한 프로그램입니다.
URL Link : https://github.com/Chanmi-Kim/CM-Shopping-and-CM-Pay
*/

----------------------------------------------------------------------------------------------------
-- 기초 데이터
----------------------------------------------------------------------------------------------------

-- 회원정보
create table tblMemberInformation (
    memberInformation_seq varchar2(10) primary key Not null,  --seq - 주요키
    id varchar2(15) not null,               --아이디
    pw number not null,                     --비밀번호
    username varchar2(10) not null,          --이름
    dateBirth number not null,              --생년월일
    gender varchar2(3) not null,             --성별
    email varchar2(20) not null,             --이메일
    phone varchar2(14) not null              --휴대전화
);

create sequence memberInformation_seq;

select * from tblMemberInformation;

DROP TABLE tblMemberInformation;
DROP SEQUENCE memberInformation_seq;

-- 배송지목록
create table tblDeliveryList (              
    deliveryList_seq varchar2(10) references tblMemberInformation(memberInformation_seq),  --seq - 외래키
    deliveryName varchar2(10) not null,      --배송지명
    recipient varchar2(10) not null,         --수령인
    address varchar2(50) not null,           --주소
    contact varchar2(14) not null,           --연락처
    isBasicDelivery NUMBER(1)                 --기본배송지 설정여부 1: true, 0: false
);

create sequence deliveryList_seq;

select * from tblDeliveryList;

DROP TABLE tblDeliveryList;
DROP SEQUENCE deliveryList_seq;

-- 계좌관리
create table tblAccountManagement (
    accountManagement_seq varchar(15) primary key not null,   --id
    account_seq varchar(10) references tblMemberInformation(memberInformation_seq) not null,  --seq
    bankName varchar(10),                   --은행
    accountNumber number not null           --계좌번호
);

create sequence accountManagement_seq;

select * from tblAccountManagement;

DROP TABLE tblAccountManagement;
DROP SEQUENCE accountManagement_seq;

-- 카드관리
create table tblCardManagement (
    cardManagement_seq varchar2(10) references tblMemberInformation(memberInformation_seq) not null,  --seq
    cardCompany varchar2(10) not null,       --카드사
    cardNumber varchar2(16) not null,        --카드번호
    validity number not null,               --유효기간
    cvc number not null,                    --CVC
    cardPassword number not null,           --카드비밀번호
    accountNumber varchar2(15) references tblAccountManagement(accountManagement_seq)  --계좌번호
);

create sequence cardManagement_seq;

select * from tblCardManagement;

DROP TABLE tblCardManagement;
DROP SEQUENCE cardManagement_seq;

-- 페이 비밀번호
create table tblPayPassword (
    payPassword_seq varchar2(10) references tblMemberInformation(memberInformation_seq),  --seq
    payPassword number not null             --비밀번호(6자리)
);

create sequence payPassword_seq;

select * from tblPayPassword;

DROP TABLE tblPayPassword;
DROP SEQUENCE payPassword_seq;

-- 송금내역(페이내역) 
create table tblPayHistory (
    payHistory_seq number primary key not null,        --seq
    dateTime date not null,                 --날짜 및 시간
    sender varchar2(10) references tblMemberInformation(memberInformation_seq) not null,  --보낸사람
    recipient varchar2(10) references tblMemberInformation(memberInformation_seq) not null,    --받은사람
    accountInfo varchar2(15) references tblAccountManagement(accountManagement_seq) not null,       --통장정보
    amount number not null                  --금액
);

create sequence payHistory_seq;

select * from tblPayHistory;

DROP TABLE tblPayHistory;
DROP SEQUENCE payHistory_seq;

----------------------------------------------------------------------------------------------------
-- 결제 정보
----------------------------------------------------------------------------------------------------

-- 판매자 정보
create table tblSellerInformation (
    sellerInformation_seq number primary key not null,                        --seq
    sellerName varchar(20) not null,            --판매자상호
    representativeName varchar(10) not null,    --대표자명
    businessLicenseNumber varchar(15) not null, --사업자등록번호
    businessAddress varchar(50) not null        --판매자 사업장 주소
);

create sequence sellerInformation_seq;

select * from tblSellerInformation;

DROP TABLE tblSellerInformation;
DROP SEQUENCE sellerInformation_seq;

-- 배송정보
create table tblDeliveryInformation (
    deliveryInformation_seq number primary key not null,    --seq
    status varchar(10)                                      --상태
);

create sequence deliveryInformation_seq;

select * from tblDeliveryInformation;

DROP TABLE tblDeliveryInformation;
DROP SEQUENCE deliveryInformation_seq;

-- 쇼핑리스트
create table tblShoppingHistory (
    shoppingHistory_seq number primary key not null,        --seq
    memberNumber varchar2(10) references tblMemberInformation(memberInformation_seq) not null, --회원번호
    orderNumber varchar(20) not null,   --주문번호 (json 요청)
    status number references tblDeliveryInformation(deliveryInformation_seq) not null,   --상태
    seller_seq number references tblSellerInformation(sellerInformation_seq), --판매자번호
    isQRCodePayment number(1)                 --QR결제여부 1: true, 0: false
);

create sequence shoppingHistory_seq;

select * from tblShoppingHistory;

DROP TABLE tblShoppingHistory;
DROP SEQUENCE shoppingHistory_seq;

----------------------------------------------------------------------------------------------------
-- 문의
----------------------------------------------------------------------------------------------------

-- 판매자 문의하기
create table tblContactSeller (
    contactSeller_seq number primary key not null,         --seq - 주요키
    orderNumber number references tblShoppingHistory(shoppingHistory_seq) not null,   --주문번호 (json 요청) - 외래키
    productNumber varchar2(20) not null,    --상품번호
    contactType number not null,            --문의유형
    title varchar2(50) not null,            --제목
    content varchar2(2000) not null,         --내용
    contactDate date not null,              --날짜
    shopping_seq number references tblShoppingHistory(shoppingHistory_seq)  --seq
);

create sequence contactSeller_seq;

select * from tblContactSeller;

DROP TABLE tblContactSeller;
DROP SEQUENCE contactSeller_seq;

-- 문의유형
create table tblContactType (
    contactSeller_seq number references tblContactSeller(contactSeller_seq), --seq
    type varchar2(10)                           --유형
);

create sequence contactSeller_seq;

select * from tblContactType;

DROP TABLE tblContactType;
DROP SEQUENCE contactSeller_seq;

-- 문의글 상태
create table tblContactStatus (
    contactStatus_seq number references tblContactSeller(contactSeller_seq) not null,    --seq
    isAnswerContact number(1) not null        --답변여부 1: true, 0: false
);

create sequence contactStatus_seq;

select * from tblContactStatus;

DROP TABLE tblContactStatus;
DROP SEQUENCE contactStatus_seq;

----------------------------------------------------------------------------------------------------
-- 충전
----------------------------------------------------------------------------------------------------

-- 충전할 금액
create table tblChargingPointAmount (
    chargingPointAmount_seq number primary key not null,        --번호
    chargingAmount number not null          --충전금액
);

create sequence chargingPointAmount_seq;

select * from tblChargingPointAmount;

DROP TABLE tblChargingPointAmount;
DROP SEQUENCE chargingPointAmount_seq;

-- 충전하기 - 계좌간편 결제
create table tblChargingPoint (
    chargingPoint_seq number primary key not null,         --번호
    account_seq varchar2(15) references tblAccountManagement(accountManagement_seq),  --계좌번호
    amount number                           --사용자입력금액
);

create sequence chargingPoint_seq;

select * from tblChargingPoint;

DROP TABLE tblChargingPoint;
DROP SEQUENCE chargingPoint_seq;

----------------------------------------------------------------------------------------------------
-- 포인트
----------------------------------------------------------------------------------------------------

-- 포인트 전체정보
create table tblTotalPointInformation (
    totalPointInformation_seq number primary key not null,         --seq
    retentionPoint number,                  --보유포인트
    reservePoint number,                    --적립포인트
    chargingPoint number,                   --충전포인트
    cancelPoint number,                     --취소/인출 가능한 포인트
    member_seq varchar2(10) references tblMemberInformation(memberInformation_seq)    --회원번호
);

create sequence totalPointInformation_seq;

select * from tblTotalPointInformation;

DROP TABLE tblTotalPointInformation;
DROP SEQUENCE totalPointInformation_seq;

-- 전체상태(전체탭)
create table tblPointStatus (
    pointStatus_seq number primary key not null,        --seq
    status varchar2(10) not null            --상태
);

create sequence pointStatus_seq;

select * from tblPointStatus;

DROP TABLE tblPointStatus;
DROP SEQUENCE pointStatus_seq;

-- 포인트리스트
create table tblPointList (
    pointList_seq number primary key not null,        --id
    pointDate date not null,                --날짜
    status number references tblPointStatus(pointStatus_seq) not null, --상태(적립,사용,충전,취소)
    paymentSource varchar2(10) not null,    --지급처(은행명, 카드사명)
    chargingPoint number not null,          --충전포인트(+,-로 표현)
    isDeleteHistory number(1) not null,       --내역삭제여부 1: true, 0: false
    charging_seq number references tblChargingPoint(chargingPoint_seq),    --충전하기번호
    total_seq number references tblTotalPointInformation(totalPointInformation_seq)    --전체정보번호
);

create sequence pointList_seq;

select * from tblPointList;

DROP TABLE tblPointList;
DROP SEQUENCE pointList_seq;

-- 취소 상세정보
create table tblCancelDetailsInformation (
    cancelDetailsInformationt_seq number references tblPointList(pointList_seq),    --seq
    applicationDate date not null,          --신청일
    applicationAmount number not null,      --신청금액
    chargingCanceAmount number not null,    --충전취소금액
    drawingsCash number not null,           --현금인출금
    status varchar2(10) not null            --상태
);

create sequence cancelDetailsInformationt_seq;

select * from tblCancelDetailsInformation;

DROP TABLE tblCancelDetailsInformation;
DROP SEQUENCE cancelDetailsInformationt_seq;

-- 온라인 영수증
create table tblOnlineReceipt (
    onlineReceipt_seq number references tblPointList(pointList_seq),   --seq
    member_seq varchar2(10) references tblMemberInformation(memberInformation_seq) not null,  --구매자명(회원ID)
    dealDate date not null,                 --거래일시
    cancelDate date not null,               --취소일시
    productName varchar2(30) not null,      --상품명 (CM 페이 포인트)
    amount number not null,                 --금액
    paymentMethod varchar2(15) not null,    --결제수단 - 계좌 간편결제
    paymentMethod_seq varchar2(15) 
    references tblAccountManagement(accountManagement_seq) not null --결제수단정보 - 계좌 및 카드 번호
);

create sequence onlineReceipt_seq;

select * from tblOnlineReceipt;

DROP TABLE tblOnlineReceipt;
DROP SEQUENCE onlineReceipt_seq;

----------------------------------------------------------------------------------------------------
-- 선물
----------------------------------------------------------------------------------------------------

-- 선물 상태
create table tblGiftStatus (
    giftStatus_seq number primary key not null,         --id
    giftStatus varchar2(10) not null        --상태
);

create sequence giftStatus_seq;

select * from tblGiftStatus;

DROP TABLE tblGiftStatus;
DROP SEQUENCE giftStatus_seq;

-- 선물리스트(포인트)
create table tblGiftList (
    giftList_seq number primary key not null,        --seq
    recipient varchar2(10) references tblMemberInformation(memberInformation_seq) not null, --받는사람
    sender varchar2(10) references tblMemberInformation(memberInformation_seq) not null, --보낸사람
    systemMessage varchar2(20) not null,    --내용
    amount number not null,                 --선물할 포인트
    detailsMessage varchar2(50),            --상세메시지
    giftDate date not null,                 --날짜
    status_seq number references tblGiftStatus(giftStatus_seq), --상태(수락대기,수락완료,취소)
    total_seq number references tblTotalPointInformation    --전체정보번호
);

create sequence giftList_seq;

select * from tblGiftList;

DROP TABLE tblGiftList;
DROP SEQUENCE giftList_seq;






