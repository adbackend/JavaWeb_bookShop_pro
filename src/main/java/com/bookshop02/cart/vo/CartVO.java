package com.bookshop02.cart.vo;

import org.springframework.stereotype.Component;

@Component("cartVO")
public class CartVO {

	private int cart_id; //장바구니 번호
	private int goods_id; //상품번호
	private String member_id; //회원아이디
	private int cart_goods_qty; //상품 개수
	private String creDate; //생성일자
	public int getCart_id() {
		return cart_id;
	}
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getCart_goods_qty() {
		return cart_goods_qty;
	}
	public void setCart_goods_qty(int cart_goods_qty) {
		this.cart_goods_qty = cart_goods_qty;
	}
	public String getCreDate() {
		return creDate;
	}
	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}

	@Override
	public String toString() {
		return "CartVO [cart_id=" + cart_id + ", goods_id=" + goods_id + ", member_id=" + member_id
				+ ", cart_goods_qty=" + cart_goods_qty + ", creDate=" + creDate + "]";
	}
	
	
}
