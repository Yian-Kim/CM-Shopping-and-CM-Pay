-- CAFETORI_accounts.sql

create table tblMember (                -- ◆ 멤버테이블
    seq_id number Primary key not null, -- 식별자번호(PK)
    id varchar(15) not null,            -- 별명
    nickname varchar(20) not null,      -- 아이디
    grade varchar(15) not null,         -- 등급
    regdate date not null,              -- 가입일
    lastVisitDate date,                 -- 최종방문일
    visits number null,                 -- 방문수
    posts number null,                  -- 게시글수
    comment number null,                -- 댓글
    gender varchar(10) not null,        -- 성별
    state varchar(10) not null          -- 상태 : 활동중, 활동정지
);


create table tblGrade (                 -- ◆ 등급
    manager number not null,            -- 매니저
    generalMember number not null,      -- 부매니저
    sincereMember number not null,      -- 신입맞이 스탭
    bestMember number not null,         -- 디자인 스탭
    thanksMember number not null,       -- 이벤트 스탭
    gradeStaff number not null,         -- 전체 게시판 스탭
    eagerMember	number not null,        -- 개별 게시판 스탭
    indiBoardStaff	number not null,    -- 멤버등급 스탭
    newWelcomeStaff	number not null,    -- 공동구매 스탭
    designStaff	number not null,        -- 감사멤버
    eventStaff	number not null,        -- 우수멤버
    fullBoardStaff number not null,     -- 열심멤버
    subManager number not null,         -- 성실멤버
    groupBuyingStaff number not null,   -- 일반멤버
    budMember number not null           -- 새싹멤버
);

