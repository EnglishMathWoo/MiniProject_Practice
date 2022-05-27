package com.model2.mvc.service.domain;

import java.sql.Date;
import com.model2.mvc.service.domain.User;

public class Notice {
 
	private int noticeNo;
	private String noticeTitle;
    private String noticeContent;
    private String noticeFileName;
	private Date noticeDate;

	
	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getNoticeFileName() {
		return noticeFileName;
	}

	public void setNoticeFileName(String noticeFileName) {
		this.noticeFileName = noticeFileName;
	}

	public Date getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(Date noticeDate) {
		this.noticeDate = noticeDate;
	}

	public String toString() {
		return "notice : [noticeTitle]" + noticeTitle +" [noticeContent]" + noticeContent;
	}
    
}