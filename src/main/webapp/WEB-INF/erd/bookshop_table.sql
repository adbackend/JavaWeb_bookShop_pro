-- 도서쇼핑몰 데이터베이스 테이블5개
-- 회원정보(t_shopping_member), 상품정보(t_shopping_goods), 상품 이미지 정보(t_goods_detail_image)
-- 주문테이블(t_shopping_order), 장바구니(t_shopping_cart)


--회원정보 테이블 t_shopping_member
create table t_shopping_member(
member_id varchar2(20) primary key, --회원아이디
member_pw varchar2(30), --비밀번호
member_name varchar2(50), --이름
member_gender varchar2(10), --성별
tel1 varchar2(20), --유선전화번호1
tel2 varchar2(20), --유선전화번호2
tel3 varchar2(20), --유선전화번호3
hp1 varchar2(20), --휴대폰번호1
hp2 varchar2(20), --휴대폰번호2
hp3 varchar2(20), --휴대폰번호3
smssts_yn varchar2(20), --sms 메시지 수신여부
email1 varchar2(20), --이메일 주소1
email2 varchar2(20), --이메일 주소2
emailsts_yn varchar2(20), --이메일 수신 여부
zipcode varchar2(20), -- 우편번호
roadaddress varchar2(500), --도로명 주소
jibunaddress varchar2(500), --지번주소
namujiaddress varchar2(500), --나머지 주소
member_birth_y varchar2(20), --생년월일 년
member_birth_m varchar2(20), --생년월일 월
member_birth_d varchar2(20), --생년월일 일
member_birth_gn varchar2(20), -- 생년월일 양음력 여부
joindate date default sysdate, --회원가입일
del_yn varchar(20) default 'N' --회원탈퇴 유무
);

--상품정보(t_shopping_goods)
create table t_shopping_goods(
goods_id number(20,0) primary key, --상품번호
goods_sort varchar2(50), --상품종류
goods_title varchar2(100), --상품제목
goods_writer varchar2(50), --저자 이름
goods_publisher varchar2(50), --출판사 이름
goods_price number(10,0), --상품정가
goods_sales_price number(10,0), --상품판매가격
goods_point number(10,0), --상품포인트
goods_published_date date, --상품 출판일
goods_total_page number(5,0),--상품총페이지수
goods_isbn varchar2(50),--isbn번호
goods_delivery_price number(10,0),--배송비
goods_delivery_date date,--상품배송일
goods_status varchar2(50), --상품분류
goods_intro varchar2(2000),--저자소개
goods_writer_intro varchar2(2000), --상품소개
goods_publisher_comment varchar2(2000), --출판사평
goods_recommendation varchar2(2000), --상품추천사
goods_contents_order clob, --상품목차
goods_credate date default sysdate --상품입고일
);

--상품이미지 정보(t_goods_detail_image)
create table t_goods_detail_image(
image_id number(20,0) primary key, --이미지번호
goods_id number(20,0), --상품번호 외래키
filename varchar2(50), --이미지 파일명
reg_id varchar2(20), --등록자 아이디
filetype varchar2(40), --이미지 파일 종류
credate date default sysdate --등록일
);

--주문테이블(t_shopping_order)
create table t_shopping_order(
order_seq_num number(20,0) primary key, --주문상품일렬번호
order_id number(20,0), --주문번호
member_id varchar2(20), --주문자 아이디
goods_id number(20,0), -- 상품번호
orderer_name varchar2(50), --주문자 이름
goods_title varchar2(100), --상품이름
order_goods_qty number(5,0), --주문수량
goods_sales_price number(5,0), --상품판매가격
goods_filename varchar2(60),--상품 이미지 파일이름
receiver_name varchar2(50), --수령자이름
receiver_hp1 varchar2(20), --수령자 휴대폰1
receiver_hp2 varchar2(20),
receiver_hp3 varchar2(20),
receiver_tel1 varchar2(20),--수령자 유선번호1
receiver_tel2 varchar2(20),
receiver_tel3 varchar2(20),
delivery_address varchar2(500),--배송주소
delivery_method varchar2(40),--배송방법
delivery_message varchar2(300),--부재시 전달 메시지
gift_wrapping varchar2(20),--상품포장여부
pay_method varchar2(200),--결제방법
card_com_name varchar2(50), --결제카드회사이름
card_pay_month varchar2(20),-- 할부개월수
pay_orderer_hp_num varchar2(20),--휴대폰결제번호
delivery_state varchar2(20) default 'delivery_prepared', --상품배송상태
pay_order_time date default sysdate, --결제시간
order_hp varchar2(50) --주문자 휴대폰번호
);

--장바구니(t_shopping_cart)
create table t_shopping_cart(
cart_id number(10,0) primary key, --장바구니번호
goods_id number(20,0), --상품번호
member_id varchar2(20), --회원아이디
credate date default sysdate, --생성일자
cart_goods_qty number(4,0) default 1 --상품개수
);


CREATE SEQUENCE  "ORDER_SEQ_NUM"  MINVALUE 0 MAXVALUE 10000000 INCREMENT BY 1 START WITH 400 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "SEQ_GOODS_ID"  MINVALUE 100 MAXVALUE 1000000 INCREMENT BY 1 START WITH 400 CACHE 20 ORDER  NOCYCLE ;
CREATE SEQUENCE  "SEQ_IMAGE_ID"  MINVALUE 1 MAXVALUE 11111111 INCREMENT BY 1 START WITH 400 NOCACHE  NOORDER  NOCYCLE ;
CREATE SEQUENCE  "SEQ_ORDER_ID"  MINVALUE 0 MAXVALUE 10000000 INCREMENT BY 1 START WITH 400 NOCACHE  ORDER  NOCYCLE ;


commit;
