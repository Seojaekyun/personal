package kr.co.pension.dto;

public class ReserveDto {
	private int id,suk,inwon,bbq,chacol,chgprice,rid,state;
	private String inday,outday,userid,jumuncode,writeday;
	private boolean chk;
    
	public boolean isChk() {
		return chk;
	}
	public void setChk(boolean chk) {
		this.chk = chk;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSuk() {
		return suk;
	}
	public void setSuk(int suk) {
		this.suk = suk;
	}
	public int getInwon() {
		return inwon;
	}
	public void setInwon(int inwon) {
		this.inwon = inwon;
	}
	public int getBbq() {
		return bbq;
	}
	public void setBbq(int bbq) {
		this.bbq = bbq;
	}
	public int getChacol() {
		return chacol;
	}
	public void setChacol(int chacol) {
		this.chacol = chacol;
	}
	public int getChgprice() {
		return chgprice;
	}
	public void setChgprice(int chgprice) {
		this.chgprice = chgprice;
	}
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getInday() {
		return inday;
	}
	public void setInday(String inday) {
		this.inday = inday;
	}
	public String getOutday() {
		return outday;
	}
	public void setOutday(String outday) {
		this.outday = outday;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getJumuncode() {
		return jumuncode;
	}
	public void setJumuncode(String jumuncode) {
		this.jumuncode = jumuncode;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	
}
