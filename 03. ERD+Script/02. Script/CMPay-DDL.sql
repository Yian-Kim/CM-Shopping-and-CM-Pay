----------------------------------------------------------------------------------------------------
-- 기초 데이터
----------------------------------------------------------------------------------------------------

-- 회원정보
create table tblMemberInformation (
    seq varchar2(10) primary key Not null,  --seq - 주요키
    id varchar2(15) not null,               --아이디
    pw number not null,                     --비밀번호
    username varchar(10) not null,          --이름
    dateBirth number not null,              --생년월일
    gender varchar(3) not null,             --성별
    email varchar(20) not null,             --이메일
    phone varchar(14) not null              --휴대전화
);

-- 배송지목록
create table tblDeliveryList (              
    seq varchar(10) not null,               --seq - 외래키
    deliveryName varchar(10) not null,      --배송지명
    recipient varchar(10) not null,         --수령인
    address varchar(50) not null,           --주소
    contact varchar(14) not null,           --연락처
    isBasicDelivery boolean                 --기본배송지 설정여부
);

-- 카드관리
create table tblCardManagement (
    seq varchar(10) not null,               --seq
    cardCompany varchar(10) not null,       --카드사
    cardNumber varchar(16) not null,        --카드번호
    validity number not null,               --유효기간
    cvc number not null,                    --CVC
    cardPassword number not null,           --카드비밀번호
    accountNumber varchar(15)               --계좌번호
);

-- 계좌관리
create table tblAccountManagement (
    seq varchar(15) not null,               --id
    account_seq varchar(10) not null,       --seq
    bankName varchar(10),                   --은행
    accountNumber number not null           --계좌번호
);

-- 페이 비밀번호
create table tblPayPassword (
    seq varchar2(10),                       --seq
    payPassword number not null             --비밀번호(6자리)
);

-- 송금내역(페이내역)
create table tblPayHistory (
    seq number primary key not null,        --seq
    dateTime date not null,                 --날짜 및 시간
    sender varchar2(10) not null,           --보낸사람
    recipient varchar(10) not null,         --받은사람
    accountInfo varchar(15) not null,       --통장정보
    amount number not null                  --금액
);


----------------------------------------------------------------------------------------------------
-- 결제 정보
----------------------------------------------------------------------------------------------------

-- 판매자 정보
create table tblSellerInformation (
    seq number not null,                        --seq
    sellerName varchar(20) not null,            --판매자상호
    representativeName varchar(10) not null,    --대표자명
    businessLicenseNumber varchar(15) not null, --사업자등록번호
    businessAddress varchar(50) not null        --판매자 사업장 주소
);

-- 배송정보
create table tblDeliveryInformation (
    seq number not null,                    --seq
    status varchar(10)                      --상태
);

-- 쇼핑리스트
create table tblShoppingHistory (
    seq number primary key not null,        --seq
    memberNumber varchar(10) not null,      --회원번호
    orderNumber varchar(20) not null,       --주문번호 (json 요청)
    status number not null,                 --상태
    seller_seq number,                      --판매자번호
    isQRCodePayment boolean                 --QR결제여부
);


----------------------------------------------------------------------------------------------------
-- 문의
----------------------------------------------------------------------------------------------------

-- 판매자 문의하기
create table tblContactSeller (
    id number primary key not null,         --seq - 주요키
    orderNumber varchar2(20) not null,      --주문번호 (json 요청) - 외래키
    productNumber varchar2(20) not null,    --상품번호
    contactType number not null,            --문의유형
    title varchar2(50) not null,            --제목
    content varchar(2000) not null,         --내용
    contactDate date not null,              --날짜
    shopping_seq number                     --seq
);

-- 문의유형
create table tblContactType (
    seq number,                             --seq
    type varchar2(10)                       --유형
);

-- 문의글 상태
create table tblContactStatus (
    seq primary key not null,               --seq
    isAnswerContact boolean not null        --답변여부
);


----------------------------------------------------------------------------------------------------
-- 충전
----------------------------------------------------------------------------------------------------

-- 충전할 금액
create table tblChargingPointAmount (
    seq number primary key not null,        --번호
    chargingAmount number not null          --충전금액
);

-- 충전하기 - 계좌간편 결제
create table tbl (
    id number primary key not null,         --번호
    account_seq varchar2(15),               --계좌번호
    amount number                           --사용자입력금액
);


----------------------------------------------------------------------------------------------------
-- 포인트
----------------------------------------------------------------------------------------------------

-- 포인트 전체정보
create table tblTotalPointInformation (
    id number primary key not null,         --seq
    retentionPoint number,                  --보유포인트
    reservePoint number,                    --적립포인트
    chargingPoint number,                   --충전포인트
    cancelPoint number,                     --취소/인출 가능한 포인트
    member_seq varchar2(10)                 --회원번호
);

-- 포인트리스트
create table tblPointList (
    seq number primary key not null,        --id
    pointDate date not null,                --날짜
    status number not null,                 --상태(적립,사용,충전,취소)
    paymentSource varchar2(10) not null,    --지급처(은행명, 카드사명)
    chargingPoint number not null,          --충전포인트(+,-로 표현)
    isDeleteHistory boolean not null,       --내역삭제여부
    charging_seq number,                    --충전하기번호
    total_seq number                        --전체정보번호
);

-- 전체상태(전체탭)
create table tblPointStatus (
    seq number primary key not null,        --seq
    status varchar2(10) not null            --상태
);

-- 취소 상세정보
create table tblCancelDetailsInformation (
    seq number,                             --seq
    applicationDate date not null,          --신청일
    applicationAmount number not null,      --신청금액
    chargingCanceAmount number not null,    --충전취소금액
    drawingsCash number not null,           --현금인출금
    status varchar2(10) not null            --상태
);

-- 온라인 영수증
create table tblOnlineReceipt (
    seq number not null,                    --seq
    member_seq varchar2(10) not null,       --구매자명(회원ID)
    dealDate date not null,                 --거래일시
    cancelDate date not null,               --취소일시
    productName varchar2(30) not null,      --상품명 (CM 페이 포인트)
    amount number not null,                 --금액
    paymentMethod varchar2(15) not null,    --결제수단 - 계좌 간편결제
    paymentMethod_seq varchar2(15) not null --결제수단정보 - 계좌 및 카드 번호
);

----------------------------------------------------------------------------------------------------
-- 선물
----------------------------------------------------------------------------------------------------

-- 선물 상태
create table tblGiftStatus (
    id number primary key not null,         --id
    giftStatus varchar2(10) not null        --상태
);

-- 선물리스트(포인트)
create table tblGiftList (
    seq number primary key not null,        --seq
    recipient varchar2(10) not null,        --받는사람
    sender varchar2(10) not null,           --보낸사람
    systemMessage varchar2(20) not null,    --내용
    amount number not null,                 --선물할 포인트
    detailsMessage varchar2(50),            --상세메시지
    giftDate date not null,                 --날짜
    status_seq number,                      --상태(수락대기,수락완료,취소)
    total_seq number                        --전체정보번호
);






