package model;


public class Reply {
	private int reply_id;
	private int complaint_id;
	private int replier_id;
	private String reply_text;
	private java.sql.Timestamp replied_at;

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	public int getComplaint_id() {
		return complaint_id;
	}

	public void setComplaint_id(int complaint_id) {
		this.complaint_id = complaint_id;
	}

	public int getReplier_id() {
		return replier_id;
	}

	public void setReplier_id(int replier_id) {
		this.replier_id = replier_id;
	}

	public String getReply_text() {
		return reply_text;
	}

	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}

	public java.sql.Timestamp getReplied_at() {
		return replied_at;
	}

	public void setReplied_at(java.sql.Timestamp replied_at) {
		this.replied_at = replied_at;
	}

}
