package model;

public class ComplaintReply {
	private int complaint_id;
	private int reply_id;
	private String complaint_user;
	private String replied_user;
	private String complaint_status;
	private String complaint_text;
	private String reply_text;

	public int getComplaint_id() {
		return complaint_id;
	}

	public void setComplaint_id(int complaint_id) {
		this.complaint_id = complaint_id;
	}

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	public String getComplaint_user() {
		return complaint_user;
	}

	public void setComplaint_user(String complaint_user) {
		this.complaint_user = complaint_user;
	}

	public String getReplied_user() {
		return replied_user;
	}

	public void setReplied_user(String replied_user) {
		this.replied_user = replied_user;
	}

	public String getComplaint_status() {
		return complaint_status;
	}

	public void setComplaint_status(String complaint_status) {
		this.complaint_status = complaint_status;
	}

	public String getComplaint_text() {
		return complaint_text;
	}

	public void setComplaint_text(String complaint_text) {
		this.complaint_text = complaint_text;
	}

	public String getReply_text() {
		return reply_text;
	}

	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}

}
