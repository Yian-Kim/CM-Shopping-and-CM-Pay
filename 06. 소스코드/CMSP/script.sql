----------------------------------------------------------------------------------------------------
-- 기초 데이터
----------------------------------------------------------------------------------------------------

-- 회원정보
create table tblMemberInformation (
    seq varchar2(10) primary key Not null,
    id varchar2(15) not null,
    pw number not null,
    username varchar(10) not null,
    dateBirth number not null,
    gender varchar(3) not null,
    email varchar(20) not null,
    phone varchar(14) not null
);

-- 배송리스트
create table tblDeliveryList (
    seq varchar(10) not null,
    deliveryName varchar(10) not null,
    recipient varchar(10) not null,
    address varchar(50) not null,
    contact varchar(14) not null,
    isBasicDelivery boolean
);

-- 카드관리
create table tblCardManagement (
    seq varchar(10) not null,
    cardCompany varchar(10) not null,
    cardNumber varchar(16) not null,
    validity number not null,
    cvc number not null,
    cardPassword number not null,
    accountNumber varchar(15)
);

-- 계좌관리
create table tblAccountManagement (
    seq varchar(15) not null,
    account_seq varchar(10) not null,
    bankName varchar(10),
    accountNumber number not null
);

-- 페이 비밀번호

create table tblPayPassword (
    seq varchar2(10),
    payPassword number not null
);

-- 페이 내역
create table tblPayHistory (
    seq number primary key not null,
    dateTime date not null,
    sender varchar2(10) not null,
    recipient varchar(10) not null,
    accountInfo varchar(15) not null,
    amount number not null
);


----------------------------------------------------------------------------------------------------
-- 결제
----------------------------------------------------------------------------------------------------

create table tblSellerInformation (
    seq number not null,
    sellerName varchar(20) not null,
    representativeName varchar(10) not null,
    businessLicenseNumber varchar(15) not null,
    businessAddress varchar(50) not null
);

create table tblDeliveryInformation (
    seq number not null,
    status varchar(10)
);

create table tblShoppingHistory (
    seq number not null,
    memberNumber varchar(10) not null,
    orderNumber varchar(20) not null, 
    status number not null,
    seller_seq number,
    isQRCodePayment boolean
);










