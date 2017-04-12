package cn.netmoon.test;

import java.io.FileOutputStream;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class TestPdf {

	public static void main(String[] args) {
		try{
			
			BaseFont bfChinese =BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED); 
			Font textFont = new Font(bfChinese,15,Font.NORMAL);	
			
			//标题段落
			Paragraph headParagraph=new Paragraph("居住登记证明",new Font(bfChinese,20,Font.BOLD));
			headParagraph.setAlignment(Paragraph.ALIGN_CENTER);//居中
			headParagraph.setSpacingBefore(headParagraph.getFont().getSize());
			headParagraph.setSpacingAfter(headParagraph.getFont().getSize());
			
			//打印编号
			Paragraph dyParagraph=new Paragraph("2016年 第0001号",new Font(bfChinese,15,Font.NORMAL));
			dyParagraph.setAlignment(Paragraph.ALIGN_RIGHT);//右对齐
			dyParagraph.setSpacingBefore(1f);
			dyParagraph.setSpacingAfter(10f);
			
			//短语，构造证明主体内容
			Phrase ph = new Phrase();
			ph.setFont(textFont);
			ph.add("兹证明");
			ph.add(getUnderlineChunk(" 姓名 ",0.1f, -1f));
			ph.add("（性别");
			ph.add(getUnderlineChunk(" 女  ",0.1f, -1f));
			ph.add("，民族");
			ph.add(getUnderlineChunk(" 汉族 ",0.1f, -1f));
			ph.add("，出生日期");
			ph.add(getUnderlineChunk(" 1987年08月25 ",0.1f, -1f));
			ph.add("，身份证号码");
			ph.add(getUnderlineChunk(" 420106198708257767 ",0.1f, -1f));
			ph.add("，户籍所在地");
			ph.add(getUnderlineChunk(" 成都市高新区孵化园德商国际B座0701 ",0.1f, -1f));
			ph.add("，");
			ph.add(getUnderlineChunk(" 2016年05月04 ",0.1f, -1f));
			ph.add("在我辖区");
			ph.add(getUnderlineChunk("  成都市高新区孵化园德商国际B座0702 ",0.1f, -1f));
			ph.add("进行居住登记。");
						
			Paragraph paragraph=new Paragraph();
			paragraph.setFont(textFont);			
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);//左对齐
			paragraph.setFirstLineIndent(textFont.getSize()*2);//首行缩进
			paragraph.setLeading(textFont.getSize()*1.5f);//1.5倍行距
			paragraph.add(ph);
			
			Paragraph zmParagraph=new Paragraph();
			zmParagraph.setFont(textFont);			
			zmParagraph.setAlignment(Paragraph.ALIGN_LEFT);//左对齐
			zmParagraph.setFirstLineIndent(textFont.getSize()*2);//首行缩进
			zmParagraph.setLeading(textFont.getSize()*1.5f);//1.5倍行距
			zmParagraph.add("特此证明。");
			
			Paragraph jbrParagraph=new Paragraph();
			jbrParagraph.setFont(textFont);			
			jbrParagraph.setAlignment(Paragraph.ALIGN_RIGHT);//左对齐
			jbrParagraph.setLeading(textFont.getSize()*1.5f);//1.5倍行距
			jbrParagraph.setSpacingBefore(textFont.getSize()*3);
			jbrParagraph.add("经办人：姓名");
			
			Paragraph bmParagraph=new Paragraph();
			bmParagraph.setFont(textFont);			
			bmParagraph.setAlignment(Paragraph.ALIGN_RIGHT);//左对齐
			bmParagraph.setLeading(textFont.getSize()*1.5f);//1.5倍行距
			bmParagraph.add("什么事嘛什么事嘛什么事嘛部门");
			
			Paragraph rqParagraph=new Paragraph();
			rqParagraph.setFont(textFont);			
			rqParagraph.setAlignment(Paragraph.ALIGN_RIGHT);//左对齐
			rqParagraph.setLeading(textFont.getSize()*1.5f);//1.5倍行距
			rqParagraph.add("2016 年 3 月 22 日");
			
			
			Document document = new Document();
			document.setPageSize(PageSize.A4);// 设置页面大小
			PdfWriter.getInstance(document, new FileOutputStream("D:/Hello.pdf"));
			document.open();
			document.add(headParagraph);
			document.add(dyParagraph);
			document.add(paragraph);
			document.add(zmParagraph);
			document.add(jbrParagraph);
			document.add(bmParagraph);
			document.add(rqParagraph);
			document.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static Chunk getUnderlineChunk(String text,float thickness,float yPosition){
		Chunk strike = new Chunk(text);
		strike.setUnderline(thickness, yPosition);
		return strike;
	}
}
